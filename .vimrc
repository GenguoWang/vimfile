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

autocmd FileType c,cpp,html,php,python,java set shiftwidth=4 | set expandtab
set nobackup
set nu
hi PmenuSel ctermbg=DarkBlue
hi Visual ctermfg=White ctermbg=LightBlue
imap <silent> <C-K> <Left>
imap <silent> <C-L> <Right>

function RunPythonStr(str)
	return system("python -c'print(".a:str.")'")
endfunction

function RunPython()
	execute "w"
	execute "! python %"
endfunction

function RunCpp()
	execute "w"
	set makeprg=g++\ -o\ %<\ %
	make
	let myfile=expand("%:r")
	if filereadable(myfile)
		execute "! ./%<"
		silent execute "! rm ./%<"
	endif
endfunction

function Test(str)
	return 'OK'
endfunction
function IsCharBeforeCursorEmpty()
	return getline(".")[col(".")-2] =~ "^\\s*$"
endfunction

function IsCurrentLineEmpty()
	return getline(".") =~ "^\\s*$"
endfunction

autocmd FileType cpp nmap <silent> <F5> :call RunCpp()<CR>
autocmd FileType python nmap <silent> <F5> :call RunPython()<CR>
autocmd FileType c,cpp,html,php,python,java inoremap <expr> <TAB> IsCharBeforeCursorEmpty()?"\t":"<C-n>"
autocmd FileType c,cpp,html,php,python,java inoremap <expr> { IsCharBeforeCursorEmpty()?"{<CR>}<ESC>O\t":"{"
nmap <silent> <F7> :echo RunPythonStr(getline("."))<CR>
execute pathogen#infect()
filetype plugin on
set omnifunc=syntaxcomplete#Complete

nnoremap <C-v> pkdd

