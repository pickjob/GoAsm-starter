#include windows.h

DATA SECTION
;-------------|---------|----------
hOut           DD        0
greetings_len  DD        0

CONSTANT SECTION
;-------------|---------|----------
greetings_str  DUS       '你好，世界!', 0

CODE SECTION
;;;;---------------|---------------|----------
START:
    PUSH            STD_OUTPUT_HANDLE
    CALL            GetStdHandle
    MOV             [hOut],         EAX

    ; cdecl 调用方平衡栈
    PUSH            ADDR greetings_str
    CALL            wcslen
    ADD             ESP,             4
    MOV             [greetings_len], EAX

    ; PUSH            NULL
    ; PUSH            NULL
    ; PUSH            [greetings_len]
    ; PUSH            ADDR greetings_str
    ; PUSH            [hOut]
    ; CALL            WriteConsoleW
    INVOKE          WriteConsoleW,  [hOut], \
                                    ADDR greetings_str, \
                                    [greetings_len], \
                                    NULL, \
                                    NULL

    XOR             EAX,            EAX
RET
