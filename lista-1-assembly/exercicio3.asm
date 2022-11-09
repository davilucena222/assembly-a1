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
    constante1 dword 90
    constante2 dword 90
 
    
 .code
 start:
    mov eax, constante1
    cmp eax, constante2
    jg mostrarMaiorValor
    jl mostrarMaiorValor2
    printf("valores iguais, dessa forma o valor é igual a: %d\n", eax)
    invoke ExitProcess, 0
mostrarMaiorValor:
    printf("o maior valor é: %d\n", eax)
    invoke ExitProcess, 0
mostrarMaiorValor2:
    printf("o maior valor é: %d\n", constante2)
    invoke ExitProcess, 0
 end start
