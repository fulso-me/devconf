# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# fpath+=("$HOME/.zsh/pure")
fpath+=("$HOME/.config/fpath")

source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

##pure prompt##
autoload -U promptinit; promptinit


# optionally define some options
PURE_CMD_MAX_EXEC_TIME=5
PURE_GIT_UNTRACKED_DIRTY=0

# prompt pure

export TERM=screen-256color

#export PS1="$(print '%{\e[1;34m%}%h%{\e[0m%}%n@%{\e[0;36m%}%~%{\e[0m%}%{\e[1;35m%}%?%{\e[0m%}> ')"
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export PAGER="less -ri"
export BROWSER="firefox"
export PATH="$HOME/slackbin:$HOME/.bin:$HOME/.go/bin:/opt/hfs13.0.509/bin/:$HOME/.bin-sym:$HOME/.local/bin:$HOME/.gem/ruby/2.7.0/bin:$PATH"

export GOPATH="$HOME/.go"

alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s png=feh
alias -s jpg=feh
alias -s gif=$BROWSER
alias -s pdf=xpdf

alias -s tar='tar -xvf'
alias -s gz='tar -xzvf'
alias -s bz2='tar -xjvf'
alias -s rar='7z x'
alias -s 7z='7z x'
alias -s zip=uzip

alias -s hs=$EDITOR
alias -s cc=$EDITOR
alias -s c=$EDITOR
alias -s h=$EDITOR
alias -s java=$EDITOR
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR

setopt no_complete_aliases

alias arch_update="yay -Syyuu --sudoloop"
arch_list_pkgs() {yay -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h}

alias docker-clean-dangling="docker rmi $(docker images -f "dangling=true" -q)"

alias rtorrent2="rtorrent -n -o import=/home/lorx/.rtorrent2.rc"
alias rtorrentbaka="rtorrent -n -o import=/home/lorx/.rtorrentbaka.rc"

burnisodvd() {growisofs -dvd-compat -Z /dev/sr0="$1"}

alias lock="i3lock -f -i $HOME/.lock/win.png -p win"

alias mutt='neomutt'

alias rscp='rsync -aPhx'
alias rsfat='rsync -rPhx'
alias mountfat='sudo mount -t vfat -o gid=10,uid=1000'
alias mountusr='sudo mount -o gid=10,uid=1000'

alias mv='mv -v'
alias qmv='qmv -f single-column -o separate,swap'

alias mpv='mpv --osd-fractions'
alias mpvwindowsmall='mpv -geometry 426x240+100%+100%'
alias mpvwindowbig='mpv -geometry 640x360+100%+100%'

alias sshfs='sudo sshfs -o allow_other -o kernel_cache -o auto_cache -o reconnect -o compression=no -o cache_timeout=600 -o ServerAliveInterval=15'

alias clip='xclip -selection clipboard'

alias wtf='hostname && ip addr | grep -Po "(?<=inet )[^/]*(?=/24)" && pwd && whoami'

#eval `dircolors ~/.dircolors.256dark`
alias ls='ls --color=auto -F'

alias scannet='nmap -sP 192.168.0.0/24'

#alias cp='rsync -aP'
alias tcd='. txcd'
alias scp='scp -l 8192'

alias feh='feh -. -x -Z -Y -N -F'

alias umonut='umount'

#alias gp='git push'
#alias gb='git branch'
#alias gco='git checkout'
#alias gm='git merge --no-ff'
#alias gc='git commit -am'
#alias gd='git diff'
alias gs='git status'
#alias gu='git pull --no-ff'
#alias gl='git log'
#alias ga='git add'
alias gg='git log --graph --pretty=oneline --abbrev-commit'

#alias gf='git flow'

alias y='yaourt'
alias m='makfa'
alias pac='yay'

alias myip='links -dump tnx.nl/ip'

alias lsn='find . -maxdepth 1 -xtype f \( ! -iname ".*" \)'

alias weiqi='gnugo'
alias xiangqi='tsito'

#source ~/.git-flow-completion.zsh
#source /usr/share/fzf/key-bindings.zsh
#source /usr/share/fzf/completion.zsh
source ~/.fzf.zsh

zstyle ':completion:*:*:git:*' user-commands ${${(M)${(k)commands}:#git-*}/git-/}


###################
## Sysko's Settings
###################
setopt correct
setopt auto_cd
setopt hist_ignore_dups
setopt auto_list
setopt append_history
setopt auto_param_keys
setopt auto_param_slash
# setopt complete_aliases
setopt equals
setopt extended_glob
setopt hash_cmds
setopt hash_dirs
setopt mail_warning
setopt magic_equal_subst
setopt numericglobsort
setopt menu_complete

autoload mere zed zfinit

bindkey -v
zmodload zsh/complist
bindkey m menu-select
autoload incremental-complete-word
zle -N incremental-complete-word
bindkey i incremental-complete-word
autoload insert-files
zle -N insert-files
bindkey j insert-files
zmodload zsh/zpty
autoload nslookup
autoload -U zed
autoload -U zmv
autoload compinit
compinit -u

zstyle ':completion:*' format '%{[32m%}-=> %{[01m%}%d%{[0m%}'
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'l:|=* r:|=*' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=5
zstyle ':completion:*' original true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle ':completion:*:processes' list-colors '=(#b)(?????)(#B)?????????????????????????????????([^ ]#/)#(#b)([^ /]#)*=00=01;31=01;33'

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "^j"    ]]  && bindkey  "^j"    history-beginning-search-forward
[[ -n "^k"    ]]  && bindkey  "^k"    history-beginning-search-backward
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char


# The following lines were added by compinstall

#zstyle ':completion:*' completer _list _expand _complete _ignored _correct _approximate
#zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]}'
#zstyle ':completion:*' max-errors 3
#zstyle :compinstall filename '$HOME/.zshrc'

#autoload -Uz compinit
#compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt autocd beep extendedglob nomatch
# End of lines configured by zsh-newuser-install

export PERL_LOCAL_LIB_ROOT="$HOME/perl5";
export PERL_MB_OPT="--install_base $HOME/perl5";
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5";
export PERL5LIB="$HOME/perl5/lib/perl5/x86_64-linux-thread-multi:$HOME/perl5/lib/perl5";
export PATH="$HOME/perl5/bin:$PATH";

# zsh -is eval 'your command before interactive here'
if [[ $1 == eval ]]
then
    "$@"
set --
fi

## editor mode
autoload -z edit-command-line 
zle -N edit-command-line
bindkey "^X^E" edit-command-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /home/lorx/.config/broot/launcher/bash/br
eval "$(direnv hook zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
