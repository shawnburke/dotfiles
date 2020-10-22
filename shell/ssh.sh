eval $(ssh-agent) >/dev/null

if [ -d ~/.ssh ]
then 
   # Get all keys that start with id_ in .ssh dir, add to ssh-add. ssh-add outputs to stderr, so we want to suppress
   # that or zsh/powershell will get mad.  Standard output is like "Identity added..."
   find ~/.ssh -maxdepth 1 -name "id_*" -type f ! -name "*.*" | xargs -I S ssh-add -A S 2>/dev/null 
fi
