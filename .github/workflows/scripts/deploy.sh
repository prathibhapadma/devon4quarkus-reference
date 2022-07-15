#!/bin/bash
set -e
# Add image name and ingress DNS name.
export image="$2" tag="$3" dns="$4" 
yq eval '.spec.template.spec.containers[0].image = "'"$image:$tag"'"' -i "$5"
cat "$5"
yq eval '.spec.rules[0].host = "'"$dns"'"' -i "$6"
cat "$6"
# Deploy apps in exists namespace, If not exists Create new namespace and apply manifest files.
kubectl get namespace | grep -q "^$1" || kubectl create namespace "$1"
kubectl apply -f "$7" --namespace="$1"
