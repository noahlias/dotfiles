# zmodload zsh/zprof
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
		source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
	fi
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/alias/.oh-my-zsh"
export PATH=$PATH:/opt/Homebrew/bin:/Users/alias/go/bin

ZSH_THEME="spaceship"
SPACESHIP_NODE_SHOW=false
SPACESHIP_CHAR_SYMBOL="λ "
SPACESHIP_DOCKER_SHOW=false

plugins=(git zsh-syntax-highlighting zsh-autosuggestions fzf-tab forgit rye)
source $ZSH/oh-my-zsh.sh


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


##export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
source /opt/Homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# exa command
#if [ -x "$(command -v exa)" ]; then
#    alias ls="exa"
#    alias la="exa --long --all --group"
#fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# bun completions
[ -s "/Users/alias/.bun/_bun" ] && source "/Users/alias/.bun/_bun"
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
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
# >>> xmake >>>
test -f "/Users/alias/.xmake/profile" && source "/Users/alias/.xmake/profile"
# <<< xmake <<<

# github-copilot-cli 
eval "$(github-copilot-cli alias -- "$0")"

# pokemon show
pokemon-colorscripts -r -s --no-title
#eval "$(starship init zsh)"
#opam 
[[ ! -r /Users/alias/.opam/opam-init/init.zsh ]] || source /Users/alias/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null


# JINA_CLI_BEGIN

## autocomplete
if [[ ! -o interactive ]]; then
    return
fi

compctl -K _jina jina

_jina() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(jina commands)"
  else
    completions="$(jina completions ${words[2,-2]})"
  fi

  reply=(${(ps:
:)completions})
}

# session-wise fix
ulimit -n 4096
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# JINA_CLI_END

# Extra scripts to run
source ~/.config/scripts/path.sh
source ~/.config/scripts/misc.sh
source ~/.config/scripts/aliases.sh

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

