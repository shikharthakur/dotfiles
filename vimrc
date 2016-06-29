"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
filetype on
filetype indent on
autocmd BufNewFile *.cpp :0r ~/.vim/cpp
autocmd BufNewFile *.cpp :w!
autocmd BufEnter * silent! lcd %:p:h "change working dir to filename's directory
filetype off                  " required
au BufWrite *.cpp :Autoformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " be iMproved, required
set autowriteall
set autoread
set incsearch
set noswapfile
set tabstop=3 softtabstop=3 shiftwidth=3 expandtab
"set textwidth=160
set clipboard=unnamed " shared OS and vim clipboard
set number ruler wrap autoread showcmd showmode fdm=marker nobackup
set showmatch
set more
set laststatus=2
set scrolloff=5
set guifont=Inconsolata\ for\ Powerline:h18
set splitright
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8
set completeopt=menu
set mouse=a
set ttymouse=xterm2
if has('gui_running')
   set background=dark
   colorscheme base16-eighties
   let g:airline_theme='base16_eighties'
   set cursorline
else
   set term=xterm-256color
   set t_Co=256
   set background=dark
   colorscheme base16-flat
   let g:airline_theme='base16_eighties'
   set cursorline
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"     PLUGINS  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Chiel92/vim-autoformat'
Plugin 'scrooloose/nerdtree'
Plugin 'chriskempson/base16-vim'
Plugin 'Raimondi/delimitMate'  "bracket matching.
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dracula/vim'
Plugin 'junegunn/seoul256.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  KEYMAPS "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
map <D-F9> :!clear; g++-4.9 --std=c++11 -g  % -o %< -DLOCAL_SYS && time ./%< <CR>
map <F9> :execute '!clear; g++-4.9 --std=c++11 ' . shellescape(join([expand("%:r"),"cpp"],"."),1).
         \ ' && time ./a.out < '. shellescape(join([expand("%:r"), "in"], "."), 1)<CR>
map <F8> :execute "tabnew %:r.in"<CR><C-W>r<CR>
map <F7> :execute "vs output.txt"<CR>
map <F2> :w <CR>

map <c-k> :NERDTreeToggle<CR>
map CC <plug>NERDCommenterToggle
map  :Autoformat<CR>
inoremap II <Esc>
"move through tabs easily.
noremap J :tabprevious<CR>
nnoremap K :tabnext<CR>
"Cause 0 and $ are painful
nnoremap H 0
nnoremap L $
vnoremap H 0
vnoremap L $

command! Dir :cd %:p:h
command! Refresh :so ~/.vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ultisnips + YCM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:ycm_show_diagnostics_ui=0 "hide that irritating line by line correction
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
function! g:UltiSnips_Complete()
   if pumvisible()
      return "\<C-n>"
   else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
         return "\<TAB>"
      endif
   endif
   return ""
endfunction
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" Expand snippet or return
let g:ulti_expand_res = 0
function! Ulti_ExpandOrEnter()
   call UltiSnips#ExpandSnippet()
   if g:ulti_expand_res
      return ''
   else
      return "\<return>"
   endfunction
inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:delimitMate_expand_cr = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_max_files=0
let g:ctrlp_open_new_file = 't'
let g:ctrlp_open_multiple_files = 'tj'
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_by_filename = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_cmd = 'CtrlPMRU'  "set most recent files as the initial search.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Airline settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
