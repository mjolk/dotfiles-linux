setopt prompt_subst
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
unsetopt beep
bindkey -v

# vi mode cli
ZLE_RPROMPT_INDENT=0
right_arr=$'\ue0b1'
right_arr_b=$'\ue0b0'
left_arr=$'\ue0b3'
left_arr_b=$'\ue0b2'
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%B%F{red} $left_arr NORMAL $left_arr%f%b"
    VP="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

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
#RPROMPT='$VP %F{blue}$(git_ahead_behind) $(git_current_status) $(git_prompt_info)%f %F{green}$git_branch%f'
RPROMPT='$VP %F{blue}$(git_ahead_behind) $(git_current_status) $(git_prompt_info)%f %F{green}$git_branch%f'
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
alias grep="grep --color=auto"
alias ls="ls --color=auto"
alias ll="ls -l"
alias tmux="tmux -2"
alias chromedev="chromium --disable-web-security --user-data-dir"
alias backuproot="sudo btrfs subvolume snapshot -r / /.snapshots/@root-`date +%F-%R`"
alias backuphome="sudo btrfs subvolume snapshot -r /home /.snapshots/@home-`date +%F-%R`"

#recursive string replace
function rreplace() {
  grep -rli "$1" * | xargs -i@ sed -i "s/$1/$2/g" @
}

###-begin-ng-completion###
#

# ng command completion script
#   This command supports 3 cases.
#   1. (Default case) It prints a common completion initialisation for both Bash and Zsh.
#      It is the result of either calling "ng completion" or "ng completion -a".
#   2. Produce Bash-only completion: "ng completion -b" or "ng completion --bash".
#   3. Produce Zsh-only completion: "ng completion -z" or "ng completion --zsh".
#
# Usage: . <(ng completion --bash) # place it appropriately in .bashrc or
#        . <(ng completion --zsh) # find a spot for it in .zshrc
#
_ng_completion () {
  local words cword opts
  read -Ac words
  read -cn cword
  let cword-=1

  case $words[cword] in
    ng|help) opts="--version -v b build completion doc e e2e eject g generate get help l lint n new s serve server set t test v version xi18n" ;;
   b|build) opts="--aot --app --base-href --build-optimizer --common-chunk --delete-output-path --deploy-url --environment --extract-css --extract-licenses --i18n-file --i18n-format --locale --missing-translation --named-chunks --output-hashing --output-path --poll --preserve-symlinks --progress --show-circular-dependencies --sourcemaps --stats-json --target --vendor-chunk --verbose --watch -a -aot -bh -buildOptimizer -cc -d -dop -e -ec -extractLicenses -i18nFile -i18nFormat -locale -missingTranslation -nc -oh -op -poll -pr -preserveSymlinks -scd -sm -statsJson -t -v -vc -w" ;;
   completion) opts="--all --bash --zsh -a -b -z" ;;
   doc) opts="--search -s" ;;
   e|e2e) opts="--aot --app --base-href --build-optimizer --common-chunk --config --delete-output-path --deploy-url --disable-host-check --element-explorer --environment --extract-css --extract-licenses --hmr --host --i18n-file --i18n-format --live-reload --locale --missing-translation --named-chunks --open --output-hashing --output-path --poll --port --preserve-symlinks --progress --proxy-config --public-host --serve --serve-path --show-circular-dependencies --sourcemaps --specs --ssl --ssl-cert --ssl-key --target --vendor-chunk --verbose --watch --webdriver-update -H -a -aot -bh -buildOptimizer -c -cc -d -disableHostCheck -dop -e -ec -ee -extractLicenses -hmr -i18nFile -i18nFormat -live-reload-client -locale -lr -missingTranslation -nc -o -oh -op -p -pc -poll -pr -preserveSymlinks -s -scd -servePath -sm -sp -ssl -sslCert -sslKey -t -v -vc -w -wu" ;;
   eject) opts="--aot --app --base-href --build-optimizer --common-chunk --delete-output-path --deploy-url --environment --extract-css --extract-licenses --force --i18n-file --i18n-format --locale --missing-translation --named-chunks --output-hashing --output-path --poll --preserve-symlinks --progress --show-circular-dependencies --sourcemaps --target --vendor-chunk --verbose --watch -a -aot -bh -buildOptimizer -cc -d -dop -e -ec -extractLicenses -force -i18nFile -i18nFormat -locale -missingTranslation -nc -oh -op -poll -pr -preserveSymlinks -scd -sm -t -v -vc -w" ;;
   g|generate) opts="--app --collection --dry-run --force --lint-fix -a -c -d -f -lf" ;;
   get) opts="--global -global" ;;
   help) opts="--short -s" ;;
   l|lint) opts="--fix --force --format --type-check -fix -force -t -typeCheck" ;;
   n|new) opts="--collection --dry-run --link-cli --skip-commit --skip-git --skip-install --verbose -c -d -lc -sc -sg -si -v" ;;
   s|serve|server) opts="--aot --app --base-href --build-optimizer --common-chunk --delete-output-path --deploy-url --disable-host-check --environment --extract-css --extract-licenses --hmr --host --i18n-file --i18n-format --live-reload --locale --missing-translation --named-chunks --open --output-hashing --output-path --poll --port --preserve-symlinks --progress --proxy-config --public-host --serve-path --show-circular-dependencies --sourcemaps --ssl --ssl-cert --ssl-key --target --vendor-chunk --verbose --watch -H -a -aot -bh -buildOptimizer -cc -d -disableHostCheck -dop -e -ec -extractLicenses -hmr -i18nFile -i18nFormat -live-reload-client -locale -lr -missingTranslation -nc -o -oh -op -p -pc -poll -pr -preserveSymlinks -scd -servePath -sm -ssl -sslCert -sslKey -t -v -vc -w" ;;
   set) opts="--global -g" ;;
   t|test) opts="--app --browsers --code-coverage --colors --config --environment --log-level --poll --port --progress --reporters --single-run --sourcemaps --watch -a -browsers -c -cc -colors -e -logLevel -poll -port -progress -reporters -sm -sr -w" ;;
   --version|-v|v|version) opts="--verbose -verbose" ;;
   xi18n) opts="--app --i18n-format --locale --out-file --output-path --progress --verbose -a -f -l -of -op -progress -verbose" ;;
   *) opts="" ;;
  esac

  setopt shwordsplit
  reply=($opts)
  unset shwordsplit
}

