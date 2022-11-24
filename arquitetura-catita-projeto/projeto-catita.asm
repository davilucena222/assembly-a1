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
msgImgEntrada db "Digite o nome da imagem de entrada: ", 0H
msgImgSaida db "Digite o nome da imagem de saida: ", 0H
aumentoIntensidade db "Informe o valor de aumento da intensidade de cor da imagem: ",  0H
selecaoCorBasica db "Informe uma das componentes básicas da imagem a ser alterada. Digite 0 para alterar a componente azul, digite 1 para alterar a componente verde ou 2 para alterar a componente vermelha: ", 0H
newLine db 0AH
inputString db 50 dup(0)
outputString db 50 dup(0)
inputHandle dd 0
outputHandle dd 0
fileHandle dd 0
fileHandleOut dd 0
fileRead dd 0
fileBuffer db 54 dup(0)
fileBuffer2 db 54 dup(0)
console_count dd 0
readCount dd 0
writeCount dd 0
tam_outputString dd 0

nomeImgEntrada db 50 dup(0)
nomeImgSaida db 50 dup(0)
 
.code

start:
invoke GetStdHandle, STD_INPUT_HANDLE
mov inputHandle, eax
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov outputHandle, eax

invoke WriteConsole, outputHandle, addr msgImgEntrada, sizeof msgImgEntrada, addr console_count, NULL 
invoke ReadConsole, inputHandle, addr nomeImgEntrada, sizeof nomeImgEntrada, addr console_count, NULL 

 mov esi, offset nomeImgEntrada
 proximo:
  mov al, [esi]
  inc esi
  cmp al, 13
  jne proximo
  dec esi 
  xor al, al 
  mov [esi], al 

invoke CreateFile, addr nomeImgEntrada, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
mov fileHandle, eax

invoke ReadFile, fileHandle, addr fileBuffer, 54, addr readCount, NULL
invoke CloseHandle, fileHandle

invoke WriteConsole, outputHandle, addr msgImgSaida, sizeof msgImgSaida, addr console_count, NULL 
invoke ReadConsole, inputHandle, addr nomeImgSaida, sizeof nomeImgSaida, addr console_count, NULL 

 mov esi, offset nomeImgSaida
 proximo2:
  mov al, [esi]
  inc esi
  cmp al, 13
  jne proximo2
  dec esi 
  xor al, al 
  mov [esi], al

invoke CreateFile, addr nomeImgSaida, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
mov fileHandleOut, eax

invoke WriteFile, fileHandleOut, addr fileBuffer, 54, addr writeCount, NULL 
invoke CloseHandle, fileHandleOut

invoke CreateFile, addr nomeImgSaida, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
mov fileHandleOut, eax

invoke ReadFile, fileHandleOut, addr fileBuffer2, 54, addr readCount, NULL
invoke CloseHandle, fileHandle

printf("%08X\n", DWORD PTR[fileBuffer2+50])

invoke ExitProcess, 0
end start