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

IFS=$PRE_IFS
