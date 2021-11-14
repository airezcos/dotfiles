export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH="$PATH:/usr/share/texmf-dist/scripts/texlive/"
export PATH="$PATH:$HOME/.emacs.d/bin/"
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export READER="zathura"
export FILE="pcmanfm"
export FZF_DEFAULT_COMMAND='fd --type f -E .git -Hc never'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export TODOIST_API_KEY="$(pass Todoist/API)"
