#!/bin/bash
set -e
branch="$8"
source ./.github/workflows/scripts/package-extra.sh
branch_short=$(echo "$branch" | awk -F '/' '{ print $NF }')
echo "$branch" | grep release && tag_completed="${tag}"
echo "$branch" | grep release || tag_completed="${tag}_${branch_short}"

echo "branch :$branch"
echo "tag: ${tag}"
echo "branch_name: ${tag}_${branch_short}"
echo "final_tag: $tag_completed"

# # Add image name and ingress DNS name.
# export image="$2" tag="$3" dns="$4" 
# yq eval '.spec.template.spec.containers[0].image = "'"$image:$tag"'"' -i "$5"
# cat "$5"
# yq eval '.spec.rules[0].host = "'"$dns"'"' -i "$6"
# cat "$6"
# # Deploy apps in exists namespace, If not exists Create new namespace and apply manifest files.
# kubectl get namespace | grep -q "^$1" || kubectl create namespace "$1"
# kubectl apply -f "$7" --namespace="$1"
