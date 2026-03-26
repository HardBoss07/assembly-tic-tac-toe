section .data

; LOGO LINES
; 0xE2, 0x96, 0x88 is the block character, 32 is space. 
; Added 10 (newline) at the end of each line for easier printing.
TN DB "###############################################################", 10, 0
T1 DB "#  █████ █████  ███    █████   █    ███    █████  ███  █████  #", 10, 0
T2 DB "#    █     █   █   █     █    █ █  █   █     █   █   █ █      #", 10, 0
T3 DB "#    █     █   █         █    █ █  █         █   █   █ ████   #", 10, 0
T4 DB "#    █     █   █   █     █   █████ █   █     █   █   █ █      #", 10, 0
T5 DB "#    █   █████  ███      █   █   █  ███      █    ███  █████  #", 10, 0

; STRINGS
TAGLINE DB 'Developed by Matteo "HardBoss07" Bosshard', 10, 0
PAK     DB 'any key input to continue...', 10, 0

; RULES
R  DB 'Game Rules:', 10, 0
R1 DB '1. Players will take turns.', 10, 0
R2 DB '2. Player 1 will start the game.', 10, 0
R3 DB '3. Player 1 will set "X" and Player 2 will set "O".', 10, 0
R4 DB '4. The board is marked with cell numbers.', 10, 0
R5 DB '5. Enter cell NUMBER to place your mark.', 10, 0
R6 DB '6. Set 3 of your marks horizontally, vertically or diagonally to win.', 10, 0
R7 DB 'Good Luck!', 10, 0

; GAME BOARD COMPONENTS
PC1 DB ' (X)', 0
PC2 DB ' (O)', 0
L1  DB '   |   |   ', 10, 0
L2  DB '-----------', 10, 0
N1  DB ' | ', 0

; CELL STATE (Initially numbers 1-9)
C1 DB '1', 0
C2 DB '2', 0
C3 DB '3', 0
C4 DB '4', 0
C5 DB '5', 0
C6 DB '6', 0
C7 DB '7', 0
C8 DB '8', 0
C9 DB '9', 0

; GAME VARIABLES
PLAYER DB '2'        ; Character '2' (ASCII 50)
MOVES  DB 0
DONE   DB 0
DR     DB 0
CUR    DB 'X'

; UI STRINGS
INP DB 32, ':: Enter cell no. : ', 0
TKN DB 'This cell is taken! any key input...', 10, 0
W1  DB 'Player ', 0
W2  DB ' won the game!', 10, 0
DRW DB 'The game is draw!', 10, 0
TRA DB 'Want to play again? (y/n): ', 0
WI  DB 32, 32, 32, 'Wrong input! any key input...   ', 10, 0
EMP DB '                                         ', 10, 0

; CURSOR BUFFER
cursor_buf DB 27, '[00;00H', 0

