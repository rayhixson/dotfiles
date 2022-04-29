function tfa() 
    if [ "$1" == "plan" ] || [ "$1" == "apply" ]; then
	terraform $1 -var-file=$HOME/rays_vars.tfvars
    else
	terraform $argv
    fi
end

function oe 
	open /Applications/Emacs.app
end

function log 
	set LIMIT=10
	if [ -n "$1" ]; then
		set LIMIT=$1
	fi

	git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
	#git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short --max-count=$LIMIT
end

function pgrep 
	ps -wax|grep $argv
end

function jtags 
	find . -name "*.java" |etags -o TAGS -
end

function ex 
	echo "export $1=$2"
	export $1=$2
end

function f 
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
end

function fig 
	if [ "$1" == "" ]; then
		echo "usage: "
		echo "f <filename>"
		echo "f <filenames> <arg>"
	else
		if [ "$2" != "" ]; then
			find . -type f -name "$1" -exec grep -l -i "$2" {} +
		else
			find . -name "$argv" 2>/dev/null
		fi
	fi
end

function clean 
    find . -name "*~" | xargs rm
    find . -name "\.#*" | xargs rm
    find $CHOCROOT/apps -regex ".*/*.log.[0-9]" -exec rm {} \;
end

function enw 
	/Applications/Emacs.app/Contents/MacOS/Emacs -nw --no-desktop $argv
end

function v 
    (cd ~/treetop/cloudrecipes
     vagrant ssh
    )
end

function startCtp 
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
end

function tags 
	(cd ~/dev/chockstone
	 rm .TAGS && find . -name "*.java" -exec etags -a -o .TAGS {} \;)
end

# validate json
validatejson() 
    "curl -s -X POST -d @swagger.json -H 'Content-Type:application/json' http://online.swagger.io/validator/debug"
end

rejib() 
    set VERSION=$1
    export BUILD_NUMBER=${VERSION} && ./gradlew :valutec-translator-svc:jib
end

setBuild() 
    export BUILD_NUMBER=$1
    sed -i bak "s/tag: \".*\"/tag: \"${BUILD_NUMBER}\"/" ~/dev/chockstone/deployment/vtt/values.yaml
end

setPods() 
    export POD_NAME_xrefsvc=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | grep xref)
    export POD_NAME_vtt=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | grep vtt)
    export POD_NAME_idsvc=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | grep id-svc)
end

logs() 
    set SVC=$1
    set POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | grep $SVC )
    kubectl logs ${POD_NAME} -c ${SVC}
end

jlogs() 
    set SVC=$1
    logs $SVC | grep '^{' | jq .message
end
