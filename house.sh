PRE_IFS=$IFS
IFS=$'\n'

path=$1
directories=$(find "$path" -maxdepth 1 -mindepth 1 -type d)
files=$(find "$path" -maxdepth 1 -mindepth 1 -type f)

for f in $files; do
  fn=$(basename "$f")
  for d in $directories; do
    dn=$(basename "$d")
    if [[ $fn = *"$dn"* ]]; then
      mv "$f" "$d"
    fi
  done
done

# for entry in /mnt/open/CravingExplorer/2018春/*; do
#   if [ -f "$entry" ]; then
#     entry_name=$(basename "$entry")
#     for dir in /mnt/open/CravingExplorer/2018春/*; do
#       if [ -d "$dir" ]; then
#         dir_name=$(basename "$dir")
#         if [[ $entry_name = *"$dir_name"* ]]; then
#           echo $dir_name
#           echo $entry_name
#           echo
#         fi
#       fi
#     done
#   fi
# done

IFS=$PRE_IFS
