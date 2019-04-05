set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

if exists('skip_defaults_vim')
  finish
endif

set nocompatible
set backspace=indent,eol,start
set history=4096 " keep that many lines of command line history
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set wildmenu " display completion matches in a status line
set ttimeout " time out for key codes
set ttimeoutlen=100 " wait up to 100ms after Esc for special key
set display=truncate
set scrolloff=2
if has('reltime')
  set incsearch
endif
set nrformats-=octal
set nrformats+=alpha
if has('mouse')
  set mouse=a
endif
if &t_Co > 2 || has("gui_running")
  syntax on
  let c_comment_strings=1
endif
" now load Vundle
filetype off
set rtp+=~/.local/share/nvim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'jnurmine/Zenburn'
" i.e. vim-scripts/a.vim
Plugin 'a.vim'
Plugin 'fweep/vim-zsh-path-completion'
Plugin 'JuliaEditorSupport/julia-vim'
call vundle#end()
" Vundle loaded
if has("autocmd")
  filetype plugin indent on
  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  augroup END
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

set ts=4 sw=0
set autochdir
set cmdheight=2
let g:ycm_server_python_interpreter='/usr/bin/python2'
let g:netrw_sort_options="i"
let g:default_julia_version = "1.1"
map Q gq
map Y y$
nnoremap z<Up> 0"iy^?^<C-r>i\S?e<CR>:noh<CR>
nnoremap z<Down> 0"iy^^/^<C-r>i\S/e<CR>:noh<CR>
nnoremap <F4> :A<CR>
nnoremap <Space> i_<Esc>r
nnoremap <esc> :noh<return><esc>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
autocmd BufWritePre * :%s/\s\+$//e
" show tab char
set list
set listchars=tab:▸\ ,trail:·
let g:zenburn_transparent = 1
color zenburn
