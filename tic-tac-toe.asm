DATA SEGMENT USE16 
    ;Board Lines
    L1 DB '   |   |   ', '$'
    L2 DB '-----------', '$'
    NEWLINE DB 13, 10, '$'
    
    ;Cell Numbers
    C1 DB '1', '$'
    C2 DB '2', '$'
    C3 DB '3', '$'
    C4 DB '4', '$'
    C5 DB '5', '$'
    C6 DB '6', '$'
    C7 DB '7', '$'
    C8 DB '8', '$'
    C9 DB '9', '$'
DATA ENDS

CODE SEGMENT USE16
    ASSUME CS:CODE, DS:DATA

BEG:
    MOV AX, DATA
    MOV DS, AX
    
    ;First Line
    MOV DX, OFFSET C1
    CALL PRINT_CHAR
    MOV DX, OFFSET L1+1
    CALL PRINT_STR
    
    MOV DX, OFFSET C2
    CALL PRINT_CHAR
    MOV DX, OFFSET L1+5
    CALL PRINT_STR 
    
    MOV DX, OFFSET C3
    CALL PRINT_CHAR
    CALL PRINT_NEWLINE 
    
    ;First Seperator
    MOV DX, OFFSET L2
    CALL PRINT_STR
    CALL PRINT_NEWLINE
    
    ;Second Line
    MOV DX, OFFSET C4
    CALL PRINT_CHAR
    MOV DX, OFFSET L1+1
    CALL PRINT_STR
    
    MOV DX, OFFSET C5
    CALL PRINT_CHAR
    MOV DX, OFFSET L1+5
    CALL PRINT_STR 
    
    MOV DX, OFFSET C6
    CALL PRINT_CHAR
    CALL PRINT_NEWLINE
    
    ;Second Seperator
    MOV DX, OFFSET L2
    CALL PRINT_STR
    CALL PRINT_NEWLINE
    
    ;Third Line
        MOV DX, OFFSET C7
    CALL PRINT_CHAR
    MOV DX, OFFSET L1+1
    CALL PRINT_STR
    
    MOV DX, OFFSET C8
    CALL PRINT_CHAR
    MOV DX, OFFSET L1+5
    CALL PRINT_STR 
    
    MOV DX, OFFSET C9
    CALL PRINT_CHAR
    CALL PRINT_NEWLINE
    
    ;Halt Program
    MOV AH, 4CH
    INT 21H
    
;Print Methods    
PRINT_CHAR PROC
    MOV AH, 9
    INT 21H
    RET
PRINT_CHAR ENDP

PRINT_STR PROC
    MOV AH, 9
    INT 21H
    RET
PRINT_STR ENDP

PRINT_NEWLINE PROC
    MOV AH, 9
    MOV DX, OFFSET NEWLINE
    INT 21H
    RET
PRINT_NEWLINE ENDP

CODE ENDS

END BEG