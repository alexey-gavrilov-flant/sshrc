if [[ $CLIENT == "" ]]; then
  if [ -f ~/.bashrc ]; then
    CLIENT=`grep -oP "(?<=\[)[a-z-]*(?=\])" ~/.bashrc`
  fi
fi
#PS1
SCREEN="\[\033[01;31m\][ssh]";
if [ -n "${KUBERNETES_PORT}" ]; then SCREEN="\[\033[01;31m\][exec]"; fi
comm=$(cat /proc/$(ps -o ppid:1= -p $$)/comm)
if [[ "$comm" == "screen" ]]; then SCREEN="[screen]"; fi
USER_PS="\[\033[01;32m\][\u"; if [[ ${EUID} == 0 ]]; then USER_PS="\[\033[01;31m\][\u"; fi
CLIENT_PS="$CLIENT."; if [[ $CLIENT == "" ]]; then CLIENT_PS=""; fi
PS1="\[\033[01;33m\][\$(date +%H:%M:%S -u)]$SCREEN$USER_PS@$CLIENT_PS\h]\[\033[01;34m\] \w \$\[\033[00m\] "

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=30000
HISTFILESIZE=40000

if [[ "${comm}" == "sshd" || "${comm}" == "containerd-shim" || "${comm}" == "screen" ]]; then
  if [[ "$SSHRCCLEANUP" != "" ]]; then
    trap "rm -rf $SSHRCCLEANUP; exit" 0
  fi
fi

export PATH=~/bin:/opt/deckhouse/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
else
  if [ -f /usr/share/bash-completion/bash_completion ] && ! shopt -oq posix; then
    . /usr/share/bash-completion/bash_completion
  fi
fi
if command -v kubectl &> /dev/null; then
  if [ ! -d ~/.kube ]; then mkdir ~/.kube; fi
  if [ ! -f ~/.kube/completion.bash.inc ]; then kubectl completion bash > ~/.kube/completion.bash.inc; fi
  if [ -f ~/.kube/completion.bash.inc ]; then
    . ~/.kube/completion.bash.inc
    complete -o default -F __start_kubectl k
  fi
fi
if command -v d8 &> /dev/null; then
  source <(d8 completion bash)
fi

export VIMINIT="let \$MYVIMRC='$SSHHOME/.vimrc' | source \$MYVIMRC"
export PATH=$SSHHOME/bin:$PATH
. $SSHHOME/.bash_aliases
if [ -f ~/.bashrc_local ]; then
  . ~/.bashrc_local
fi
