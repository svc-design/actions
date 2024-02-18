#!/bin/bash

export ENV=$1 TAG=$2

if [[ -z "$ENV" || -z "$TAG" ]] ; then
  echo "ENV and TAG can't be empty!!!"
  echo "example: kaniko_push.sh dev 20230301"
  exit 1

else
mkdir -p /kaniko/.docker
cat > /kaniko/.docker/config.json << EOF
{"auths":
  { "artifact.example.com":
     {
       "auth": "$(printf "%s:%s" "cpc-bot-rw" "${ARTI_RW}" | base64 | tr -d '\n')"
    }
  }
}
EOF
/kaniko/executor --context "${CI_BUILDS_DIR}/${CI_PROJECT_NAMESPACE}/${CI_PROJECT_NAME}" --dockerfile "Dockerfile" --destination "artifact.example.com/cpc-iac-docker-${ENV}-l/${CI_PROJECT_NAME}:${tag}"
fi
