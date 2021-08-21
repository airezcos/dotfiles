# remove <C-s> freezing
stty -ixon

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

c() { cd ~/code/$1; }
_c() { _files -W ~/code -/; }
compdef _c c

h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

## ZLE tweaks ##

## use the vi navigation keys (hjkl) besides cursor keys in menu completion
bindkey -M menuselect 'h' vi-backward-char        # left
bindkey -M menuselect 'k' vi-up-line-or-history   # up
bindkey -M menuselect 'l' vi-forward-char         # right
bindkey -M menuselect 'j' vi-down-line-or-history # bottom

## set command prediction from history, see 'man 1 zshcontrib'
#is4 && zrcautoload predict-on && \
#zle -N predict-on         && \
#zle -N predict-off        && \
#bindkey "^X^Z" predict-on && \
#bindkey "^Z" predict-off

# just type '...' to get '../..'
rationalise-dot() {
local MATCH
if [[ $LBUFFER =~ '(^|/| |	|'$'\n''|\||;|&)\.\.$' ]]; then
  LBUFFER+=/
  zle self-insert
  zle self-insert
else
  zle self-insert
fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
# without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert

autoload -Uz compinit
compinit

bindkey -v

alias gss="git status -sb"
alias gcam="git commit -am"
alias d="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
alias dss="d status -sb"
alias cfz="${EDITOR} ~/.zshrc && source ~/.zshrc"
alias cfi="${EDITOR} ~/.config/i3/config"
alias cfk="${EDITOR} ~/.config/sxhkd/sxhkdrc"
alias cfhc="${EDITOR} scp://root@homeassistant//config/configuration.yaml"
alias cfhs="${EDITOR} scp://root@homeassistant//config/scenes.yaml"
alias cfha="${EDITOR} scp://root@homeassistant//config/automations.yaml"
alias la="exa --long --all --header --git"
alias ll="exa --long --header --git"
alias kitty-light='ln -sf ~/.config/kitty/kitty-themes/themes/gruvbox_light.conf ~/.config/kitty/theme.conf'
alias kitty-dark='ln -sf ~/.config/kitty/kitty-themes/themes/gruvbox_dark.conf ~/.config/kitty/theme.conf'

export XDG_CONFIG_HOME="$HOME/.config"
# export BIB="$HOME/Documents/LaTeX/uni.bib"
# export REFER="$HOME/Documents/referbib"
export SUDO_ASKPASS="$HOME/.local/bin/tools/dmenupass"
# export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
# export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

if [ -d ~/buntu ] && [ -z "$(ls -A -- ~/buntu)" ]; then sshfs buntu:share ~/buntu; fi

#if [[ $HOST == 'arch-desktop' ]]; then
#  if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#    exec startx
#  fi
#fi

# stty erase "^?"

# powerlevel10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
if type keychain > /dev/null; then
  eval `keychain --quiet --eval --agents ssh id_rsa`
fi
eval "`pip completion --zsh`"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
