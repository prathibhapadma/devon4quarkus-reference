#!/bin/bash
set -e
# Add image name and ingress DNS name.
source "$7"
export image="$2" tag="${tag}" dns="$3"
yq eval '.spec.template.spec.containers[0].image = "'"$image:$tag"'"' -i "$4"
cat $4
yq eval '.spec.rules[0].host = "'"$dns"'"' -i "$5"
cat $5
# Deploy apps in exists namespace, If not exists Create new namespace and apply manifest files.
kubectl get namespace | grep -q "^$1" || kubectl create namespace "$1"
kubectl apply -f "$6" --namespace="$1"
