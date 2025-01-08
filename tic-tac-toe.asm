.MODEL SMALL
.STACK 500H

.DATA

; lines for tic tac toe logo
T1 DB 219,  219, 219,  219,  219, 32,  219, 32,  219,  219,  219,  219, 32, 32, 32,  219,  219,  219, 219,  219, 32, 32,  219,  219, 32, 32,  219, 219,  219,  219,  32, 32, 32,   219,  219, 219,  219,  219,  32, 32,  219,   219, 32, 32, 219, 219, 219, 219, '$'
T2 DB 32, 32, 219, 32, 32, 32,  219, 32,  219, 32, 32, 32, 32, 32, 32, 32, 32, 219, 32, 32, 32,  219, 32, 32,  219, 32,  219, 32, 32, 32, 32, 32, 32 , 32, 32, 219, 32, 32,  32,  219, 32,  32,  219, 32, 219,'$'
T3 DB 32, 32, 219, 32, 32, 32,  219, 32,  219, 32, 32, 32, 32, 32, 32, 32, 32, 219, 32, 32, 32,  219,  219,  219,  219, 32,  219, 32, 32, 32, 32, 32, 32 , 32, 32, 219, 32, 32,  32,  219, 32,  32,  219, 32, 219, 219, 219, 219,'$'
T4 DB 32, 32, 219, 32, 32, 32,  219, 32,  219,  219,  219,  219, 32,  219, 32, 32, 32, 219, 32, 32, 32,  219, 32, 32,  219, 32,  219,  219,  219,  219, 32,  219, 32 , 32, 32, 219, 32, 32,  32, 32,  219,   219, 32, 32, 219, 219, 219, 219,'$'

; dev name
TAGLINE DB  'Developed by Matteo "HardBoss07" Bosshard$'

; strings used during runtime

PAK DB 'any key input to continue...$'

; rules
R DB 'Game Rules:$'
R1 DB '1. Players will take turns.$'
R2 DB '2. Player 1 will start the game.$'
R3 DB '3. Player 1 will set "X" and Player 2 will set "O".$'
R4 DB '4. The board is marked with cell numbers.$'
R5 DB '5. Enter cell NUMBER to place your mark.$'
R6 DB '6. Set 3 of your marks horizontally, vertically or diagonally to win.$'

R7 DB 'Good Luck!$'

; cell marks for players
PC1 DB ' (X)$'
PC2 DB ' (O)$'

; board lines
L1 DB '   |   |   $'
L2 DB '-----------$'
N1 DB ' | $'

; cell numbers
C1 DB '1$'
C2 DB '2$'
C3 DB '3$'
C4 DB '4$'
C5 DB '5$'
C6 DB '6$'
C7 DB '7$'
C8 DB '8$'
C9 DB '9$'

; player vars
PLAYER DB 50, '$'
MOVES DB 0
DONE DB 0
DR DB 0

; input promts
INP DB 32, ':: Enter cell no. : $'
TKN DB 'This cell is taken! any key input...$'

; current mark (X/O)
CUR DB 88

; final msg
W1 DB 'Player $'
W2 DB ' won the game!$'
DRW DB 'The game is draw!$'

; try again msg
TRA DB 'Want to play again? (y/n): $'
WI DB  32, 32, 32, 'Wrong input! any key input...   $'

