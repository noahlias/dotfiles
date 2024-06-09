#!/bin/bash

# NOTE: import for c/c++ development
export CPATH="/opt/Homebrew/include"
export LIBRARY_PATH="/opt/Homebrew/lib"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export BUN_INSTALL="/Users/alias/.bun"
export FLUTTER="/Users/alias/Downloads/flutter"
export PATH="$BUN_INSTALL/bin:$PATH:$FLUTTER/bin"
export LLVM_PATH='/opt/Homebrew/opt/llvm/bin'
export PATH=/Users/alias/.nimble/bin:$PATH
export PATH="$LLVM_PATH:$PATH"
[ -f "/Users/alias/.ghcup/env" ] && source "/Users/alias/.ghcup/env" # ghcup-env

export GPG_TTY=$(tty)

#  TODO: for the image.nvim can change to the magick  <04/24, 2024, noahlias>

# HACK: I use the hardcode dylib in luarocks config

export OPENSSL_ROOT_DIR="/opt/Homebrew/opt/openssl"

export PATH="/Users/alias/.config/git-fuzzy/bin:$PATH"
export LS_COLORS="$(vivid generate snazzy)"

# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc.
[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP

#rye
source "$HOME/.rye/env"
# [ -f ~/.inshellisense/key-bindings.zsh ] && source ~/.inshellisense/key-bindings.zsh

#NOTE: dotnet-script
export PATH=$PATH:/Users/alias/.dotnet/tools
#NOTE: mojo
export MODULAR_HOME="/Users/alias/.modular"
export PATH="/Users/alias/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

#NOTE: matplotlib

export MPLCONFIGDIR="/Users/alias/.config/matplotlib"
# go
export GOPATH="/Users/alias/go"
export GOBIN="/Users/alias/go/bin"
export PATH=$PATH:$GOPATH/bin

#NOTE: catppuccin for fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# NOTE:gruvbox material dark
# local color00='#202020'
# local color01='#2a2827'
# local color02='#504945'
# local color03='#5a524c'
# local color04='#bdae93'
# local color05='#ddc7a1'
# local color06='#ebdbb2'
# local color07='#fbf1c7'
# local color08='#ea6962'
# local color09='#e78a4e'
# local color0A='#d8a657'
# local color0B='#a9b665'
# local color0C='#89b482'
# local color0D='#7daea3'
# local color0E='#d3869b'
# local color0F='#bd6f3e'
#
# export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS""\
#  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D""\
#  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C""\
#  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
