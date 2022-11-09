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
 
 .code
    
 start:
    mov eax, 0
    mov ecx, 1

soma:
    add eax, ecx
    inc ecx
    cmp ecx, 100
    jle soma        

     printf("o valor da soma total é: %d\n", eax)      
     invoke ExitProcess, 0
 end start
