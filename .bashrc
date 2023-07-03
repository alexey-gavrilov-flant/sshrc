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
HISTSIZE=30000
HISTFILESIZE=40000

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
  complete -o default -F __start_kubectl k
fi
export PATH=$SSHHOME:$SSHHOME/bin:/opt/deckhouse/bin/:$PATH:~/bin
#alias
export VIMINIT="let \$MYVIMRC='$SSHHOME/.vimrc' | source \$MYVIMRC"
alias mc='mc -b'
alias gitadd='git add . && git commit -s -m "item $RANDOM" && git push origin HEAD'
alias dig='dig +noall +answer'
alias bc='bc -l'
alias ssh='sshrc'

if [ -f /opt/deckhouse/bin/kubectl ]; then
  alias k="sudo /opt/deckhouse/bin/kubectl --kubeconfig=/root/.kube/config"
  alias kubectl="sudo /opt/deckhouse/bin/kubectl --kubeconfig=/root/.kube/config"
else
  alias k="sudo kubectl --kubeconfig=/root/.kube/config"
  alias kubectl="sudo kubectl --kubeconfig=/root/.kube/config"
fi

alias linstor='kubectl exec -n d8-linstor deploy/linstor-controller -- linstor'
alias k.get.events="kubectl get events --sort-by=.metadata.creationTimestamp"
alias k.get.pod="kubectl get pods -A -o wide"
alias k.get.pod.bad="kubectl get pods -A -o wide | awk 'split(\$3, arr, \"/\") && (arr[1] != arr[2]) {print \$0}' | grep -v Completed"
alias k.get.nodes="kubectl get nodes -o wide"
alias k.get.ng.bad="k get ng | awk '(\$4 != \$5) {print \$0}'"
alias k.get.grafana="kubectl -n d8-monitoring get ing grafana -ojson | jq -r .spec.rules[0].host | awk '{print \"echo \" \$1 \"; dig +noall +answer \" \$1 }' | bash"
alias k.get.limit="kubectl -n d8-monitoring exec -it prometheus-main-0 -- curl localhost:9090/api/v1/targets | jq -r '.data.activeTargets[] | select(.lastError==\"sample limit exceeded\") | {labels,scrapeUrl}'"

alias k.get.machine="kubectl get machine -A"
alias k.get.machine.bad="kubectl get machine -A | grep -v Running"
alias k.get.clusteralerts="kubectl get clusteralerts"
alias k.dhctl.terraform.check="kubectl -n d8-system exec -ti deploy/terraform-auto-converger -- dhctl terraform check --kube-client-from-cluster"
alias k.dhctl.get.cluster-configuration="kubectl -n kube-system get secrets d8-cluster-configuration  -o jsonpath='{.data.cluster-configuration\\.yaml}' | base64 -d"
alias k.dhctl.edit.cluster-configuration="kubectl -n d8-system exec -ti deploy/terraform-auto-converger -- dhctl config edit cluster-configuration --kube-client-from-cluster"
alias k.dhctl.get.provider-cluster-configuration="kubectl -n kube-system get secrets d8-provider-cluster-configuration -o jsonpath='{.data.cloud-provider-cluster-configuration\\.yaml}' | base64 -d"
alias k.dhctl.edit.provider-cluster-configuration="kubectl -n d8-system exec -ti deploy/terraform-auto-converger -- dhctl config edit provider-cluster-configuration --kube-client-from-cluster"

alias k.get.deckhouse.queue.main="kubectl -n d8-system exec -i deploy/deckhouse -- deckhouse-controller queue main"
alias k.get.deckhouse.queue.list="kubectl -n d8-system exec -i deploy/deckhouse -- deckhouse-controller queue list | grep -v \"^- /\""
alias k.get.metrics.https="TOKEN=\$(k -n d8-monitoring get secrets prometheus-token -ojsonpath='{.data.token}' | base64 -d) && curl -H \"Authorization: Bearer \${TOKEN}\" -k"
alias k.get.dns="echo certSANs && k get mc control-plane-manager -ojsonpath='{.spec.settings.apiserver.certSANs}' | jq . && echo clusterDomainAliases && k get mc kube-dns -ojsonpath='{.spec.settings.clusterDomainAliases}' | jq . && k -n kube-system get secrets d8-cluster-configuration -ojsonpath='{.data.cluster-configuration\.yaml}' | base64 -d | grep clusterDomain && k -n kube-system get pod -l k8s-app=kube-dns -ojson | jq -r '.items[].status.podIP | \"dig -p 5353 @\"+.'"
