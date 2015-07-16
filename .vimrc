"""
"  .vimrc
""
" indent.txt
" usr_05.txt, usr_41.txt, usr_28.txt
" vim(1)
""""

" General
set nocp            " turn off vi compatibility and behave leet
set nobk            " turn off back ups
set nowb            " turn off back ups
filet on            " turn on filetype recognition

" Browsing
set bs=indent,eol,start     " where to use backspace
set ek              " allow arrow keys in insert mode
set is              " do incremental searching
set hi=50           " history levels
set mat=0           " tenths of a second to show matching brackets
set mps=(:),[:],{:},<:>     " matching characters
set noeb            " no beeping
set nonu            " don't print line numbers
set novb            " don't flash the screen
set report=0            " don't display file change reports
set sm              " show matching brackets
set scs             " smart case search options
set tf              " refresh the screen more often
set ul=500          " undo levels
set wc=<Tab>            " expansion key

" Character encoding
"set enc=koi8-r         " vim
"set fenc=cp1251            " new file
"set fencs=cp1251,koi8-r,utf-8,latin1 " editing an existing file
"set tenc=utf-8         " terminal
"set tenc=cp1251            " terminal
"set tenc=koi8-r            " terminal

" Indentation
"set cin                " c indenting
set cinw={,case,public,private,protected " extra indent after these keywords
set cink=0{,0},0),:,!^F,o,O,*<CR> " keys that re-indent in the insert mode
set cino=:s,l1,t0,+5,c0,C1,/2,(0,u1,U1,w1 " indenting options
set tabstop=4       " tab appears as 4 spaces
set shiftwidth=4    " indents will have a width of 4
set softtabstop=4   " sets the number of columns for a tab
set expandtab       " expand tabs to spaces

" Folding
set fdo=hor,insert,mark,search,undo " open a fold under these actions
set fdl=1           " close folds higher than this level
set fml=2           " minimum amount of lines to be folded
"ru folding/sh-fold.vim     " SH-style folding functions

" Status line
set ls=2            " always display status line
set sc              " display incomplete commands
set smd             " show current mode
set stl=[%n]\ %F\ \ Type=%Y\ \ %r\ %1*%m%*%w%=%(Line:\ %l%)\ Column:\ %5(%c%V/%{strlen(getline(line('.')))}%)\ Byte:\ %O\h\ %4(%)%p%%
set ru              " show the cursor position at all times

" .viminfo file
set vi='100,<500,:10000,@10000,/10000,s1024,f1,h,r/tmp,n~/.history/viminfo

" 7.0-specific settings
if version >= 700
  let html_ignore_folding=1 " convert unfolded text to html using TOhtml
  set nospell           " turn spelling off
  set sps=double        " use 'fast', then 'best' method of suggesting
  set spl=ru            " use Russian dictionary
  set spl=en_us         " use English dictionary
endif

" Color settings
" Note: these should be executed before 'syntax on'
if $term =~ "xterm"
  if has("terminfo")
    set t_Co=16
    set t_Sf=<C-v><Esc>[3%p1%dm
    set t_Sb=<C-v><Esc>[4%p1%dm
  else
    set t_Co=16
    set t_Sf=<C-v><Esc>[3%dm
    set t_Sb=<C-v><Esc>[4%dm
  endif
endif

" Syntax highlighting only if supported
if &t_Co > 2 || has("gui_running")
  let mysyntaxfile='~/.vim/syntax.vim'
  syn enable
  set nohls
endif

" gvimrc
if has("gui_running")
  if has("mac")
    "set gfn=Anonymous:h10  " font to use in GUI
    "set gfn=Courier:h11
    set anti            " use anti-aliased fonts
    set lines=65        " number of lines
    set co=167          " number of columns
  elseif has("win32") || has("win64")
    set gfn='Courier New:h10'
  endif
endif

" Functions
fu! CheckFileEncoding()
  if &modified && &fileencoding != ''
    exec 'e! ++enc=' . &fileencoding
  endif
endf

" Key mappings
map ,fc     :setf csh<CR>
map ,ft     :setf text<CR>
map ,fv     :setf vim<CR>
map ,fz     :setf zsh<CR>

map .fc     :ru folding/c-fold.vim<CR>
map .fs     :ru folding/sh-fold.vim<CR>
map .ft     :ru folding/tex-fold.vim<CR>
map .fv     :ru folding/vim-fold.vim<CR>

map <silent> ,on :set nu!<CR>
map ,op     :set paste!<CR>
map <silent> ,os :set spell!<CR>

map ,le     :set spl=en_us<CR>
map ,lr     :set spl=ru<CR>

"map ,ew        :set fenc=cp1251 | call CheckFileEncoding()<CR>

" auto commands
au BufNewFile,BufRead *.txt
  \ setf text
au BufNewFile,BufRead *.zsh
  \ setf zsh
au FileType text
  \ setl tw=78 | set nocin | set spell | set fdm=manual
"  \ setl tw=78 | set nocin | set fdm=manual
au VimEnter *
  \ echo "Welcome back!"
au VimLeave *
  \ echo "Later! (-"
au BufWinEnter *.txt
  \ call CheckFileEncoding()
au BufWinEnter *.cpp
  \ runtime c-fold.vim<Enter>


" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif
 " Need to postpone using "zv" until after reading the modelines.
 autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
augroup END

" change paste mode to correctly insert multiline tabbed text
set pastetoggle=<F6>
" and this block of config should togge pasting mode automatically
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction


" additions from http://statico.github.io/vim.html and http://statico.github.io/vim2.html
execute pathogen#infect()
if exists("g:did_load_filetypes")
    filetype off
    filetype plugin indent off
endif
set runtimepath+=/usr/local/go/misc/vim
filetype plugin indent on

autocmd FileType go autocmd BufWritePre <buffer> Fmt    " rewrite go files on write with gofmt

:nmap ; :CtrlPMixed<CR>         " http://kien.github.io/ctrlp.vim/

:nmap \e :NERDTreeToggle<CR>    " https://github.com/scrooloose/nerdtree

:nmap j gj      " `j` and `k` buttons switch between screen lines instead of source files lines
:nmap k gk      " (think of wrapped lines)

:set incsearch
:set ignorecase
:set smartcase
:set hlsearch
:nmap \q :nohlsearch<CR>

:nmap <C-e> :e#<CR>     " switch to previously open file via Ctrl-E
:nmap <C-n> :bnext<CR>  " next opened file
:nmap <C-p> :bprev<CR>  " prev opened file

