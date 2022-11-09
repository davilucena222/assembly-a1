 .686
 .model flat, stdcall
 option casemap :none
 
 include \masm32\include\windows.inc
 include \masm32\include\kernel32.inc
 include \masm32\include\masm32.inc
 include \masm32\include\msvcrt.inc
 includelib \masm32\lib\kernel32.lib
 includelib \masm32\lib\masm32.lib
 includelib \masm32\lib\msvcrt.lib
 include \masm32\macros\macros.asm

.data
    bb dword 30
    cc dword 40
 
    
 .code
 start:
    mov eax, bb
    add eax, cc
    add eax, 100
    

     printf("o valor da soma eh igual a: %d\n", eax)      
     invoke ExitProcess, 0
 end start
