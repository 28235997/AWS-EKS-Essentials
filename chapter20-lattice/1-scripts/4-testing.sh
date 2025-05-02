
#Use this commands to test the deployments -wait for at least 4 before you test
# kubectl get httproute
# kubectl get httproute color-route -o yaml
# colorFQDN=$(kubectl get httproute color-route -o json | jq -r '.metadata.annotations."application-networking.k8s.aws/lattice-assigned-domain-name"')
# echo "$colorFQDN"
#kubectl exec deploy/green -- curl -s $colorFQDN