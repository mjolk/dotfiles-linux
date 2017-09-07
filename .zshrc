setopt prompt_subst
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
unsetopt beep
bindkey -v
zstyle :compinstall filename '/home/mjolk/.zshrc'
autoload -Uz compinit
compinit
autoload -Uz promptinit
promptinit
git_branch=$'\ue0a0'
function git_prompt_info() {
	local ref
	ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
		ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
	echo "${ref#refs/heads/}"
}
PROMPT='%F{blue}%1~%f %F{red}➜%f '
RPROMPT='%F{blue}$(git_prompt_info)%f %F{green}$git_branch%f'
# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

#export JAVA_OPTS="-Xms256m -Xmx1024m -XX:MaxPermSize=512m"
#export ANT_OPTS="-Xmx1024m"
#export MAVEN_OPTS="-Xms256m -Xmx1024m -XX:MaxPermSize=512m"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
#export SVN_EDITOR=vim
export GOROOT=/usr/local/go
export GOPATH=~/golocal
export GOOS=linux
export GOARCH=amd64
export GOROOT_BOOTSTRAP=/usr/local/go1.4
#export TERM=xterm-256color

path=(
  /usr/local/{bin,sbin}
  /usr/local/go/bin
  $GOPATH/bin
  ~/.npm-global/bin
  $path
)

#eval `keychain --eval --quiet id_rsa`
#alias vim="nvim"
alias ls="ls --color=auto"
alias ll="ls -l"
alias tmux="tmux -2"
alias chromedev="chromium --disable-web-security --user-data-dir"
alias backuproot="sudo btrfs subvolume snapshot -r / /.snapshots/@root-`date +%F-%R`"
alias backuphome="sudo btrfs subvolume snapshot -r /home /.snapshots/@home-`date +%F-%R`"
