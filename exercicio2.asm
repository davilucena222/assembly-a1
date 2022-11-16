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
message db "O valor final da soma eh ", 0H
requestDataB db "Digite o valor de B: ", 0H
requestDataC db "Digite o valor de C: ", 0H
newLine db 0AH
inputString db 10 dup(0)
outputString db 10 dup(0)
inputHandle dd 0
outputHandle dd 0
console_count dd 0
tam_outputString dd 0

var_a dd 0
var_b dd 0
var_c dd 0

.code
start:
invoke GetStdHandle, STD_INPUT_HANDLE
mov inputHandle, eax
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov outputHandle, eax

invoke  WriteConsole, outputHandle, addr requestDataB, sizeof requestDataB, addr console_count, NULL
invoke ReadConsole, inputHandle, addr inputString, sizeof inputString, addr console_count, NULL

invoke  WriteConsole, outputHandle, addr requestDataC, sizeof requestDataC, addr console_count, NULL
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
mov var_b, eax

invoke atodw, addr inputString
mov var_c, eax

mov eax, var_b
add eax, var_c
add eax, 100
mov var_a, eax

invoke dwtoa, eax, addr outputString

invoke StrLen, addr outputString
mov tam_outputString, eax

invoke WriteConsole, outputHandle, addr message, sizeof message, addr console_count, NULL 
invoke WriteConsole, outputHandle, addr outputString, tam_outputString, addr console_count, NULL 
invoke WriteConsole, outputHandle, addr newLine, sizeof newLine, addr console_count, NULL 

invoke ExitProcess, 0
end start
