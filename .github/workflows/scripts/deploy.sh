#!/bin/bash
set -e
# Add image name and ingress DNS name.
# source "$7"
. "$7"
# we get what is located after the last '/' in the branch name, so it removes /ref/head or /ref/head/<folder> if your branche is named correctly"
branch_short=$(echo "$8" | awk -F '/' '{ print $NF }')

# We change the name of the tag depending if it is a release or another branch
echo "tag_completed: $8" | grep release && tag_completed="${tag}"
echo "tag_completed_branch: $8" | grep release || tag_completed="${tag}_${branch_short}"

export image="$2" tag="${tag}" dns="$3"
echo "tag:$tag"
yq eval '.spec.template.spec.containers[0].image = "'"$image:$tag"'"' -i "$4"
cat $4
yq eval '.spec.rules[0].host = "'"$dns"'"' -i "$5"
cat $5
# Deploy apps in exists namespace, If not exists Create new namespace and apply manifest files.
kubectl get namespace | grep -q "^$1" || kubectl create namespace "$1"
kubectl apply -f "$6" --namespace="$1"
