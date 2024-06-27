# zmodload zsh/zprof
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
unsetopt AUTO_REMOVE_SLASH
unsetopt HIST_EXPIRE_DUPS_FIRST
unsetopt EXTENDED_HISTORY

source ~/.config/scripts/path.sh
source ~/.config/scripts/misc.sh
source ~/.config/scripts/aliases.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/Homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/Homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/Homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/Homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup

# <<< conda initialize <<<


 # >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/opt/Homebrew/bin/micromamba";
export MAMBA_ROOT_PREFIX="/Users/alias/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/Users/alias/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/Users/alias/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/Users/alias/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<



# >>> xmake >>>
test -f "/Users/alias/.xmake/profile" && source "/Users/alias/.xmake/profile"
# <<< xmake <<<

# bun completions
[ -s "/Users/alias/.bun/_bun" ] && source "/Users/alias/.bun/_bun"

#opam
[[ ! -r /Users/alias/.opam/opam-init/init.zsh ]] || source /Users/alias/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

#rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


#homebrew site-functions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C


autoload -Uz compinit && compinit
zmodload zsh/complist

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# zinit ice wait'!0'
# zinit light-mode depth=1 for \
# 	spaceship-prompt/spaceship-prompt

# zinit as"null" wait"0a" lucid light-mode from"gh-r" completions for \
#   nocompile"!" \
#     atclone"./zoxide init zsh --no-cmd > init.zsh" \
#     atpull"%atclone" \
#     src"init.zsh" \
#     ajeetdsouza/zoxide

zinit wait lucid light-mode depth=1 for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 blockf zsh-users/zsh-completions

# zinit light zsh-users/zsh-autosuggestions
# zinit light zsh-users/zsh-completions
# zinit light zdharma-continuum/fast-syntax-highlighting
zinit light wfxr/forgit
zinit light Aloxaf/fzf-tab

zinit light-mode for \
  zdharma-continuum/zinit-annex-binary-symlink \
  zdharma-continuum/zinit-annex-linkman \
  zdharma-continuum/zinit-annex-patch-dl \

### End of Zinit's installer chunk


# Auto completion
zstyle ":completion:*:*:*:*:*" menu select
zstyle ":completion:*" use-cache yes
zstyle ":completion:*" special-dirs true
zstyle ":completion:*" squeeze-slashes true
zstyle ":completion:*" file-sort change
zstyle ":completion:*" matcher-list "m:{[:lower:][:upper:]}={[:upper:][:lower:]}" "r:|=*" "l:|=* r:|=*"


# Extra scripts to run
# github-copilot-cli
eval "$(github-copilot-cli alias -- "$0")"
eval "$(atuin init zsh)"
eval "$(starship init zsh)"
source <(fzf --zsh)
eval "$(zoxide init zsh)"
# pokemon show
pokemon-colorscripts -r -s --no-title
