#!/bin/bash

git config --global user.email "robbyra@gmail.com"
git config --global user.name "sang-w0o"
git config --global user.password $GHB_PAT

mkdir DEVOPS_FOLDER
cd ./DEVOPS_FOLDER
git clone $DEVOPS_REPO_URL ./DEVOPS_FOLDER
cd ./k8s

# line to change: image: 598334522273.dkr.ecr.ap-northeast-2.amazonaws.com/planit_product:*
# change image tag to $COMMIT_HASH
sed -i "s/598334522273.dkr.ecr.ap-northeast-2.amazonaws.com\/planit_product:.*/598334522273.dkr.ecr.ap-northeast-2.amazonaws.com\/planit_product:$COMMIT_HASH/" a.yaml

git remote set-url origin $DEVOPS_REPO_URL
git checkout -b "deploy/$COMMIT_HASH"
git add .
git commit -m "Deploy product image(tag: $COMMIT_HASH)"
git push origin "deploy/$COMMIT_HASH"
# Create pull request and request review to sang-w0o
gh pr create -B master --title "Deploy product image(tag: $COMMIT_HASH)" --body "Deploy product image(tag: $COMMIT_HASH)" -a "@me"