compctl -K _ng_completion ng
###-end-ng-completion###
function git_current_status() {
    local git_added
    local git_deleted
    local git_modified
    local git_renamed
    local git_unmerged
    local git_untracked
    local deleted=0
    local modified=0
    local added=0
    local renamed=0
    local unmerged=0
    local untracked=0

# Get current status.
    status_cmd="git status --porcelain"
    while IFS=$'\n' read line; do
      # Count added, deleted, modified, renamed, unmerged, untracked, dirty.
      # T (type change) is undocumented, see http://git.io/FnpMGw.
      # For a table of scenarii, see http://i.imgur.com/2YLu1.png.
      [[ "$line" == ([ACDMT][\ MT]|[ACMT]D)\ * ]] && (( added++ ))
      [[ "$line" == [\ ACMRT]D\ * ]] && (( deleted++ ))
      [[ "$line" == ?[MT]\ * ]] && (( modified++ ))
      [[ "$line" == R?\ * ]] && (( renamed++ ))
      [[ "$line" == (AA|DD|U?|?U)\ * ]] && (( unmerged++ ))
      [[ "$line" == \?\?\ * ]] && (( untracked++ ))
      (( dirty++ ))
    done < <(${(z)status_cmd} 2> /dev/null)

    # Format added.
    if (( added > 0 )); then
      git_added=$'\u2731'
    fi

    # Format deleted.
    if (( deleted > 0 )); then
      git_deleted=$'\u2718'
    fi

    # Format modified.
    if (( modified > 0 )); then
      git_modified=$'\u2714'
    fi

    # Format renamed.
    if (( renamed > 0 )); then
      git_renamed=$'\u0040'
    fi

    if (( unmerged > 0 )); then
     git_unmerged=$'\u2716'
    fi

    # Format untracked.
    if (( untracked > 0 )); then
     git_untracked=$'\u25cf'
    fi

    echo $git_added $git_deleted $git_modified $git_renamed $git_unmerged $git_untracked
}

function git_ahead_behind() {
    local ahead=0
    local behind=0
    local git_ahead
    local git_behind
    # Gets the commit difference counts between local and remote.
    ahead_and_behind_cmd='git rev-list --count --left-right HEAD...@{upstream}'

    # Get ahead and behind counts.
    ahead_and_behind="$(${(z)ahead_and_behind_cmd} 2> /dev/null)"

    # Format ahead.
    ahead="$ahead_and_behind[(w)1]"
    if (( ahead > 0 )); then
      git_ahead=$'\u2b06'
    fi

    # Format behind.
    behind="$ahead_and_behind[(w)2]"
    if (( behind > 0 )); then
      git_behind=$'\u2b07'
    fi
    
    echo ${git_ahead} ${git_behind}
}
