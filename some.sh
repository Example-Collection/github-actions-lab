#!/bin/bash

git config user.email "robbyra@gmail.com"
git config user.name "sang-w0o"
git config user.password $GHB_PAT

mkdir DEVOPS_FOLDER
git clone $DEVOPS_REPO_URL ./DEVOPS_FOLDER
cd ./DEVOPS_FOLDER/k8s

# line to change: image: 598334522273.dkr.ecr.ap-northeast-2.amazonaws.com/planit_product:*
# change image tag to $COMMIT_HASH
sed -i "s/598334522273.dkr.ecr.ap-northeast-2.amazonaws.com\/planit_product:.*/598334522273.dkr.ecr.ap-northeast-2.amazonaws.com\/planit_product:$COMMIT_HASH/" a.yaml

git checkout -b "deploy/$COMMIT_HASH"
git add .
git commit -m "Deploy product image(tag: $COMMIT_HASH)"

# Create pull request and request review to sang-w0o
gh pr create -B master -t "Deploy product image(tag: $COMMIT_HASH)" -m "Deploy product image(tag: $COMMIT_HASH)" -a @me