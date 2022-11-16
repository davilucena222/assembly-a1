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
message db "O resultado final da soma eh ", 0H
requestData db "Digite a condicao de parada da soma: ", 0H
newLine db 0AH
inputString db 50 dup(0)
outputString db 50 dup(0)
inputHandle dd 0 ;armazena o valor de entrada do programa
outputHandle dd 0 ;armazena o dado de saída do programa
console_count dd 0 ;armazena caracteres lidos e escritos na console 
tamanho_string dd 0 ;armazena a string terminada com \0

condicao_de_parada dd 0

 .code
 start:
 invoke GetStdHandle, STD_INPUT_HANDLE
 mov inputHandle, eax
 invoke GetStdHandle, STD_OUTPUT_HANDLE
 mov outputHandle, eax

invoke WriteConsole, outputHandle, addr requestData, sizeof requestData, addr console_count, NULL ;exibindo a mensagem de entrada de dados
invoke ReadConsole, inputHandle, addr inputString, sizeof inputString, addr console_count, NULL ;lendo o dado digitado na console

mov esi, offset inputString
proximo: ;remove caracteres desnecessários da string
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

invoke atodw, addr inputString ;convertendo a representação ASCII para binária (pois o processador opera com números e não com strings)
mov condicao_de_parada, eax ;passando valor convertido para uma variável de memória

soma:
xor eax, eax ;zerando o registrador de eax
mov ecx, 1 ;movendo 1 para o registrador ecx

retorno:
    add eax, ecx ;somando eax com ecx
    inc ecx ;incrementando ecx de 1 em 1
    cmp ecx, condicao_de_parada ;comparando se ecx é igual a 100
    jbe retorno ;"pulando" para o bloco chamado retorno para continuar a execução enquanto ecx não for igual a 100

    invoke dwtoa, eax, addr outputString ;convertendo o valor binário para uma string

    invoke StrLen, addr outputString ;determinando o tamanho do binário convertido para string
    mov tamanho_string, eax

    invoke WriteConsole, outputHandle, addr message, sizeof message, addr console_count, NULL ;exibindo a mensagem de resultado
    invoke WriteConsole, outputHandle, addr outputString, tamanho_string, addr console_count, NULL ;representando o número em ASCII
    invoke WriteConsole, outputHandle, addr newLine, sizeof newLine, addr console_count, NULL 
     
     invoke ExitProcess, 0
 end start
