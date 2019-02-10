#!/bin/bash

mkdir -p "$HOME/test"

echo -n > "$HOME/test/list"
for entry in $(ls -A "$HOME")
do
  type="FILE"
  if [ -d "$HOME/$entry" ]
  then type="DIR"
  fi
  echo "$type $entry" >> "$HOME/test/list"
done

mkdir -p "$HOME/test/links"
ln -f "$HOME/test/list" "$HOME/test/links/list_link"
rm "$HOME/test/list"
cat "$HOME/test/links/list_link"
read -p "Press ENTER..."
ln -f "$HOME/test/links/list_link" "$HOME/list1"

find "/etc" -iname "*.conf" -type f > "$HOME/list_conf"
find "/etc" -iname "*.d" -type d > "$HOME/list_d"
cat "$HOME/list_conf" "$HOME/list_d" > "$HOME/list_conf_d"
ln -sf "$HOME/list_conf_d" "$HOME/test/links/list_conf_d_link"
ln -f "$HOME/list1" "$HOME/test/links/links_list1"
less "$HOME/test/links/list_conf_d_link"

mkdir -p "$HOME/test/.sub"
cp "$HOME/list_conf_d" "$HOME/test/.sub"
cp --backup "$HOME/list_conf_d" "$HOME/test/.sub"
mv "$HOME/test/.sub/list_conf_d" "$HOME/test/.sub/list_etc"
rm "$HOME/list_conf_d"
cat "$HOME/test/links/list_conf_d_link"

cal -y 2012 > "$HOME/test/calendar.txt"
sed -n '2,8 p' "$HOME/test/calendar.txt"

find "$HOME/test"
read -p "Press ENTER..."
links_number=$(ls -l "$HOME/test/links/list_link" | cut -d " " -f 2)
echo "Number of links of 'list_link' is $links_number"
read -p "Press ENTER..."

man man > "$HOME/man.txt"
split --bytes=1K "$HOME/man.txt" "$HOME/man.txt."
mkdir -p "$HOME/man.dir"
mv "$HOME/man.txt."* "$HOME/man.dir"
cat "$HOME/man.dir/man.txt."* > "$HOME/man.dir/man.txt"

cmp "$HOME/man.dir/man.txt" "$HOME/man.txt"
if [[ "$?" -eq 0 ]]
then echo "OK, files are the same"
fi
read -p "Press ENTER..."

sed -i "1i hey!" "$HOME/man.txt"
sed -i "1a what's up?" "$HOME/man.txt"
echo "root" >> "$HOME/man.txt"
echo "123654" >> "$HOME/man.txt"
echo "see ya!" >> "$HOME/man.txt"
diff "$HOME/man.dir/man.txt" "$HOME/man.txt" > "$HOME/man.dir/diff.man.txt"
patch "$HOME/man.dir/man.txt" "$HOME/man.dir/diff.man.txt"

cmp "$HOME/man.txt" "$HOME/man.dir/man.txt"
if [[ "$?" -eq 0 ]]
then echo "OK, files are the same after patching"
fi
read -p "Press ENTER..."

rm -r "$HOME/test" "$HOME/man.dir" "$HOME/list1" "$HOME/list_conf" "$HOME/list_d" "$HOME/man.txt"
