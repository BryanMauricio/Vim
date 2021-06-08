source $VIMRUNTIME/vimrc_example.vim

filetype off
set shellslash
set rtp+=~/vimfiles/bundle/Vundle.vim
call vundle#begin('~/vimfiles/bundle')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'

" All of your Plugins must be added before the following line
call vundle#end()            " required
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

call plug#begin()

"Navigation Plugins
Plug 'rbgrouleff/bclose.vim'
Plug 'dbakker/vim-projectroot'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'

"UI Plugins
Plug 'bling/vim-bufferline'
Plug 'altercation/vim-colors-solarized'

Plug 'searleser97/cpbooster.vim'



if isdirectory("~/dev/mitscript-syntax")
  Plug '~/dev/mitscript-syntax'
endif

"Note taking
Plug 'vimwiki/vimwiki'
Plug 'lukaszkorecki/workflowish'

call plug#end()

au GUIEnter * simalt ~x
set hls
set is
set cb=unnamed
set gfn=Consolas:h11
set nocompatible
set ts=2
set sw=2
set si
set mouse=a
set expandtab
set softtabstop=2
syntax enable
set autoindent
set relativenumber
set background=light
colorscheme solarized
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
" shift+arrow selection
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>

vmap <C-c> y<Esc>i
vmap <C-x> d<Esc>i
map <C-v> pi
imap <C-v> <Esc>pi
imap <C-z> <Esc>ui

set backspace=indent,eol,start
set ruler
set guitablabel=%t
set guioptions-=T
set guicursor=a:block
set guicursor=a:blinkwait800-blinkon500-blinkoff500



let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

:imap <F5> <esc>:w <bar> !g++ -std=c++14 -DONLINE_JUDGESAS % -o %:r -Wl,--stack,268435456<CR>
:imap <F9> <esc>:!%:r<CR>
:imap <F10> <esc>:!%:r<CR>
:imap <F12> <esc>:%y+<CR>

autocmd filetype cpp nnoremap <F5> :w <bar> !g++ -std=c++14 -DONLINE_JUDGESAS % -o %:r -Wl,--stack,268435456<CR>
autocmd filetype cpp nnoremap <F9> :!%:r<CR>
autocmd filetype cpp nnoremap <F10> :!%:r<CR>

autocmd filetype cpp nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $
autocmd filetype cpp nnoremap <F2> :w<CR>
:imap <F2> <esc>:w<CR>
autocmd filetype cpp nnoremap <F12> :%y+<CR>
autocmd BufNewFile *.cpp 0r C:\Users\admin\Desktop\Allcodeforcesr\Code\NuevaCarpeta\template.cpp  

set nu
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
