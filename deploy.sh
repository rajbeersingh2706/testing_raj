#!/bin/bash

# Installing Kubectl 
curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
kubectl version --short --client 
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_REGION
aws eks list-clusters


# install IAM Authenticator
curl -o aws-iam-authenticator  https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
aws eks update-kubeconfig --name eks-sbx-cluster
kubectl get svc


CIRCLE_SHA1=$1
# Applying the New Image to Kubernetes
if kubectl describe deployment/nginx-deployment; then
  echo "if Condition not exist"
  kubectl set image deployment nginx-deployment nginx=nginx:$CIRCLE_SHA1 --record
else
   echo "Does not Exit"
   kubectl create -f nginx.yaml --record
fi