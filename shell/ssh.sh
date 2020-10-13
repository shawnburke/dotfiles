eval $(ssh-agent) >/dev/null

if [ -d ~/.ssh ]
then 
   # Get all keys that start with id_ in .ssh dir, add to ssh-add
   find . -name "id_*" -maxdepth 1 -type f ! -name "*.*"  | xargs -I S ssh-add S >/dev/null;
fi
