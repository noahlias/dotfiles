#!/bin/bash


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
export PATH=/Users/alias/.nimble/bin:$PATH
[ -f "/Users/alias/.ghcup/env" ] && source "/Users/alias/.ghcup/env" # ghcup-env

export GPG_TTY=$(tty)

export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"
export PATH="$LLVM_PATH:$PATH"

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
export GOPATH="/Users/alias/go"
export GOBIN="/Users/alias/go/bin"
export PATH=$PATH:$GOPATH/bin
