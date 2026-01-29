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
export MANPAGER="nvim +Man!"

zstyle :compinstall filename '/home/mjolk/.zshrc'
autoload -Uz compinit
compinit -i
_comp_options+=(globdots) # With hidden files
#source /opt/azure-cli/bin/az.completion.sh
autoload -Uz promptinit
promptinit
#alias vim="nvim"
alias gitsubmodule-master="git submodule foreach git checkout master"
alias gitsubmodule-all="git submodule foreach git pull"
alias grep="grep --color=auto"
alias ls="ls --color=auto"
alias ll="ls -lh"
alias tmux="tmux -2"
alias chromedev="google-chrome-stable --disable-web-security --user-data-dir=/home/mjolk/.local/share/chrome-insecure"
alias backuproot="sudo btrfs subvolume snapshot -r / /.snapshots/@root-`date +%F-%R`"
alias backuphome="sudo btrfs subvolume snapshot -r /home /.snapshots/@home-`date +%F-%R`"
alias nn="ninja"
alias sk="kitty +kitten ssh"
alias nv="nvim"
alias vim="nv"
alias azlogin="az login --tenant 44f1fa80-6912-4b2e-b20c-a67532346457"
#git_branch=$'\ue0a0'
git_branch=$'\ue725'
function git_prompt_info() {
	local ref
	ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
		ref=$(command git rev-parse --short HEAD 2> /dev/null) \
		ref=$(command git name-rev --tags --name-only $ref 2> /dev/null)	|| return 0
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

export XDG_CURRENT_DESKTOP=sway
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

export JAVA_OPTS="-Xmx26g"
export ANT_OPTS="-Xmx4g"
export MAVEN_OPTS="-Xmx4g"
#export LC_ALL="en_US.UTF-8"
export ANDROID_HOME=~/androidsdk
export ANDROID_NDK_HOME=~/androidsdk/ndk/28.0.12433566
export ANDROID_NDK_TOOLCHAIN_DIR=~/androidsdk/ndk/28.0.12433566 
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
#export SVN_EDITOR=vim
export GOMAXPROCS=32
export GOPATH=~/golocal
export GOOS=linux
export GOARCH=amd64
export GOROOT_BOOTSTRAP=/usr/local/go1.4
export RUSTICL_ENABLE=radeonsi
export KERAS_BACKEND="jax"
export HSA_OVERRIDE_GFX_VERSION=11.0.0
export OLLAMA_MODELS=/home/mjolk/documents/mllfs/ollama
export AMDGPU_TARGETS="gfx1100"
#export GOWORK=~/godev
export DOCKER_BUILDKIT=1
export CMAKE_CXX_COMPILER_LAUNCHER=ccache
export CMAKE_C_COMPILER_LAUNCHER=ccache
export LIBVIRT_DEFAULT_URI=qemu:///system
export CIRCUIT_DISCOVER=228.8.8.8:7711

function update_gotools() {
	declare -a arr=(
	# "github.com/ajstarks/svgo/benchviz"
	# "github.com/axw/gocov/gocov"
	# "github.com/cespare/prettybench"
	# "github.com/dougm/goflymake"
	# "github.com/golang/lint/golint"
	# "github.com/josharian/impl"
	# "github.com/kisielk/errcheck"
	# "github.com/kisielk/godepgraph"
	# "github.com/nsf/gocode"
	# "github.com/tools/godep"
	# "github.com/rogpeppe/godef"
	# "github.com/alecthomas/gometalinter"
	"golang.org/x/tools/cmd/..."
)
for i in "${arr[@]}"
do
	echo "$i"
	go get -u "$i"
done
}

function microcode_img() {
	cd ~
	mkdir -p kernel/x86/microcode #directory structure expected
	cat /lib/firmware/amd-ucode/microcode_amd*.bin > kernel/x86/microcode/AuthenticAMD.bin
	echo kernel/x86/microcode/AuthenticAMD.bin | bsdcpio -o -H newc -R 0:0 > amd-ucode.img
}

function clear_vimswap() {
	rm ~/.cache/vim/swap/%home%mjolk%*
}

function flac_2_mp3(){
	for a in ./*.flac; do
		< /dev/null ffmpeg -i "$a" -qscale:a 0 "${a[@]/%flac/mp3}"
	done
}

path=(
	/usr/local/{bin,sbin}
	/usr/local/go/bin
	$GOPATH/bin
	~/.yarn/bin
	~/androidcli/bin
	$ANDROID_HOME/platform-tools
  ~/.local/share/nvim/mason/bin
	$path
)

#recursive string replace
function rreplace() {
	git grep -l "$1" * | xargs -i@ sed -i "s|$1|$2|g" @
}

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
		git_added=$'\ue727'
	fi

	# Format deleted.
	if (( deleted > 0 )); then
		git_deleted=$'\U000f01b4'
	fi

	# Format modified.
	if (( modified > 0 )); then
		git_modified=$'\ue728'
	fi

	# Format renamed.
	if (( renamed > 0 )); then
		git_renamed=$'\uf4dc'
	fi

	if (( unmerged > 0 )); then
		git_unmerged=$'\ue725'
	fi

	# Format untracked.
	if (( untracked > 0 )); then
		git_untracked=$'\ue676'
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
		git_ahead=$'\ue726'
	fi

	# Format behind.
	behind="$ahead_and_behind[(w)2]"
	if (( behind > 0 )); then
		git_behind=$'\ue727'
	fi

	echo $git_ahead $git_behind
}


function addenv() {
	set -a
	[ -f "./$1" ] && . "./$1"
	set +a
}

kitty_path=~/.config/kitty
function kitty_save_session() {
    kitty @ ls > "${kitty_path}/kitty-dump.json"
    cat "${kitty_path}/kitty-dump.json" | python3 "${kitty_path}/kitty-save-session/kitty-convert-dump.py" > "${kitty_path}/${1}.session"
}

function kitty_start_session() {
    kitty --session "${kitty_path}/${1}.session" --detach
}

function run_rocm() {
DEV_PATH=$1
IMAGE=$2

docker run -it \
  --network=host \
  --device=/dev/kfd \
  --device=/dev/dri \
  --group-add=video \
  --ipc=host \
  --cap-add=SYS_PTRACE \
  --security-opt seccomp=unconfined \
  --shm-size 128G \
  --entrypoint /bin/bash \
  -v $DEV_PATH:/home/mjolk $IMAGE
}

function grim_w() {
  NAME=$1

grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" "${HOME}/images/${NAME}_$(date +%Y_%m_%d_%I_%M_%p).png"
} 

#[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)
source <(fzf --zsh)

#cmake stuff
function build() {
DIR="build/$1"
BUILD_TYPE="$2"
SHARED="$3"

rm -rf "$DIR"
mkdir -p "$DIR"
cmake -S. -B"$DIR" -DCMAKE_BUILD_TYPE="$BUILD_TYPE" -DBUILD_SHARED_LIBS="$SHARED" -GNinja
}

#hugepages
function htlb() {
  SIZE="$1"

 sudo sysctl -w vm.nr_hugepages=$SIZE
}

