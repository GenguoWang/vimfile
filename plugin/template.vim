function AddHeader()
	let s:tmpLine = line(".")
	let s:strname = toupper(expand("%:t"))
	let s:DEF = substitute(s:strname,'\.','_',"")
	let s:DEF = "_".s:DEF."_"
	
	call append(s:tmpLine-1,"#ifndef ".s:DEF)
	call append(s:tmpLine,"#define ".s:DEF)
	call append(s:tmpLine+1,"#endif")
	return s:tmpLine
endfunction

function NewCPP()
	call append(0,"#include <iostream>")
	call append(1,"#include <string>")
	call append(2,"#include <vector>")
	call append(3,"using namespace std;")
	call append(4,"int main(int argc, char *argv[])")
	call append(5,"{")
	call append(6,"	return 0;")
	call append(7,"}")
endfunction
