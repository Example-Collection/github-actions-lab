#!/bin/bash

git config --global user.name sang-w0o
git config --global --add user.password $GHB_PAT

git clone $DEVOPS_REPO_URL .
cd ./k8s

# line to change: image: 598334522273.dkr.ecr.ap-northeast-2.amazonaws.com/planit_product:*
# change image tag to $COMMIT_HASH
sed -i "s/598334522273.dkr.ecr.ap-northeast-2.amazonaws.com\/planit_product:.*/598334522273.dkr.ecr.ap-northeast-2.amazonaws.com\/planit_product:$COMMIT_HASH/" planit-product-deployment.yaml

git checkout -b "deploy/$COMMIT_HASH"
git add .
git commit -m "Deploy product image(tag: $COMMIT_HASH)"

# Create pull request and request review to sang-w0o
gh pr create -B master -t "Deploy product image(tag: $COMMIT_HASH)" -m "Deploy product image(tag: $COMMIT_HASH)" -a @me