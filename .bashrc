# .bashrc

PROMPT_COMMAND=

. ~/.bash_twoline_prompt.sh

export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad
# export LSCOLORS=ExFxBxDxCxegedabagacad

export HISTIGNORE="&:ls:[bf]g:exit:cu:h:cd*"
#export HISTFILE="~/.history_bash"
export HISTSIZE=1000000
export HISTFILESIZE=1000000
shopt -s histappend

if [ -n "$INSIDE_EMACS" ]; then
    export TERM=xterm-256color
fi

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

complete -C /usr/local/bin/terraform terraform

# terrform docs
source <(terraform-docs completion bash)

source ~/dotfiles/.my-shell-configs
