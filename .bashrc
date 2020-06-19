# .bashrc

PROMPT_COMMAND=

# Terminal colours (after installing GNU coreutils)
NM="[\033[0;38m]" # means no background and white lines
HI="[\033[0;37m]" # change this for letter colors
HII="[\033[0;31m]" # change this for letter colors
SI="[\033[0;33m]" # this is for the current directory
IN="[\033[0m]"

# Key repeat back on:
# defaults write -g ApplePressAndHoldEnabled -bool false

# export PS1="\$(date +%H%M) \u ${bold_on}\w${bold_off} > "
# export PS1="\$(date +%H%M) \u ${bold_on}\w${bold_off}\$(__git_ps1) > "
#export PS1="\[\033[36m\]\u\[\033[m\] \[\033[33;1m\]\w\[\033[m\] > "
. ~/.bash_twoline_prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true

export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad
# export LSCOLORS=ExFxBxDxCxegedabagacad

export ESHELL=$SHELL

export HISTIGNORE="&:ls:[bf]g:exit:cu:h:cd*"
export HISTFILE="~/.history_bash"
export HISTSIZE=1000000
export HISTFILESIZE=1000000
shopt -s histappend

#if [ -z "$INSIDE_EMACS" ]; then
#	bold_on="\[\033[01m\]"
#	bold_off="\[\033[0m\]"
#else
#	bold_on=
#	bold_off=
#	export PS1="\u \w > "
#fi

if [ "$TERM" = dumb ] && [ "$INSIDE_EMACS" ]; then
    export TERM=dumb-emacs-ansi COLORTERM=1
fi

export AWS_SDK_LOAD_CONFIG=True

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export MYSQLHOME=/usr/local/mysql
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin:$MYSQLHOME/bin"

export QAPROPS=props/rays.properties
export APPURL=http://localhost:9091/svc/appmap/apps-local.xml
export APP=minimal-ray
export CTPSVC=ctp
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
export CHOCROOT=$HOME/dev/chockstone
export CHOCTOP=$CHOCROOT/ctp-svc

# these affect the version.txt files generated for aladding viewing
export JOB_NAME="RaysLocal"

export PATH="$PATH:$HOME/dev/google-cloud-sdk/bin"

alias ls="ls -hF"
alias ll="ls -lhF"
alias la="ls -lAhF"
alias h="history 40 |awk '{print \$2\" \"\$3\" \"\$4\" \"\$5\" \"\$6\" \"\$7\" \"\$8\" \"\$9}'"
alias gs="git status"
alias gd="git dump"
alias grep="grep --color=auto"
alias giv="/usr/local/go/bin/go install -v"

alias ecr-login='aws ecr get-login --no-include-email --region us-east-1 |sh'
alias docker-debug='docker run -P -i -t --rm --env OPENV=dev --env CONSUL_PARAMS="-retry-join 192.168.2.6" batch-svc:latest'
alias d=docker
alias dc="docker container"

alias meghanada-server="java -XX:+UseConcMarkSweepGC -XX:SoftRefLRUPolicyMSPerMB=50 -Xverify:none -Xms256m -Dfile.encoding=UTF-8 -jar dev/meghanada-server/server/build/libs/meghanada-1.3.0.jar"

function tf() {
    if [ "$1" == "plan" ] || [ "$1" == "apply" ]; then
	terraform $1 -var-file=$HOME/rays_vars.tfvars
    else
	terraform $*
    fi
}

function oe {
	open /Applications/Emacs.app
}

function log {
	LIMIT=10
	if [ -n "$1" ]; then
		LIMIT=$1
	fi

	git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
	#git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short --max-count=$LIMIT
}

function pgrep {
	ps -wax|grep $*
}

function jtags {
	find . -name "*.java" |etags -o TAGS -
}

function ex {
	echo "export $1=$2"
	export $1=$2
}

function f {
    if [ "$1" == "" ]; then
	echo "usage: "
	echo "f <filename>"
	echo "f <filenames> <arg>"
    else
	if [ "$2" != "" ]; then
	    ag --group --line-number --smart-case -G $1 "$2" .
	else
	    ag --group --line-number --smart-case "$1" .
	fi
    fi
}

function fig {
	if [ "$1" == "" ]; then
		echo "usage: "
		echo "f <filename>"
		echo "f <filenames> <arg>"
	else
		if [ "$2" != "" ]; then
			find . -type f -name "$1" -exec grep -l -i "$2" {} +
		else
			find . -name "$*" 2>/dev/null
		fi
	fi
}

function re {
    . ~/.bashrc
}

function clean {
    find . -name "*~" | xargs rm
    find . -name "\.#*" | xargs rm
    find $CHOCROOT/apps -regex ".*/*.log.[0-9]" -exec rm {} \;
}

function xgrep {
	echo "perl -lne 'BEGIN{undef $/} while (/<tag>(.*?)<\/tag>/sg){print \$1}' FILENAME"
}

function enw {
	/Applications/Emacs.app/Contents/MacOS/Emacs -nw --no-desktop $*
}

function v {
    (cd ~/treetop/cloudrecipes
     vagrant ssh
    )
}

function startCtp {
    (
	cd $CHOCROOT/master
	./gradlew tarApps
	./gradlew :appmap-server:deploy :aladdin:deploy
	cd $CHOCROOT
	./bin/start-appmap.sh
	./bin/redeploy-genie.sh
	cd $CHOCROOT/aladdin
	./bin/run.sh
    )
}

# validate json
validatejson() {
    "curl -s -X POST -d @swagger.json -H 'Content-Type:application/json' http://online.swagger.io/validator/debug"
}

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

export NVM_DIR="/Users/ray/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

complete -C /usr/local/bin/terraform terraform