; ESC [ 2 J  (Clears the entire screen)
; ESC [ H    (Moves cursor to top-left / Home)
clear_seq db 27, '[2J', 27, '[H', 0

; Saving state of Terminal
section .bss
    termios_orig resb 60    ; Buffer to store original terminal settings
    termios_raw  resb 60    ; Buffer for modified "raw" settings

section .text
    global _start

_start:
    ; Clearing Screen before starting program
    call ClearScreen
    
    ; Title Screen
    call TitleScreen

    ; Await Press Any Key
    call PressAnyKey

    ; Clearing Screen before printing rules
    call ClearScreen

    ; Print Rules
    call PrintRules

    ; Await Press Any Key
    call PressAnyKey

    ; Init Game
    call Init

    ; Exit Program properly
    mov rax, 60         ; sys_exit
    xor rdi, rdi
    syscall

; SetCursor: Moves cursor using ANSI escape sequences
; Input: rdi = Row, rsi = Col
SetCursor:
    push rax
    push rdx
    push rdi
    push rsi

    ; Convert Row (RDI) to ASCII '00'
    mov rax, rdi
    mov dl, 10
    div dl              ; AL = tens, AH = units
    add al, '0'
    add ah, '0'
    mov [cursor_buf + 2], al
    mov [cursor_buf + 3], ah

    ; Convert Col (RSI) to ASCII '00'
    mov rax, rsi
    mov dl, 10
    div dl              ; AL = tens, AH = units
    add al, '0'
    add ah, '0'
    mov [cursor_buf + 5], al
    mov [cursor_buf + 6], ah

    ; Print the finished buffer
    mov rdi, cursor_buf
    call PrintString

    pop rsi
    pop rdi
    pop rdx
    pop rax
    ret

; PrintString: Prints a null-terminated string
; Input: rdi = adress of string
PrintString:
    push rax
    push rbx
    push rcx
    push rdx
    
    mov rbx, rdi                            ; Put adress in rbx

    ; Find string length
    xor rdx, rdx
.loop_len:
    cmp byte [rbx + rdx], 0
    je .do_print
    inc rdx
    jmp .loop_len

.do_print:
    mov rax, 1                              ; sys_write
    mov rsi, rbx                            ; buffer adress
    mov rdi, 1                              ; stdout
    syscall                                 ; rdx already has the length

    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

; ClearScreen: Clears entire screen and resets cursor to top left
ClearScreen:
    push rdi
    mov rdi, clear_seq
    call PrintString
    pop rdi
    ret

; TitleScreen: Prints out the title screen
TitleScreen:
    push rdi
    push rsi

    ; Set Cursor to Row 6, Col 14
    mov rdi, 6          ; Row
    mov rsi, 14         ; Col
    call SetCursor
    mov rdi, TN         ; Loading Border Title Screen Line
    call PrintString

    ; Set Cursor to Row 7, Col 14
    mov rdi, 7          ; Row
    mov rsi, 14         ; Col
    call SetCursor
    mov rdi, T1         ; Loading 1. Title Screen Line
    call PrintString

    ; Set Cursor to Row 8, Col 14
    mov rdi, 8          ; Row
    mov rsi, 14         ; Col
    call SetCursor
    mov rdi, T2         ; Loading 2. Title Screen Line
    call PrintString

    ; Set Cursor to Row 9, Col 14
    mov rdi, 9          ; Row
    mov rsi, 14         ; Col
    call SetCursor
    mov rdi, T3         ; Loading 3. Title Screen Line
    call PrintString

    ; Set Cursor to Row 10, Col 14
    mov rdi, 10         ; Row
    mov rsi, 14         ; Col
    call SetCursor
    mov rdi, T4         ; Loading 4. Title Screen Line
    call PrintString

    ; Set Cursor to Row 11, Col 14
    mov rdi, 11         ; Row
    mov rsi, 14         ; Col
    call SetCursor
    mov rdi, T5         ; Loading 5. Title Screen Line
    call PrintString

    ; Set Cursor to Row 12, Col 14
    mov rdi, 12         ; Row
    mov rsi, 14         ; Col
    call SetCursor
    mov rdi, TN         ; Loading Border Title Screen Line
    call PrintString

    ; Set Cursor to Row 14, Col 24
    mov rdi, 14         ; Row
    mov rsi, 24         ; Col
    call SetCursor
    mov rdi, TAGLINE    ; Loading Tagline
    call PrintString

    ; Exit function
    pop rsi
    pop rdi
    ret

; PressAnyKey: Prints PAK string and waits for a single keypress
PressAnyKey:
    push rax
    push rdi
    push rsi
    push rdx
    push rcx

    ; 1. Printing PAK string
    mov rdi, PAK
    call PrintString

    ; 2. Get current terminal settings (TCGETS) into termios_orig
    mov rax, 16             ; sys_ioctl
    mov rdi, 0              ; stdin (fd 0)
    mov rsi, 0x5401         ; TCGETS constant
    mov rdx, termios_orig
    syscall

    ; 3. COPY termios_orig to termios_raw
    ; This is the missing piece! We need a starting point for raw mode.
    mov rsi, termios_orig
    mov rdi, termios_raw
    mov rcx, 60             ; termios struct size is 60 bytes
    cld
    rep movsb               ; Copy memory from rsi to rdi

    ; 4. Modify termios_raw for "Raw" mode
    ; Clear ICANON (bit 1) and ECHO (bit 3) in c_lflag (offset 12)
    and dword [termios_raw + 12], ~(2 | 8)

    ; 5. Set new terminal settings (TCSETS) using our modified raw buffer
    mov rax, 16             ; sys_ioctl
    mov rdi, 0              ; stdin
    mov rsi, 0x5402         ; TCSETS constant
    mov rdx, termios_raw
    syscall

    ; 6. Read 1 character from stdin
    mov rax, 0              ; sys_read
    mov rdi, 0              ; stdin
    sub rsp, 1              ; Create 1 byte of space on stack
    mov rsi, rsp            ; Read into stack space
    mov rdx, 1              ; 1 byte
    syscall
    add rsp, 1              ; Clean up stack

    ; 7. Restore original terminal settings
    mov rax, 16             ; sys_ioctl
    mov rdi, 0              ; stdin
    mov rsi, 0x5402         ; TCSETS
    mov rdx, termios_orig
    syscall

    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop rax
    ret

; PrintRules: Prints the list of rules
PrintRules:
    push rdi
    push rsi

    ; Set Cursor to Row 6, Col 14
    mov rdi, 6          ; Row
    mov rsi, 14         ; Col
    call SetCursor
    mov rdi, R          ; Loading 0. Rule line          
    call PrintString

    ; Set Cursor to Row 8, Col 4
    mov rdi, 8          ; Row
    mov rsi, 4          ; Col
    call SetCursor
    mov rdi, R1         ; Loading 1. Rule line
    call PrintString

    ; Set Cursor to Row 8, Col 4
    mov rdi, 8          ; Row
    mov rsi, 4          ; Col
    call SetCursor
    mov rdi, R1         ; Loading 1. Rule line
    call PrintString

    ; Set Cursor to Row 9, Col 4
    mov rdi, 9          ; Row
    mov rsi, 4          ; Col
    call SetCursor
    mov rdi, R2         ; Loading 2. Rule line
    call PrintString

    ; Set Cursor to Row 10, Col 4
    mov rdi, 10         ; Row
    mov rsi, 4          ; Col
    call SetCursor
    mov rdi, R3         ; Loading 3. Rule line
    call PrintString

    ; Set Cursor to Row 11, Col 4
    mov rdi, 11         ; Row
    mov rsi, 4          ; Col
    call SetCursor
    mov rdi, R4         ; Loading 4. Rule line
    call PrintString

    ; Set Cursor to Row 12, Col 4
    mov rdi, 12         ; Row
    mov rsi, 4          ; Col
    call SetCursor
    mov rdi, R5         ; Loading 5. Rule line
    call PrintString

    ; Set Cursor to Row 13, Col 4
    mov rdi, 13         ; Row
    mov rsi, 4          ; Col
    call SetCursor
    mov rdi, R6         ; Loading 6. Rule line
    call PrintString

    ; Set Cursor to Row 15, Col 14
    mov rdi, 15          ; Row
    mov rsi, 14          ; Col
    call SetCursor
    mov rdi, R7          ; Loading 7. Rule line          
    call PrintString

    pop rsi
    pop rdi
    ret

; Init: Initializes all game variables
Init:
    ; Initialize game state variables
    mov byte [PLAYER], '2'
    mov byte [MOVES], 0
    mov byte [DONE], 0
    mov byte [DR], 0

    ; Reset Board Cells
    mov byte [C1], '1'
    mov byte [C2], '2'
    mov byte [C3], '3'
    mov byte [C4], '4'
    mov byte [C5], '5'
    mov byte [C6], '6'
    mov byte [C7], '7'
    mov byte [C8], '8'
    mov byte [C9], '9'

    jmp PlayerChange

; PlayerChange: handles player change
PlayerChange:
    cmp byte [PLAYER], '1'
    je SetP2

SetP1:
    mov byte [PLAYER], '1'
    mov byte [CUR], 'X'
    jmp done_change

SetP2:
    mov byte [PLAYER], '2'
    mov byte [CUR], 'O'

done_change:
    call PrintBoard
    ret