if [[ $CLIENT == "" ]]; then
  CLIENT=`grep -oP "(?<=\[)[a-z-]*(?=\])" ~/.bashrc`
fi
#PS1
SCREEN="\[\033[01;31m\][ssh]"; if [[ $TERM == "screen" ]]; then SCREEN="[screen]"; fi
USER_PS="\[\033[01;32m\][\u"; if [[ ${EUID} == 0 ]]; then USER_PS="\[\033[01;31m\][\u"; fi
CLIENT_PS="$CLIENT."; if [[ $CLIENT == "" ]]; then CLIENT_PS=""; fi
PS1="\[\033[01;33m\][\$(date +%H:%M:%S -u)]$SCREEN$USER_PS@$CLIENT_PS\h]\[\033[01;34m\] \w \$\[\033[00m\] "

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=30000
HISTFILESIZE=40000

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
  complete -o default -F __start_kubectl k
fi
export PATH=$SSHHOME:$SSHHOME/bin:/opt/deckhouse/bin/:$PATH:~/bin

if [ -f /opt/deckhouse/bin/kubectl ]; then
  alias k="sudo /opt/deckhouse/bin/kubectl --kubeconfig=/root/.kube/config"
  alias kubectl="sudo /opt/deckhouse/bin/kubectl --kubeconfig=/root/.kube/config"
else
  alias k="sudo kubectl --kubeconfig=/root/.kube/config"
  alias kubectl="sudo kubectl --kubeconfig=/root/.kube/config"
fi

export VIMINIT="let \$MYVIMRC='$SSHHOME/.vimrc' | source \$MYVIMRC"
. $SSHHOME/.bash_aliases
