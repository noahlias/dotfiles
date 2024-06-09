#!/bin/bash

alias ds="du -sh * | sort -h"
alias rfv="ripgrep_fzf_vim"
alias fancy="fortune | cowsay | lolcat"
alias hs="history_statistics"
alias p="degit python-discord/code-jam-template"
alias ls="eza -l -a --icons"
alias cat="bat -p --theme gruvbox-dark"
alias ne="neofetch"
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias lg="lazygit"
alias c="clear"
alias o="onefetch"
alias n="nvim"
alias ff="fzf --height=40% --border --info inline-right  --marker ▏ --pointer ▌ --prompt '▌ '  \
    --highlight-line --color gutter:-1,selected-bg:238,selected-fg:146,current-fg:189 | xargs nvim"
alias goody2="goody2"
#kitty
alias s="kitty +kitten ssh"
alias icat="kitty +kitten icat --align left"

alias g++='g++ -std=c++20'
alias gcllm='git diff --minimal --cached | \
    llm -t gitcommit > $(git rev-parse --git-dir)/COMMIT_EDITMSG && \
    git commit --verbose --edit --file=$(git rev-parse --git-dir)/COMMIT_EDITMSG'

# alias gemma2b="ollama run gemma:2b-instruct"

alias cab='conda activate base'
alias ca='conda activate'
alias freeze='freeze -t gruvbox'
alias ncdu='ncdu --color dark'
alias bo="brew outdated"
alias y="yazi"
