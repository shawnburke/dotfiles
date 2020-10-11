eval $(ssh-agent) >/dev/null

if [ -d ~/.ssh ]
then
    find ~/.ssh/ -name 'id_rsa*' -not  -name "*.pub" | xargs -I S ssh-add S 2&>/dev/null;
fi