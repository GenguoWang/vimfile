set nocompatible
set incsearch
set hlsearch
set fileencodings=utf-8,gbk 
set ambiwidth=double 
set tabstop=4
set softtabstop=4
syntax on

set ai

colorscheme freya
if has('win32')
au GUIEnter * simalt ~x

else
au GUIEnter * call MaximizeWindow()
endif

function! MaximizeWindow()
silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction
autocmd FileType c,cpp,html,php,python set shiftwidth=4 | set expandtab
set nobackup
set nu
imap <silent> <C-K> <Left>
imap <silent> <C-L> <Right>
function Runpython(str)
return system("python ".a:str)
endfunction
function RunCpp()

execute "w"

set makeprg=g++\ -o\ %<\ %

silent make
let myfile=expand("%:r")
if filereadable(myfile)
execute "! ./%< && rm ./%<"
endif
endfunction
if has('win32')
nmap <silent> ;c :w<CR>:!vc "%"<CR>
else
nmap <silent> ;c :call RunCpp()<CR>
endif
nmap <silent> ;p :echo Runpython(bufname(winbufnr(winnr())))<CR>
nmap <silent> ;r :echo Runpython("-cprint(".getline(".").")")<CR>
nmap <silent> ;bs \bs
nmap <silent> ;bv \bv
nmap <silent> ;be \be
execute pathogen#infect()
filetype plugin on
set omnifunc=syntaxcomplete#Complete
