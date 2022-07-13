#!/bin/bash
set -e
# Add image name and ingress DNS name.
export image="$2" dns="$3"
yq eval '.spec.template.spec.containers[0].image = "'"$image"'"' -i "$4"
cat $4
yq eval '.spec.rules[0].host = "'"$dns"'"' -i "$5"
cat $5
#kubectl delete already existed namespace
namespaceStatus=$(kubectl get ns "$1" -o json | jq .status.phase -r)
if [ $namespaceStatus == "Active" ] 
then
    echo "Deploy app"
else
    #Create namespace in cluster.
    kubectl create namespace "$1"
fi
# Apply manifest files.
kubectl apply -f "$6" --namespace="$1"
