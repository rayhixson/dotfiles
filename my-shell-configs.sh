#!/bin/bash
# keep this generic to either zsh or bash

# OH MY ZSH noisy
export DISABLE_UPDATE_PROMPT=true

export ESHELL=/bin/bash

export AWS_SDK_LOAD_CONFIG=True

# For GOOGLE GCP Command Line
export TOKENFILE=~/gcp/chockstone-qa-1.admin.key

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export MYSQLHOME=/usr/local/mysql
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin:$MYSQLHOME/bin"

export QAPROPS=props/rays.properties
export APPURL=http://localhost:9091/svc/appmap/apps-local.xml
export APP=gary-cloud
export CTPSVC=ctp
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
export CHOCROOT=$HOME/dev/chockstone
export CHOCTOP=~/dev/chockstone/apps/gke-messaging-ray/ctp

export PROJECT_ID=pid-gousgnad-aces-dev-ray
export ENGAGE_DOCKER_REPO="us-docker.pkg.dev/$PROJECT_ID/us-engage-internal-images"
export SPECTRE_DOCKER_REPO="us-docker.pkg.dev/pid-gousgnad-aces-dev-mobile/us-spectre-internal-images"
export JOB_BASE_NAME=ray
#export CLUSTER_NAME=dev-engage-chockstone
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/gcp/pid-gousgnad-aces-dev-ray-44bcee93ab5e.json

export HD=~/homedepot/ray

# these affect the version.txt files generated for aladding viewing
export JOB_NAME="RaysLocal"

export PATH="$JAVA_HOME/bin:~/.pyenv/shims:$PATH:$HOME/dev/google-cloud-sdk/bin"

#export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# use this for minikube repo instead of local docker
# eval $(minikube docker-env)

alias ls="ls -hF"
alias ll="ls -lhF"
alias la="ls -lAhF"
# alias h="history 40 |awk '{print \$2\" \"\$3\" \"\$4\" \"\$5\" \"\$6\" \"\$7\" \"\$8\" \"\$9}'"
alias h="history"
alias gs="git status"
alias gd="git dump"
alias grep="grep --color=auto"
alias giv="/usr/local/go/bin/go install -v"

alias ecr-login='aws ecr get-login --no-include-email --region us-east-1 |sh'
alias docker-debug='docker run -P -i -t --rm --env OPENV=dev --env CONSUL_PARAMS="-retry-join 192.168.2.6" batch-svc:latest'
alias d=docker
alias dc="docker container"

alias meghanada-server="java -XX:+UseConcMarkSweepGC -XX:SoftRefLRUPolicyMSPerMB=50 -Xverify:none -Xms256m -Dfile.encoding=UTF-8 -jar dev/meghanada-server/server/build/libs/meghanada-1.3.0.jar"

alias tf="terraform"
alias tv='terraform -var="credentials_file=~/gcp/pid-gousgnad-aces-dev-ray-god-6522570c9132.json"'
alias tfdebug="TF_LOG=TRACE terraform $argv"
alias gbs="gcloud beta services"
alias kc="kubectl"
alias sk="skaffold"

alias ssh-onprem='gcloud beta compute ssh chockstone-onprem-test --zone us-east1-b --tunnel-through-iap -- -o "ServerAliveInterval=120"'

alias gw='./gradlew -Dorg.gradle.java.home=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'
