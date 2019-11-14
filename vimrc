set nocompatible
filetype off

set guioptions-=r
" set guioptions-=R
" set guioptions-=l
set guioptions-=L
set guioptions-=T

" Initialize Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

" Initialize Vim Plug
call plug#begin()
Plug 'cormacrelf/vim-colors-github'
Plug 'scrooloose/nerdtree'
call plug#end()

" https://github.com/vim-ruby/vim-ruby/wiki/VimRubySupport
filetype on
filetype indent on
filetype plugin on
syntax on

set noswapfile
" set relativenumber
set number
set nofoldenable
set ignorecase
set ruler

let mapleader=','
imap ;; <Esc>

noremap ; l
noremap l k
noremap k j
noremap j h

map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k

" http://vimcasts.org/episodes/working-with-tabs/
map <D-S-]> gt
map <D-S-[> gT
map <D-0> :tablast<CR>

set sessionoptions="resize"
let g:session_autosave='yes'
let g:session_autosave_to = 'default'
let g:session_autoload='yes'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

" Plugin 'gcmt/taboo.vim'
" let g:taboo_tab_format='%N%f'

" Plugin 'scrooloose/nerdtree'
let NERDTreeShowBookmarks=1
let NERDTreeShowLineNumbers=1
let NERDTreeChDirMode=2
let NERDTreeMouseMode=2
map <C-n> :NERDTreeToggle<CR>

Plugin 'wincent/Command-T'
let g:CommandTTagIncludeFilenames=1

Plugin 'flazz/vim-colorschemes'
colorscheme github
" colorscheme codeschool
hi clear CursorLineNR
" Bundle 'altercation/vim-colors-solarized'
" set background=dark
" colorscheme solarized
" set guifont=Menlo:h11
set guifont=Meslo\ LG\ L:h11
" set guifont=Monaco:h11
" set guifont=Droid\ Sans\ Mono:h11
" set guifont=Courier:h12
" set linespace=2
" set linespace=3

set completeopt=menuone
set completefunc=localcomplete#allBufferMatches
let g:acp_ignorecaseOption=0
let g:acp_mappingDriven=1
let g:acp_behaviorKeywordLength=3
let g:acp_completeOption='.,w,b,u'
let g:acp_behaviorUserDefinedFunction='localcomplete#allBufferMatches'
let g:acp_behaviorUserDefinedMeets='acp#meetsForKeyword'
let g:acp_behaviorFileLength=-1
let g:acp_behaviorRubyOmniMethodLength=-1
let g:acp_behaviorRubyOmniSymbolLength=-1
Plugin 'dirkwallenstein/vim-localcomplete'
Plugin 'AutoComplPop'

Plugin 'myusuf3/numbers.vim'
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-unimpaired'
Plugin 'tomtom/tcomment_vim'
" Bundle 'airblade/vim-gitgutter'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-endwise'
Plugin 'jgdavey/vim-blockle'

Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-haml'
Plugin 'kchmck/vim-coffee-script'
