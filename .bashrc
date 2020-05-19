# .bashrc

if [ -f ~/.keys ]; then
    . ~/.keys
fi

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

export HOMEBREW_GITHUB_API_TOKEN="e2bdad238fb5361fda018a9ab29bb424e78b5776"

export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad
# export LSCOLORS=ExFxBxDxCxegedabagacad

# for ttc admin:
export NODE_ENV=development

export LOGNAME=ray

export PGSQL_ROOT="/Applications/Postgres.app/Contents/Versions/10/bin"
export ELASTIC_URI="http://localhost:9200"
export PGSQL_HOME=/Applications/Postgres.app/Contents/Versions/10

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

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GODEBUG=cgocheck=0
export C_INCLUDE_PATH=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/libxml2
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
export BATCH_ELASTICURI="http://localhost:9200"

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

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
			find . -type f -iname "$1" -exec grep -l "$2" {} +
		else
			find . -iname "$*" 2>/dev/null
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
	find ~/go/src/github.com/treetopllc/gonoble/ext/cucumber/logs -type f -exec rm {} +;
	find . -iregex ".*gonoble-integration.[a-z][a-z][a-z]" -exec rm {} +;
}

function xgrep {
	echo "perl -lne 'BEGIN{undef $/} while (/<tag>(.*?)<\/tag>/sg){print \$1}' FILENAME"
}

function gocd {
	cd ~/go/src/github.com/treetopllc/$1
}

function enw {
	/Applications/Emacs.app/Contents/MacOS/Emacs -nw --no-desktop $*
}

function v {
    (cd ~/treetop/cloudrecipes
     vagrant ssh
    )
}

tcuc() {
    TRACE_REQUESTS="true" cucumber $*
}

cleancuc() {
    (cd ~/go/src/github.com/treetopllc/gonoble/ext/database;
     DB=noblegraph_clean make drop_db create_db clean_bootstrap)
    DB=noblegraph_clean cucumber $*
}

alias cuc="DB=noblegraph_clean cucumber -p norm $*"
alias cucre="DB=noblegraph_clean cucumber -p re $*"
alias cucint="DB=noblegraph_clean cucumber -p integration $*"
alias ll="ls -lhF"
alias la="ls -lAhF"
alias h="history 40 |awk '{print \$2\" \"\$3\" \"\$4\" \"\$5\" \"\$6\" \"\$7\" \"\$8\" \"\$9}'"
alias gs="git status"
alias gd="git dump"
alias grep="grep --color=auto"
# alias giv="/usr/local/go/bin/go install -ldflags=-s -v"
alias giv="/usr/local/go/bin/go install -v"
alias connect-staging="PGHOST=staging-pgsql.noblehour.com DBUSER=gonoble DB=noblegraph DBPASS=monkey1234 make connect"
alias makeddf="make distclean deps frontend"

alias setdns="sudo networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4"
alias do_i_need_to_do_this_again="VBoxManage guestproperty set \"cloudrecipes_default_1456952104473_15528\" \"/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold\" 1000"

alias run-sa="gulp serve-5000-only"

# validate json
validatejson() {
    "curl -s -X POST -d @swagger.json -H 'Content-Type:application/json' http://online.swagger.io/validator/debug"
}

export NVM_DIR="/Users/ray/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


alias connect-staging-db="ssh wikkit; ssh utility; cd gonoble/ext/database; rm pgpass && PGHOST=staging-pgsql.noblehour.com DBUSER=gonoble DB=noblegraph DBPASS=monkey1234 make pgpass connect"

alias ecr-login='aws ecr get-login --no-include-email --region us-east-1 |sh'
alias docker-debug='docker run -P -i -t --rm --env OPENV=dev --env CONSUL_PARAMS="-retry-join 192.168.2.6" batch-svc:latest'
alias d=docker
alias dc="docker container"

. ~/homedepot/ray/consul_ip.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
