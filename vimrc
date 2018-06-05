"-----------[ Vundle config ]------------{{{0

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'tomasiser/vim-code-dark'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-surround'
Plugin 'chrisbra/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mhinz/vim-startify'
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'w0rp/ale'
Plugin 'Chiel92/vim-autoformat'
Plugin 'dkprice/vim-easygrep'

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" All of your Plugins must be added before the following line
call vundle#end()            " required
"}}}



"-------------[ basic settings ]--------------{{{1

"Define <leader>
let mapleader=";"
set number                       " display line number
set backspace=indent,eol,start   " allow backspacing over everything in insert mode
set history=50		               " keep 50 lines of command line history
set ruler                        " show the cursor position all the time
set showcmd	                     " display incomplete commands
set incsearch                    " do incremental searching
set wildmenu                     " complete command line
set laststatus=2                 " status bar
set cursorline                   " cursor line; column
set expandtab                    " insert space characters when tab is pressed
set tabstop=2                    " insert 2 spaces for a tab, to be used with :retab
set shiftwidth=2                 " number of space characters inserted for indentation
set ignorecase                   " ignores cases
set gcr=a:block-blinkon0         " no flashing

" color scheme
colorscheme codedark 

" no scroll bars
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" mark the space indented with |
let g:indentLine_char = '|'
let g:indentLine_color_term = 239
set conceallevel=1
let g:indentLine_conceallevel=1
let g:indentLine_enabled = 1

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
"}}}



"-------------[ files and backups ]--------------{{{2

set directory-=$HOME/backup
set directory^=$HOME/backup//   " set the swap file directory
if has("vms")
  set nobackup		              " do not keep a backup file, use versions instead
else
  set backupdir-=$HOME/backup
  set backupdir^=$HOME/backup//
  set backup		                " keep a backup file (restore to previous version)
  set undofile		              " keep an undo file (undo changes after closing)
endif
"}}}



"-------------[ mouse config ]---------------{{{3

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif
"}}}



"-------------[ key mapping ]-------------{{{4

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" NERDTree toggle
map <F2> :NERDTreeToggle<CR>

" next/previous buffer
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>
"}}}



"-------------[ filetype, encoding and autoindent ]-------------{{{5

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  "Nerdtree config
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " autocmd vimenter * NERDTree
  " autocmd vimenter * wincmd p

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  autocmd BufWritePost $MYVIMRC source $MYVIMRC

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")
"}}}



"--------------[ macvim config ]----------------{{{6

if has("gui_macvim")
	let macvim_skip_cmd_opt_movement = 1
endif

autocmd BufWritePost $MYVIMRC source $MYVIMRC

autocmd FileType make setlocal noexpandtab

autocmd FileType text setlocal autoindent expandtab softtabstop=4 textwidth=76 spell spelllang=en_us

autocmd FileType help setlocal nospell
"}}}




"--------------[ vim-airline (Status Bar) ]--------------{{{7

let g:airline_powerline_fonts = 1
let g:airline_theme="tomorrow"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
"}}}



"--------------[ ctrlp config ]-------------{{{8

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
"}}}



"--------------[ nerdtree config ]--------------{{{9

let g:NERDTreeNotificationThreshold = 500
"}}}



"-------------[ customized commands ]--------------{{{10

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
"}}}
