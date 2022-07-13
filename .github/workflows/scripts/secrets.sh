#!/bin/bash
set -e
# Deploy apps in exists namespace, If not exists Create new namespace.
namespaceStatus=$(kubectl get ns "$1" -o json | jq .status.phase -r)
if [ $namespaceStatus == "Active" ] 
then
    echo "Deploy apps"
else
    kubectl create namespace "$1"
fi
# Command to delete existed secrets.
kubectl delete secret "$2" --namespace="$1" --ignore-not-found
# Command to create secrets to pull image from private registry.
kubectl create secret docker-registry "$2" --docker-server="$5" --docker-username="$3" --docker-password="$4" --namespace="$1"
# export secrets name and add secrets into deployment file.
export secrets="$2" 
yq e '.spec.template.spec."imagePullSecrets"=[{"name":"secrets"}]' -i "$6" 
yq e '.spec.template.spec.imagePullSecrets[0].name = "'"$secrets"'"' -i "$6"
# Apply the changes.
kubectl apply -f "$6" --namespace="$1"
