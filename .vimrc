
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'morhetz/gruvbox'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'


" All of your Plugins must be added before the following line
call vundle#end()            " required
syntax on
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set number
set relativenumber
set encoding=utf-8

set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set colorcolumn=81
set expandtab
set noshiftround
set ttyfast
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
set listchars=tab:▸\ ,eol:¬
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
" Status bar
set laststatus=2

" Last line
set showmode
set showcmd
autocmd vimenter * ++nested colorscheme gruvbox
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline_section_z = '%3p%% %l:%3v'

set splitbelow

" Key mappings
let g:mapleader = ' '

let mode_nv = ['n', 'v']
let mode_v = ['v']
let mode_i = ['i']

let nmappings = [
      \ {'from': 'S', 'to': ':w<CR>'},
      \ {'from': 'Q', 'to': ':q<CR>'},
      \ {'from': ';', 'to': ':', 'mode': mode_nv},
      \ {'from': 'Y', 'to': '"+y', 'mode': mode_v},
      \ {'from': '`', 'to': '~', 'mode': mode_nv},
      \ {'from': 'u', 'to': 'k', 'mode': mode_nv},
      \ {'from': 'e', 'to': 'j', 'mode': mode_nv},
      \ {'from': 'n', 'to': 'h', 'mode': mode_nv},
      \ {'from': 'i', 'to': 'l', 'mode': mode_nv},
      \ {'from': 'U', 'to': '5k', 'mode': mode_nv},
      \ {'from': 'E', 'to': '5j', 'mode': mode_nv},
      \ {'from': 'N', 'to': '0', 'mode': mode_nv},
      \ {'from': 'I', 'to': '$', 'mode': mode_nv},
      \ {'from': 'gu', 'to': 'gk', 'mode': mode_nv},
      \ {'from': 'ge', 'to': 'gj', 'mode': mode_nv},
      \ {'from': 'h', 'to': 'e', 'mode': mode_nv},
      \ {'from': '<C-U>', 'to': '5<C-y>', 'mode': mode_nv},
      \ {'from': '<C-E>', 'to': '5<C-e>', 'mode': mode_nv},
      \ {'from': 'ci', 'to': 'cl'},
      \ {'from': 'cn', 'to': 'ch'},
      \ {'from': 'ck', 'to': 'ci'},
      \ {'from': 'c,.', 'to': 'c%'},
      \ {'from': 'yh', 'to': 'ye'},
      \ {'from': 'l', 'to': 'u'},
      \ {'from': 'k', 'to': 'i', 'mode': mode_nv},
      \ {'from': 'K', 'to': 'I', 'mode': mode_nv},
      \ {'from': ',.', 'to': '%', 'mode': mode_nv},
      \ {'from': '<c-y>', 'to': '<ESC>A {}<ESC>i<CR><ESC>ko', 'mode': mode_i},
      \ {'from': '\\v', 'to': 'v$h'},
      \ {'from': '<c-a>', 'to': '<ESC>A', 'mode': mode_i},
      \ {'from': '<leader>w', 'to': '<C-w>w'},
      \ {'from': '<leader>u', 'to': '<C-w>k'},
      \ {'from': '<leader>e', 'to': '<C-w>j'},
      \ {'from': '<leader>n', 'to': '<C-w>h'},
      \ {'from': '<leader>i', 'to': '<C-w>l'},
      \ {'from': 'qf', 'to': '<C-w>o'},
      \ {'from': 's', 'to': '<nop>'},
      \ {'from': 'su', 'to': ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>'},
      \ {'from': 'se', 'to': ':set splitbelow<CR>:split<CR>'},
      \ {'from': 'sn', 'to': ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>'},
      \ {'from': 'si', 'to': ':set splitright<CR>:vsplit<CR>'},
      \ {'from': '<up>', 'to': ':res +5<CR>'},
      \ {'from': '<down>', 'to': ':res -5<CR>'},
      \ {'from': '<left>', 'to': ':vertical resize-5<CR>'},
      \ {'from': '<right>', 'to': ':vertical resize+5<CR>'},
      \ {'from': 'srh', 'to': '<C-w>b<C-w>K'},
      \ {'from': 'srv', 'to': '<C-w>b<C-w>H'},
      \ {'from': '<leader>tu', 'to': ':tab<CR>'},
      \ {'from': '<leader>tU', 'to': ':tab split<CR>'},
      \ {'from': '<leader>tn', 'to': ':-tabnext<CR>'},
      \ {'from': '<leader>ti', 'to': ':+tabnext<CR>'},
      \ {'from': '<leader>tmn', 'to': ':-tabmove<CR>'},
      \ {'from': '<leader>tmi', 'to': ':+tabmove<CR>'},
      \ {'from': '<leader>sw', 'to': ':set wrap<CR>'},
      \ {'from': '<leader><CR>', 'to': ':nohlsearch<CR>'},
      \ {'from': '<f10>', 'to': ':TSHighlightCapturesUnderCursor<CR>'},
      \ {'from': '<leader>o', 'to': 'za'},
      \ {'from': '<leader>pr', 'to': ':profile start profile.log<CR>:profile func *<CR>:profile file *<CR>'},
      \ {'from': '<leader>re', 'to': ':e ~/.vimrc<CR>'},
      \ {'from': ',v', 'to': 'v%'},
      \ {'from': '<leader><esc>', 'to': '<nop>'},
      \ {'from': 'q', 'to': '<nop>'},
      \ {'from': ',q', 'to': 'q'},
      \ ]

for mapping in nmappings
  let mode = get(mapping, 'mode', 'n')
  for m in mode
    execute m.'noremap' mapping['from'] mapping['to']
  endfor
endfor
