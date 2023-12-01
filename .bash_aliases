#alias
alias mc='mc -b'
alias gitadd='git add . && git commit -s -m "item $RANDOM" && git push origin HEAD'
alias dig='dig +noall +answer'
alias bc='bc -l'
alias ssh='sshrc'

alias helm="sudo helm"
alias k.get.events="kubectl get events --sort-by=.metadata.creationTimestamp"
alias k.get.pod="kubectl get pods -A -o wide"
#alias k.get.pod.bad="kubectl get pods -A -o wide | awk 'split(\$3, arr, \"/\") && (arr[1] != arr[2]) {print \$0}' | grep -v Completed"
alias k.get.pod.bad="kubectl get pods -A -o wide | grep -Pv '\s+([1-9]+[\d]*)\/\1\s+' | grep -v 'Completed\|Evicted'"
alias k.get.pod.bad.d8="kubectl get pods -A -o wide | grep -Pv '\s+([1-9]+[\d]*)\/\1\s+' | grep -v 'Completed\|Evicted' | grep -E \"^(d8-|kube-system)\""
alias k.get.nodes="kubectl get nodes -o wide"
alias k.get.ng.bad="k get ng | awk '(\$4 != \$5) {print \$0}'"
alias k.get.grafana="kubectl -n d8-monitoring get ing grafana -ojson | jq -r .spec.rules[0].host | awk '{print \"echo \" \$1 \"; dig +noall +answer \" \$1 }' | bash"
alias k.get.limit="kubectl -n d8-monitoring exec -it prometheus-main-0 -- curl localhost:9090/api/v1/targets | jq -r '.data.activeTargets[] | select(.lastError==\"sample limit exceeded\") | {labels,scrapeUrl}'"
alias k.get.machine="kubectl get machine -A"
alias k.get.machine.bad="kubectl get machine -A | grep -v Running"
alias k.get.modules="kubectl get modules"
alias k.logs.deckhouse="kubectl -n d8-system logs deploy/deckhouse --tail=100 | jq ."
alias k.exec.deckhouse="kubectl -n d8-system exec -ti deploy/deckhouse -- bash"
alias k.dhctl.terraform.check="kubectl -n d8-system exec -ti deploy/terraform-auto-converger -- dhctl terraform check --kube-client-from-cluster"
alias k.dhctl.converge="kubectl -n d8-system exec -ti deploy/terraform-auto-converger -- dhctl converge"
alias k.dhctl.get.cluster-configuration="kubectl -n kube-system get secrets d8-cluster-configuration  -o jsonpath='{.data.cluster-configuration\\.yaml}' | base64 -d"
alias k.dhctl.edit.cluster-configuration="kubectl -n d8-system exec -ti deploy/deckhouse -- deckhouse-controller edit cluster-configuration"
alias k.dhctl.get.static-cluster-configuration="kubectl -n kube-system get secrets d8-static-cluster-configuration -o jsonpath='{.data.static-cluster-configuration\\.yaml}' | base64 -d"
alias k.dhctl.edit.static-cluster-configuration="kubectl -n d8-system exec -ti deploy/deckhouse -- deckhouse-controller edit static-cluster-configuration"
alias k.dhctl.get.provider-cluster-configuration="kubectl -n kube-system get secrets d8-provider-cluster-configuration -o jsonpath='{.data.cloud-provider-cluster-configuration\\.yaml}' | base64 -d"
alias k.dhctl.edit.provider-cluster-configuration="kubectl -n d8-system exec -ti deploy/deckhouse -- deckhouse-controller edit provider-cluster-configuration"

alias k.get.deckhouse.queue.main="kubectl -n d8-system exec -it deploy/deckhouse -- deckhouse-controller queue main"
alias k.get.deckhouse.queue.list="kubectl -n d8-system exec -it deploy/deckhouse -- deckhouse-controller queue list | grep -v \"^- /\""
alias k.get.metrics.https="TOKEN=\$(k -n d8-monitoring get secrets prometheus-token -ojsonpath='{.data.token}' | base64 -d) && curl -H \"Authorization: Bearer \${TOKEN}\" -k"
alias k.get.dns="echo certSANs && k get mc control-plane-manager -ojsonpath='{.spec.settings.apiserver.certSANs}' | jq . && echo clusterDomainAliases && k get mc kube-dns -ojsonpath='{.spec.settings.clusterDomainAliases}' | jq . && k -n kube-system get secrets d8-cluster-configuration -ojsonpath='{.data.cluster-configuration\.yaml}' | base64 -d | grep clusterDomain && k -n kube-system get pod -l k8s-app=kube-dns -ojson | jq -r '.items[].status.podIP | \"dig -p 5353 @\"+.'"
alias c.disk.usage="/opt/deckhouse/bin/crictl stats -o json | jq '.stats[] | select((.writableLayer.usedBytes.value | tonumber) > 1073741824) | { meta: .attributes.labels, id: .attributes.id ,  diskUsage: ((.writableLayer.usedBytes.value | tonumber) / 1073741824 * 100 | round / 100 | tostring + \" GiB\")}'"
