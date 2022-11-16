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
message db "-> ", 0H
request db "Forneça o valor inicial que seja menor que 1999: ", 0H
newLine db 0AH
inputString db 10 dup(0)
outputString db 10 dup(0)
inputHandle dd 0
outputHandle dd 0
console_count dd 0
tam_outputString dd 0

contador dword 0
 
.code

start:
invoke GetStdHandle, STD_INPUT_HANDLE
mov inputHandle, eax
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov outputHandle, eax

invoke WriteConsole, outputHandle, addr request, sizeof request, addr console_count, NULL 
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
mov contador, eax

mov edx, 0
mov ecx, 11

rotina:
inc contador
mov eax, contador
mov edx, 0
div ecx
cmp edx, 5
je exibindo

cmp contador, 1999
je terminei
    
jmp rotina

exibindo:
invoke dwtoa, eax, addr outputString
invoke StrLen, addr outputString
mov tam_outputString, eax

invoke WriteConsole, outputHandle, addr message, sizeof message, addr console_count, NULL 
invoke WriteConsole, outputHandle, addr outputString, tam_outputString, addr console_count, NULL 
invoke WriteConsole, outputHandle, addr newLine, sizeof newLine, addr console_count, NULL 

invoke atodw, addr inputString
mov contador, eax

cmp contador, 1999
je terminei

jmp rotina

terminei:
invoke ExitProcess, 0
 end start