; clean line
EMP DB '                                        $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; display title screen
    TITLESCREEN:

        ; logo display

            ; set cursor
            MOV AH, 2
            MOV BH, 0
            MOV DH, 6
            MOV DL, 14
            INT 10h

        LEA DX, T1
        MOV AH, 9
        INT 21h

            ; set cursor
            MOV AH, 2
            MOV DH, 7
            MOV DL, 14
            INT 10h

        LEA DX, T2
        MOV AH, 9
        INT 21h

            ; set cursor
            MOV AH, 2
            MOV DH, 8
            MOV DL, 14
            INT 10h

        LEA DX, T3
        MOV AH, 9
        INT 21h

            ; set cursor
            MOV AH, 2
            MOV DH, 9
            MOV DL, 14
            INT 10h

        LEA DX, T2
        MOV AH, 9
        INT 21h

            ; set cursor
            MOV AH, 2
            MOV DH, 10
            MOV DL, 14
            INT 10h

        LEA DX, T4
        MOV AH, 9
        INT 21h

        ; logo display end

            ; set cursor
            MOV AH, 2
            MOV DH, 12
            MOV DL, 22
            INT 10h

        LEA DX, TAGLINE  ; dev name
        MOV AH, 9
        INT 21h

            ; set cursor
            MOV AH, 2
            MOV DH, 13
            MOV DL, 24
            INT 10h

        LEA DX, PAK  ; any key input
        MOV AH, 9
        INT 21h

        MOV AH, 7
        INT 21h

            ; clear screen

            MOV AX,0600h
            MOV BH,07h
            MOV CX,0000h
            MOV DX,184fh
            INT 10h

            JMP RULES

    RULES:
            ; set cursor
            MOV AH, 2
            MOV BH, 0
            MOV DH, 6
            MOV DL, 7
            INT 10h

        LEA DX, R
        MOV AH, 9
        INT 21h

            ; set cursor
            MOV AH, 2
            MOV DH, 7
            MOV DL, 7
            INT 10h

        LEA DX, R1   ; rule 1
        MOV AH, 9
        INT 21h

            ; set cursor
            MOV AH, 2
            MOV DH, 8
            MOV DL, 7
            INT 10h

        LEA DX, R2   ; rule 2
        MOV AH, 9
        INT 21h

            ; set cursor
            MOV AH, 2
            MOV DH, 9
            MOV DL, 7
            INT 10h

        LEA DX, R3   ; rule 3
        MOV AH, 9
        INT 21h

            ; set cursor
            MOV AH, 2
            MOV DH, 10
            MOV DL, 7
            INT 10h

        LEA DX, R4   ; rule 4
        MOV AH, 9
        INT 21h


            ; set cursor
            MOV AH, 2
            MOV DH, 11
            MOV DL, 7
            INT 10h


        LEA DX, R5  ; rule 5
        MOV AH, 9
        INT 21h


            ; set cursor
            MOV AH, 2
            MOV DH, 12
            MOV DL, 7
            INT 10h


        LEA DX, R6
        MOV AH, 9
        INT 21h

           ; set cursor
            MOV AH, 2
            MOV DH, 13
            MOV DL, 7
            INT 10h

       LEA DX, R7
       MOV AH, 9
       INT 21h

            ; set cursor
            MOV AH, 2
            MOV DH, 15
            MOV DL, 7
            INT 10h

        LEA DX, PAK ; any key input
        MOV AH, 9
        INT 21h

        MOV AH, 7
        INT 21h

    ; init

       INIT:
            ; init all variables
            MOV PLAYER, 50
            MOV MOVES, 0
            MOV DONE, 0
            MOV DR, 0

            MOV C1, 49
            MOV C2, 50
            MOV C3, 51
            MOV C4, 52
            MOV C5, 53
            MOV C6, 54
            MOV C7, 55
            MOV C8, 56
            MOV C9, 57

            JMP PLRCHANGE

    ; victory

    VICTORY:

            LEA DX, W1
            MOV AH, 9
            INT 21h

            LEA DX, PLAYER
            MOV AH, 9
            INT 21h

            LEA DX, W2
            MOV AH, 9
            INT 21h

                ; set cursor
                MOV AH, 2
                MOV DH, 17
                MOV DL, 28
                INT 10h

            LEA DX, PAK  ; any key input
            MOV AH, 9
            INT 21h

            MOV AH, 7
            INT 21h

            JMP TRYAGAIN

    ; draw game

    DRAW:
            LEA DX, DRW
            MOV AH, 9
            INT 21h

                ; set cursor
                MOV AH, 2
                MOV DH, 17
                MOV DL, 28
                INT 10h

            LEA DX, PAK ; any key input
            MOV AH, 9
            INT 21h

            MOV AH, 7
            INT 21h

            JMP TRYAGAIN

    ; any winning combinations?

    CHECK:   ; 8 possible combinations

        CHECK1:  ; checking combo combo 1, 2, 3
            MOV AL, C1
            MOV BL, C2
            MOV CL, C3

            CMP AL, BL
            JNZ CHECK2

            CMP BL, CL
            JNZ CHECK2

            MOV DONE, 1
            JMP BOARD

        CHECK2:  ; checking combo 4, 5, 6
            MOV AL, C4
            MOV BL, C5
            MOV CL, C6

            CMP AL, BL
            JNZ CHECK3

            CMP BL, CL
            JNZ CHECK3


            MOV DONE, 1
            JMP BOARD


       CHECK3:  ; checking combo 7, 8, 9
            MOV AL, C4
            MOV BL, C5
            MOV CL, C6

            CMP AL, BL
            JNZ CHECK4

            CMP BL, CL
            JNZ CHECK4

            MOV DONE, 1
            JMP BOARD


       CHECK4:   ; checking combo 1, 4, 7
            MOV AL, C1
            MOV BL, C4
            MOV CL, C7

            CMP AL, BL
            JNZ CHECK5

            CMP BL, CL
            JNZ CHECK5

            MOV DONE, 1
            JMP BOARD


       CHECK5:   ; checking combo 2, 5, 8
            MOV AL, C2
            MOV BL, C5
            MOV CL, C8

            CMP AL, BL
            JNZ CHECK6

            CMP BL, CL
            JNZ CHECK6

            MOV DONE, 1
            JMP BOARD


       CHECK6:   ; checking combo 3, 6, 9
            MOV AL, C3
            MOV BL, C6
            MOV CL, C9

            CMP AL, BL
            JNZ CHECK7

            CMP BL, CL
            JNZ CHECK7

            MOV DONE, 1
            JMP BOARD


        CHECK7:   ; checking combo 1, 5, 9
            MOV AL, C1
            MOV BL, C5
            MOV CL, C9

            CMP AL, BL
            JNZ CHECK8

            CMP BL, CL
            JNZ CHECK8

            MOV DONE, 1
            JMP BOARD


        CHECK8:   ; checking combo 3, 5, 7
            MOV AL, C3
            MOV BL, C5
            MOV CL, C7

            CMP AL, BL
            JNZ DRAWCHECK

            CMP BL, CL
            JNZ DRAWCHECK

            MOV DONE, 1
            JMP BOARD

       DRAWCHECK:
            MOV AL, MOVES
            CMP AL, 9
            JB PLRCHANGE

            MOV DR, 1
            JMP BOARD

            JMP EXIT

    ; player
    PLRCHANGE:

        CMP PLAYER, 49
        JZ P2
        CMP PLAYER, 50
        JZ P1

        P1:
            MOV PLAYER, 49
            MOV CUR, 88

            JMP BOARD

        P2:
            MOV PLAYER, 50
            MOV CUR, 79
            JMP BOARD

    ; board
    BOARD:

        ; clear screen
        MOV AX,0600h
        MOV BH,07h
        MOV CX,0000h
        MOV DX,184fh
        INT 10h

        ; set cursor
        MOV AH, 2
        MOV BH, 0
        MOV DH, 6
        MOV DL, 30
        INT 10h

    LEA DX, L1
    MOV AH, 9
    INT 21h

        ; set cursor
        MOV AH, 2
        MOV DH, 7
        MOV DL, 30
        INT 10h

    MOV AH, 2
    MOV DL, 32
    INT 21h

    ; cell 1

    LEA DX, C1
    MOV AH, 9
    INT 21h

    LEA DX, N1
    MOV AH, 9
    INT 21h

    ; cell 2

    LEA DX, C2
    MOV AH, 9
    INT 21h

    LEA DX, N1
    MOV AH, 9
    INT 21h

    ; cell 3

    LEA DX, C3
    MOV AH, 9
    INT 21h

    ; set cursor
    MOV AH, 2
    MOV DH, 8
    MOV DL, 30
    INT 10h

    LEA DX, L2
    MOV AH, 9
    INT 21h

    ; set cursor
    MOV AH, 2
    MOV DH, 9
    MOV DL, 30
    INT 10h

    LEA DX, L1
    MOV AH, 9
    INT 21h

    ; set cursor
    MOV AH, 2
    MOV DH, 10
    MOV DL, 30
    INT 10h

    MOV AH, 2
    MOV DL, 32
    INT 21h

    ; cell 4

    LEA DX, C4
    MOV AH, 9
    INT 21h

    LEA DX, N1
    MOV AH, 9
    INT 21h

    ; cell 5

    LEA DX, C5
    MOV AH, 9
    INT 21h

    LEA DX, N1
    MOV AH, 9
    INT 21h

    ; cell 6

    LEA DX, C6
    MOV AH, 9
    INT 21h

    ; set cursor
    MOV AH, 2
    MOV DH, 11
    MOV DL, 30
    INT 10h

    LEA DX, L1
    MOV AH, 9
    INT 21h

    ; set cursor
    MOV AH, 2
    MOV DH, 12
    MOV DL, 30
    INT 10h

    LEA DX, L2
    MOV AH, 9
    INT 21h

    ; set cursor
    MOV AH, 2
    MOV DH, 13
    MOV DL, 30
    INT 10h

    LEA DX, L1
    MOV AH, 9
    INT 21h

    ; set cursor
    MOV AH, 2
    MOV DH, 14
    MOV DL, 30
    INT 10h

    MOV AH, 2
    MOV DL, 32
    INT 21h

    ; cell 4

    LEA DX, C7
    MOV AH, 9
    INT 21h

    LEA DX, N1
    MOV AH, 9
    INT 21h

    ; cell 5

    LEA DX, C8
    MOV AH, 9
    INT 21h

    LEA DX, N1
    MOV AH, 9
    INT 21h

    ; cell 6

    LEA DX, C9
    MOV AH, 9
    INT 21h

    ; set cursor
    MOV AH, 2
    MOV DH, 15
    MOV DL, 30
    INT 10h

    LEA DX, L1
    MOV AH, 9
    INT 21h

    ; set cursor
    MOV AH, 2
    MOV DH, 16
    MOV DL, 20
    INT 10h

    CMP DONE, 1
    JZ VICTORY

    CMP DR, 1
    JZ DRAW

    ; end board

    ; input

    INPUT:

    LEA DX, W1
    MOV AH, 9
    INT 21h

    MOV AH, 2
    MOV DL, PLAYER
    INT 21h

    CMP PLAYER, 49
    JZ PL1

        LEA DX, PC2
        MOV AH, 9
        INT 21h
        JMP TAKEINPUT

        PL1:
            LEA DX, PC1
            MOV AH, 9
            INT 21h

    TAKEINPUT:
    LEA DX, INP
    MOV AH, 9
    INT 21h

    MOV AH, 1
    INT 21h

    INC MOVES ; increment counter by 1

    MOV BL, AL
    SUB BL, 48

    MOV CL, CUR

    ; checking combo if input is between 1-9
    CMP BL, 1
    JZ  C1U

    CMP BL, 2
    JZ  C2U

    CMP BL, 3
    JZ  C3U

    CMP BL, 4
    JZ  C4U

    CMP BL, 5
    JZ  C5U

    CMP BL, 6
    JZ  C6U

    CMP BL, 7
    JZ  C7U

    CMP BL, 8
    JZ  C8U

    CMP BL, 9
    JZ  C9U

    ; if invalid input

    DEC MOVES ; decrementing moves by 1 if invalid move

        ; set cursor
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20
        INT 10h

    LEA DX, WI  ; wrong move
    MOV AH, 9
    INT 21h

    MOV AH, 7
    INT 21h

        ; set cursor
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20
        INT 10h

    LEA DX, EMP  ; clear line
    MOV AH, 9
    INT 21h

        ; set cursor
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20
        INT 10h

    JMP INPUT

    TAKEN:
        DEC MOVES
            ; set cursor
            MOV AH, 2
            MOV DH, 16
            MOV DL, 20
            INT 10h

        LEA DX, TKN   ; cell taken display
        MOV AH, 9
        INT 21h

        MOV AH, 7
        INT 21h

            ; set cursor
            MOV AH, 2
            MOV DH, 16
            MOV DL, 20
            INT 10h

        LEA DX, EMP   ; empty line to overwrite
        MOV AH, 9
        INT 21h

            ; set cursor
            MOV AH, 2
            MOV DH, 16
            MOV DL, 20
            INT 10h

        JMP INPUT

    ; setting board based off input marks
        C1U:
            CMP C1, 88  ; check combo if cell is already X
            JZ TAKEN
            CMP C1, 79  ; check combo if cell is already O
            JZ TAKEN

            MOV C1, CL
            JMP CHECK

        C2U:
            CMP C2, 88  ; check combo if cell is already X
            JZ TAKEN
            CMP C2, 79  ; check combo if cell is already O
            JZ TAKEN

            MOV C2, CL
            JMP CHECK
        C3U:
            CMP C3, 88  ; check combo if cell is already X
            JZ TAKEN
            CMP C3, 79  ; check combo if cell is already O
            JZ TAKEN

            MOV C3, CL
            JMP CHECK
        C4U:
            CMP C4, 88  ; check combo if cell is already X
            JZ TAKEN
            CMP C4, 79  ; check combo if cell is already O
            JZ TAKEN

            MOV C4, CL
            JMP CHECK
        C5U:
            CMP C5, 88  ; check combo if cell is already X
            JZ TAKEN
            CMP C5, 79  ; check combo if cell is already O
            JZ TAKEN

            MOV C5, CL
            JMP CHECK
        C6U:
            CMP C6, 88  ; check combo if cell is already X
            JZ TAKEN
            CMP C6, 79  ; check combo if cell is already O
            JZ TAKEN

            MOV C6, CL
            JMP CHECK
        C7U:
            CMP C7, 88   ; check combo if cell is already X
            JZ TAKEN
            CMP C7, 79   ; check combo if cell is already O
            JZ TAKEN

            MOV C7, CL
            JMP CHECK
        C8U:
            CMP C8, 88   ; check combo if cell is already X
            JZ TAKEN
            CMP C8, 79   ; check combo if cell is already O
            JZ TAKEN

            MOV C8, CL
            JMP CHECK
        C9U:
            CMP C9, 88   ; check combo if cell is already X
            JZ TAKEN
            CMP C9, 79   ; check combo if cell is already O
            JZ TAKEN

            MOV C9, CL
            JMP CHECK

    ; try again
    TRYAGAIN:
            ; clear screen

            MOV AX,0600h
            MOV BH,07h
            MOV CX,0000h
            MOV DX,184fh
            INT 10h

            ; set cursor
            MOV AH, 2
            MOV BH, 0
            MOV DH, 10
            MOV DL, 24
            INT 10h

        LEA DX, TRA   ; try again promt
        MOV AH, 9
        INT 21h

        MOV AH, 1
        INT 21h

        CMP AL, 121  ;check if input is 'y'
        JZ INIT

        CMP AL, 89   ;check if input is 'Y'
        JZ INIT

        ; if input is 'y' or 'Y' restart

        CMP AL, 110  ;check if input is 'n'
        JZ EXIT
        CMP AL, 78   ;check if input is 'N'
        JZ EXIT

        ; if invalid input

            ; set cursor
            MOV AH, 2
            MOV BH, 0
            MOV DH, 10
            MOV DL, 24
            INT 10h

        LEA DX, WI  ; wrong input
        MOV AH, 9
        INT 21h

        MOV AH, 7
        INT 21h

            ; set cursor
            MOV AH, 2
            MOV BH, 0
            MOV DH, 10
            MOV DL, 24
            INT 10h

        LEA DX, EMP  ; empty line to overwrite
        MOV AH, 9
        INT 21h

        JMP TRYAGAIN ; promt again

    EXIT:
    MOV AH, 4CH
    INT 21h
    MAIN ENDP
END MAIN
