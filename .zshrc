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

plugins=(git zsh-syntax-highlighting zsh-autosuggestions fzf-tab)
source $ZSH/oh-my-zsh.sh

history_statistics() {
	# history command statistics
	history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n 10
}

ripgrep_fzf_vim() {
#https://github.com/junegunn/fzf/blob/master/ADVANCED.md#ripgrep-integration
# 1. Search for text in files using Ripgrep
# 2. Interactively narrow down the list using fzf
# 3. Open the file in Vim
	rg --color=always --line-number --no-heading --smart-case "${*:-}" |
  fzf --ansi \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --bind 'enter:become(nvim {1} +{2})'
}

download_bilix_audio() {
    bilix get_video $1 -fb chrome -oa -nh -d ./ && rm -r videos
}

download_bilix_video(){
	bilix get_video $1 -fb chrome --image  -nh -d ./
}

yt-dlp_mp3(){
	yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 $1
}

yt-dlp_mp4(){
  yt-dlp -S ext $1
}

#fast-translate
live_stream_translate(){
 python translate_livestream.py $1 --model_size_or_path medium --task transcribe --interval 7 --threshold 0.5 --min_silence_duration_ms 2000 --word_timestamps True --history_word_size 0 --language $2	
}

# scripts


alias lvim="~/.local/bin/lvim"
alias ds="du -sh * | sort -h"
alias rfv="ripgrep_fzf_vim"
alias fancy="fortune | cowsay | lolcat"
alias hs="history_statistics"
alias p="degit python-discord/code-jam-template"
alias ls="exa -l -a --icons"
alias cat="bat -p --theme gruvbox-dark"
alias ne="neofetch"
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias lg="lazygit"
alias c="clear"
alias o="onefetch"
alias n="nvim"
alias ff="fzf | xargs nvim"

#kitty
alias s="kitty +kitten ssh"
alias icat="kitty +kitten icat --align left"

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


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
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

# bun
export CPATH="/opt/Homebrew/include"
export LIBRARY_PATH="/opt/Homebrew/lib"

#treesitter
#export TREESITTER_LIBRARY='/opt/Homebrew/opt/tree-sitter/lib/libtree-sitter.a'
#export TREESITTER_INCLUDE_DIR='/opt/Homebrew/opt/tree-sitter/include'

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export BUN_INSTALL="/Users/alias/.bun"
export FLUTTER="/Users/alias/Downloads/flutter"
export R_HOME='/opt/Homebrew/Cellar/r/4.3.1/lib/R/'
export PATH="$BUN_INSTALL/bin:$PATH:$FLUTTER/bin"
export LLVM_PATH='/opt/Homebrew/opt/llvm/bin'
[ -f "/Users/alias/.ghcup/env" ] && source "/Users/alias/.ghcup/env" # ghcup-env

export GPG_TTY=$(tty)

# opam configuration


export PATH="$LLVM_PATH:$PATH"
alias g++='g++ -std=c++20'

#export OPENSSL_INCLUDE_DIR="/opt/Homebrew/opt/openssl/include/"
export OPENSSL_ROOT_DIR="/opt/Homebrew/opt/openssl"
#export OPENSSL_CYRPTO_LIBRARY="/opt/Homebrew/opt/openssl/lib/"
export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

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

# pokemon show
pokemon-colorscripts -r -s --no-title
#eval "$(starship init zsh)"
export PATH="/Users/alias/.config/git-fuzzy/bin:$PATH"
export LS_COLORS="$(vivid generate snazzy)"

# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc.
[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP

#opam 
[[ ! -r /Users/alias/.opam/opam-init/init.zsh ]] || source /Users/alias/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
