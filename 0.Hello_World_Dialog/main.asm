#include main.h
#include windows.h
DATA SECTION
;-------------|---------|----------
hInstance      DD        0

CONSTANT SECTION
;-------------|---------|----------
;;;;Window message table
MESSAGES       DD        WM_INITDIALOG, INITDIALOG_PROC
                DD         WM_COMMAND, COMMAND_PROC

CODE SECTION
;;;;---------------|---------------|----------
START:
    INVOKE          GetModuleHandleW, NULL
    MOV             [hInstance],    EAX
    INVOKE          DialogBoxParamW, [hInstance], \
                                    IDD_DIALOG, \
                                    NULL, \
                                    ADDR DlgProc, \
                                    NULL
    INVOKE          GetLastError
    INVOKE          ExitProcess,    ERROR_SUCCESS
    RET

DlgProc FRAME hWndDlg,uMsg,wParam,lParam
    USES            EBX, EDI, ESI
    MOV             EAX,            [uMsg]
    MOV             ECX,            SIZEOF MESSAGES / 8
    MOV             EDX,            ADDR MESSAGES
    :
    DEC             ECX
    JS              >.default
    CMP             [EDX + ECX * 8], EAX
    JNZ             <
    CALL            [EDX + ECX * 8 + 4]
    JNC             >.return
    .default
    MOV             EAX,            FALSE
    .return
    RET
ENDF

INITDIALOG_PROC:
    USEDATA         DlgProc
    MOV             EAX,            TRUE
    RET
    ENDU

COMMAND_PROC:
    USEDATA         DlgProc
    CMP             W[wParam],      IDOK
    JNZ             >
    INVOKE          EndDialog,      [hWndDlg], NULL
    MOV             EAX,            TRUE
    :
    MOV             EAX,            FALSE
    .return
    RET
    ENDU
