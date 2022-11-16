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
mensagemPar db "O numero eh par", 0H
mensagemImpar db "O numero eh impar", 0H
requestData db "Digite um numero: ", 0H
newLine db 0AH
inputString db 10 dup(0)
outputString db 10 dup(0)
inputHandle dd 0 
outputHandle dd 0
console_count dd 0 
tamanho_string dd 0 

numero dd 0
    
 .code
 start:
 invoke GetStdHandle, STD_INPUT_HANDLE
 mov inputHandle, eax
 invoke GetStdHandle, STD_OUTPUT_HANDLE
 mov outputHandle, eax

invoke WriteConsole, outputHandle, addr requestData, sizeof requestData, addr console_count, NULL 
invoke ReadConsole, inputHandle, addr inputString, sizeof inputString, addr console_count, NULL 

mov esi, offset inputString
proximo:
    mov al, [esi] 
    inc esi
    cmp al, 48
    jl terminar
    cmp al, 58 
    jl proximo
terminar:
    dec esi 
    xor al, al 
    mov [esi], al 
    
invoke atodw, addr inputString 
mov numero, eax

 xor edx, edx
 mov eax, numero 
 mov ecx, 2 
 div ecx 
 cmp edx, 0
 je eh_par 

 invoke WriteConsole, outputHandle, addr mensagemImpar, sizeof mensagemImpar, addr console_count, NULL 
 invoke WriteConsole, outputHandle, addr outputString, tamanho_string, addr console_count, NULL 
 invoke WriteConsole, outputHandle, addr newLine, sizeof newLine, addr console_count, NULL 

 invoke ExitProcess, 0

 eh_par:
 invoke WriteConsole, outputHandle, addr mensagemPar, sizeof mensagemPar, addr console_count, NULL 
 invoke WriteConsole, outputHandle, addr outputString, tamanho_string, addr console_count, NULL 
 invoke WriteConsole, outputHandle, addr newLine, sizeof newLine, addr console_count, NULL 
 
 invoke ExitProcess, 0
    
 end start
