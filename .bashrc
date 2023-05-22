if [[ $CLIENT == "" ]]; then
  CLIENT=`grep -oP "(?<=\[)[a-z]*(?=\])" ~/.bashrc`
fi
if [[ ${EUID} == 0 ]]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi
if [[ $CLIENT != "" ]]; then
  PS1="\[\][$CLIENT]\[\] $PS1"
fi

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then . /etc/bash_completion ; fi
export PATH=$SSHHOME:$SSHHOME/bin:$PATH:~/bin
#alias
export VIMINIT="let \$MYVIMRC='$SSHHOME/.vimrc' | source \$MYVIMRC"
alias mc='mc -b'
alias gitadd='git add . && git commit -m "item $RANDOM" && git push origin HEAD'
alias dig='dig +noall +answer'
alias bc='bc -l'
alias ssh='sshrc'
complete -o default -F __start_kubectl k

alias k="sudo kubectl --kubeconfig=/root/.kube/config"
alias kubectl="sudo kubectl --kubeconfig=/root/.kube/config"
alias linstor='kubectl exec -n d8-linstor deploy/linstor-controller -- linstor'
alias k.get.events="kubectl get events --sort-by=.metadata.creationTimestamp"
alias k.get.pod="kubectl get pods -A -o wide"
alias k.get.pod.bad="kubectl get pods -A -o wide | grep -v Running | grep -v Completed"
alias k.get.nodes="kubectl get nodes -o wide"
alias k.get.grafana="kubectl -n d8-monitoring get ing grafana -ojson | jq -r .spec.rules[0].host"
alias k.get.limit="kubectl -n d8-monitoring exec -it prometheus-main-0 -- curl localhost:9090/api/v1/targets | jq -r '.data.activeTargets[] | select(.lastError==\"sample limit exceeded\") | {labels,scrapeUrl}'"

alias k.get.machine="kubectl get machine -A"
alias k.get.machine.bad="kubectl get machine -A | grep -v Running"
alias k.get.deckhouse.queue.main="kubectl -n d8-system exec -i deploy/deckhouse -- deckhouse-controller queue main"
alias k.get.deckhouse.queue.list="kubectl -n d8-system exec -i deploy/deckhouse -- deckhouse-controller queue list"
