#!/bin/bash -eu

set -e
export PATH=$PATH:/usr/local/bin
export ENV=$1 TAG=$2

whereis jf
whereis docker

if [[ -z "$ENV" || -z "$TAG" ]] ; then
  echo "ENV and TAG can't be empty!!!"
  echo "example: jf_push.sh"
  exit 1
else
  echo "-------------------------Jfrog login start-------------------------"
  jf c add jfrog-cli --url=https://artifact.example.com --access-token=${ARTI_RW}  --overwrite=true --interactive=false
  echo "-------------------------Jfrog login complete-------------------------"
  echo "-------------------------Start the building process-------------------"
  docker build -t artifact.example.com/cpc-iac-docker-${ENV}-l/${CI_PROJECT_NAME}:${TAG} .
  echo "-------------------------Build complete-------------------------------"
  echo "-------------------------Pushing artifacts to jfrog artifact------------------------"
  jf docker push artifact.example.com/cpc-iac-docker-${ENV}-l/${CI_PROJECT_NAME}:${TAG}  --build-name=cpc-iac-${CI_JOB_NAME} --build-number=${CI_JOB_ID}
  jf rt bce cpc-iac-${CI_JOB_NAME} $CI_JOB_ID
  jf rt bp cpc-iac-${CI_JOB_NAME} $CI_JOB_ID
  echo "IMAGE ${CI_PROJECT_NAME}:${TAG} has updated to Jfrog"
  docker rmi -f $(docker images | grep ${TAG} | awk 'NR==1{print $3}')
  echo "IMAGE ${CI_PROJECT_NAME}:${TAG} has been cleaned up from runner"
fi
