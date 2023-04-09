set nocompatible
syntax enable

if has('gui_running')
    set background=light
else
    set background=dark
endif

"colorscheme solarized
set t_Co=256
colorscheme distinguished
set showmode
set nowrap
"set tabstop=4
"set softtabstop=4
"set expandtab
"set shiftwidth=4
"set shiftround
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set relativenumber
set magic
set showmatch
set ignorecase
set smartcase
set smarttab
set scrolloff=4
set virtualedit=all
set hlsearch
set incsearch
set gdefault
set pastetoggle=<F2>
set mouse=a
set formatoptions+=1
set termencoding=utf-8
set encoding=utf-8
set laststatus=2
set cmdheight=2
set hidden
set history=1000
set undolevels=1000
"set mat=2
"set gcr=n:blinkon0
"set gcr=a:blinkon0
"set so=7

if v:version >= 730
    set undofile
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif

set nobackup
set nowb
set noswapfile
set directory=~/.vim/.tmp,~/tmp,/tmp
set viminfo='220,\"100,:20,%,n~/.viminfo
set wildmenu
set wildmode=list:full
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell
set noerrorbells
set showcmd
set nomodeline
set cursorline

"inoremap <up> <nop>
"vnoremap <up> <nop>
"inoremap <down> <nop>
"vnoremap <down> <nop>
"inoremap <left> <nop>
"vnoremap <left> <nop>
"inoremap <right> <nop>
"vnoremap <right> <nop>

"nnoremap <leader>q :q<CR>

vmap > >gv
vmap < <gv

" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction

" Trim Trailing Whitespace On Save
autocmd BufWritePre * :%s/\s\+$//e

" Save A Read-Only File Using :w!!
cmap w!! w !sudo tee > /dev/null %
