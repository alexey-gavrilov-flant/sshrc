set nocompatible
set ruler
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set showcmd
set ai
set cin
colorscheme slate
set ffs=unix,dos,mac
set fencs=utf-8
set list
set listchars=tab:>-,trail:-
set noswapfile
set browsedir=current
set nobackup
set novisualbell
set mouse-=a

set foldenable
set foldmethod=indent
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo

filetype on
filetype plugin on
filetype indent on

if filereadable(expand("$VIMRUNTIME/keymap/russian-jcukenwin.vim"))
   set keymap=russian-jcukenwin
endif
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

set langmenu=ru_ru
set helplang=ru,en
set smartindent
syntax on
set termencoding=utf-8
set hidden
setlocal spell spelllang=
setlocal nospell
function ChangeSpellLang()
  if &spelllang =~ "en_us"
    setlocal spell spelllang=ru
    echo "spelllang: ru"
  elseif &spelllang =~ "ru"
    setlocal spell spelllang=
    setlocal nospell
    echo "spelllang: off"
  else
    setlocal spell spelllang=en_us
    echo "spelllang: en"
  endif
endfunc
map <F2> <Esc>:call ChangeSpellLang()<CR>

set pastetoggle=<F5>
map <F6> :bp<cr>
vmap <F6> <esc>:bp<cr>i
imap <F6> <esc>:bp<cr>i
map <F7> :bn<cr>
vmap <F7> <esc>:bn<cr>i
imap <F7> <esc>:bn<cr>i
imap <F11> <Esc>:set<Space>nu!<CR>a
nmap <F11> :set<Space>nu!<CR>
map <F12> :Ex<cr>
vmap <F12> <esc>:Ex<cr>i
imap <F12> <esc>:Ex<cr>i
imap [ []<LEFT>
imap { {}<LEFT>
function InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
imap <tab> <c-r>=InsertTabWrapper()<cr>
set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t
