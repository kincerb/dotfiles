" bootstrap vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set pythonthreedll=/Library/Frameworks/Python.framework/Versions/3.9/lib/libpython3.9.dylib
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'neoclide/coc.nvim' , { 'branch' : 'release'  }
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'
Plug 'pseewald/vim-anyfold'
Plug 'google/yapf'
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'jiangmiao/auto-pairs'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'flazz/vim-colorschemes'
call plug#end()

" fzf settings
set rtp+=~/.fzf
filetype on
filetype plugin indent on
colorscheme Monokai
syntax on
set background=dark
set cursorline
set showmatch
set number
set history=500
" search settings
set ignorecase
set smartcase
set incsearch " hightlight match while typing
set hlsearch
nmap <silent> <BS> :nohlsearch<CR>
set encoding=utf-8
set hidden " don't warn when switching from unsaved buffer
set clipboard^=unnamed " use system clipboard
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=119
set expandtab
set autoindent
set backspace=indent,eol,start "allow backspace to delete as expected
set pastetoggle=<F2>
let python_highlight_all=1

inoremap jk <ESC>
let mapleader=","

" statusline
set laststatus=2
set statusline=
set statusline+=%f
set statusline+=\%m
set statusline+=\ %y
set statusline+=\ pos:\ %l,%c
set statusline+=\ %{kite#statusline()}
" switch to the right side
set statusline+=%=
set statusline+=%{FugitiveStatusline()}
set statusline+=\ lines:\ %L
set statusline+=\ buffer:\ %n

" split settings
set splitbelow " open vertical split below
set splitright " open horizontal split to the right
" set fillchars=vert:| " need to research this

" use very magic mode by default for searching
nnoremap / /\v

" Indent with tab
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >
vnoremap <S-Tab> <

"tab navigation
nnoremap <leader>j :tabnext<CR>
nnoremap <leader>k :tabprev<CR>

" split/window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>= :vertical resize 32<CR>

" terminal fun
nnoremap <leader>t :terminal<CR>

" folding
set foldmethod=indent
set foldlevel=99
" fold with space
nnoremap <space> za
" anyfold
autocmd Filetype * AnyFoldActivate
let g:anyfold_motion=0
let g:anyfold_fold_display=0

" fzf settings
nnoremap <leader>f :Ag <C-R><C-W><cr>
vnoremap <leader>f y:Ag <C-R><cr>
nnoremap <Leader>a :Ag <C-R><C-W><CR>:cw<CR>
vnoremap <Leader>a y:Ag <C-R><C-W><CR>:cw<CR>
nnoremap <C-F> :Ag<Space>
" nnoremap <Leader><Leader> :Files<cr>

" terminal bindings
nnoremap <leader>e call term_sendkeys(buf, "import \<CR>")
vnoremap <leader>e call term_sendkeys(buf, "\<C-R>\<C-W>")
" set python options
au BufNewFile,BufRead *.py call SetPythonOptions()

" pymode options
let g:pymode_python='python3'
let g:pymode_options_max_line_length=119
let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
let g:pymode_virtualenv=1
let g:pymode_run_bind='<leader>E'
let g:pymode_rope_completion=0
let g:pymode_doc_bind='<C->k'
let g:pymode_doc=0
let g:pymode_folding=0
let g:pymode_rope=1
let g:pymode_rope_goto_definition_bind='<leader>g'
let g:pymode_rope_rename_bind = '<leader>r'
let g:pymode_rope_goto_definition_cmd='new'

" kite options
let g:kite_supported_languages = ['python', 'javascript', 'go']
let g:kite_tab_complete=1
let g:kite_auto_complete=1
" let g:kite_previous_placeholder = '<C-H>'
" let g:kite_next_placeholder = '<C-L>'
" let g:kite_documentation_continual=1
set completeopt+=menuone   " show the popup menu even when there is only 1 match
set completeopt+=noinsert  " don't insert any text until user chooses a match
set completeopt-=longest   " don't insert the longest common text
set completeopt+=preview
set belloff+=ctrlg         " disable beep during completion
autocmd CompleteDone * if !pumvisible() | pclose | endif
nmap <silent> <buffer> K <Plug>(kite-docs)

" set web development options
au BufNewFile,BufRead *.js, *.ts, *.html, *.css, *.yml call SetWebDevOptions()
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-eslint', 'coc-prettier' ]

" set groovy options
au BufNewFile,BufRead *Jenkinsfile call SetGroovyOptions()

augroup HelpInTabs
    autocmd!
    autocmd BufEnter *.txt call HelpInNewTab()
augroup END

function! SetGroovyOptions()
    set filetype=groovy
endfunction

function! SetPythonOptions()
    set fileformat=unix
endfunction

function! SetWebDevOptions()
    nmap <leader>ac <Plug>(coc-codeaction)
    nmap <leader>qf <Plug>(coc-fix-current)
    inoremap <silent><expr> <Tab> coc#refresh()
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <leader>r <Plug>(coc-format)
    vmap <leader>r <Plug>(coc-format-selected)
endfunction

function! HelpInNewTab()
    if &buftype == 'help'
        "Convert the help window to a tab..."
        execute "normal \<C-W>T"
    endif
endfunction

" NERDTree options
map <leader>n :NERDTreeFocus<CR>
map <leader>N :NERDTreeClose<CR>
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$', '\.ropeproject$', '\.git$', '\.idea$']
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=0
let NERDTreeWinSize=32

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
