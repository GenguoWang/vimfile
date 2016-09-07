set nocompatible
set incsearch
set hlsearch
set fileencodings=utf-8,gbk 
set ambiwidth=double 
set tabstop=2
set softtabstop=2
set backspace=indent,eol,start
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

set shiftwidth=2 | set expandtab
set nobackup
set nu
hi PmenuSel ctermbg=DarkBlue
hi Visual ctermfg=White ctermbg=LightBlue
imap <silent> <C-K> <Left>
imap <silent> <C-L> <Right>

"http://vim.wikia.com/wiki/VimTip1386
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


function RunPythonStr(str)
	return system("python -c'print(".a:str.")'")
endfunction

function RunPython()
	execute "w !python"
endfunction

function RunRuby()
	execute "w !ruby"
endfunction

function RunTorch()
	execute "w !cat > /tmp/vimtmpTorch.lua"
    execute "! th /tmp/vimtmpTorch.lua"
endfunction

function RunMarkdown()
	execute "w"
	execute "! ~/.vim/tools/md.py % > %.html"
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
autocmd FileType ruby nmap <silent> <F5> :call RunRuby()<CR>
autocmd FileType lua nmap <silent> <F5> :call RunTorch()<CR>
autocmd FileType modula2,markdown nmap <silent> <F5> :call RunMarkdown()<CR>
autocmd FileType c,cpp,html,php,python,java inoremap <expr> <TAB> IsCharBeforeCursorEmpty()?"\t":"<C-n>"
autocmd FileType ruby,lua inoremap <expr> <TAB> IsCharBeforeCursorEmpty()?"\t":"<C-x><C-o>"
autocmd FileType c,cpp,html,php,python,java,lua inoremap <expr> { IsCurrentLineEmpty()?"{<CR>}<ESC>O\t":"{"
nmap <silent> <F7> :echo RunPythonStr(getline("."))<CR>
execute pathogen#infect()
filetype plugin on
set omnifunc=syntaxcomplete#Complete
