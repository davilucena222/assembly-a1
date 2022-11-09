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
    numero dword 3
 
    
 .code
 start:
    mov eax, numero
    jnz mostrarImpar
    printf("numero par")
    invoke ExitProcess, 0

mostrarImpar:
    printf("numero impar")
    invoke ExitProcess, 0
 end start
