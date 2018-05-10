;[]------------------------------------------------------------[]
;|      C0.ASM -- Start Up Code for DOS                         |
;[]------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 5.0
; 
;       Copyright (c) 1987, 1992 by Borland International
;       All Rights Reserved.
; 

                locals

                __C0__ = 1
INCLUDE         RULES.ASI

;       Segment and Group declarations

_TEXT           SEGMENT BYTE PUBLIC 'CODE'
                ENDS
_FARDATA        SEGMENT PARA PUBLIC 'FAR_DATA'
                ENDS
_FARBSS         SEGMENT PARA PUBLIC 'FAR_BSS'
                ENDS
IFNDEF __TINY__
_OVERLAY_       SEGMENT PARA PUBLIC 'OVRINFO'
        ENDS
_1STUB_     SEGMENT PARA PUBLIC 'STUBSEG'
        ENDS
ENDIF
_DATA           SEGMENT PARA PUBLIC 'DATA'
                ENDS
_INIT_          SEGMENT WORD PUBLIC 'INITDATA'
InitStart       label byte
                ENDS
_INITEND_       SEGMENT BYTE PUBLIC 'INITDATA'
InitEnd         label byte
                ENDS
_EXIT_          SEGMENT WORD PUBLIC 'EXITDATA'
ExitStart       label byte
                ENDS
_EXITEND_       SEGMENT BYTE PUBLIC 'EXITDATA'
ExitEnd         label byte
                ENDS
_CVTSEG         SEGMENT WORD PUBLIC 'DATA'
                ENDS
_SCNSEG         SEGMENT WORD PUBLIC 'DATA'
                ENDS
IFNDEF __HUGE__
  _BSS          SEGMENT WORD PUBLIC 'BSS'
                ENDS
  _BSSEND       SEGMENT BYTE PUBLIC 'BSSEND'
                ENDS
ENDIF
IFNDEF __TINY__
  _STACK        SEGMENT STACK 'STACK'
                ENDS
ENDIF

        ASSUME  CS:_TEXT, DS:DGROUP

;       External References

extrn       _main:DIST
;extrn       _exit:DIST
;extrn       __exit:DIST
;extrn       __nfile:word
;extrn       __setupio:near          ;required!
;extrn       __stklen:word
IF LDATA  EQ  false
extrn       __heaplen:word
ENDIF

        SUBTTL  Start Up Code
        PAGE
;/*                                                     */
;/*-----------------------------------------------------*/
;/*                                                     */
;/*     Start Up Code                                   */
;/*     -------------                                   */
;/*                                                     */
;/*-----------------------------------------------------*/
;/*                                                     */
PSPHigh         equ     00002h
PSPEnv          equ     0002ch
PSPCmd          equ     00080h

                public  __AHINCR
                public  __AHSHIFT
__AHINCR        equ     1000h
__AHSHIFT       equ     12

IFDEF   __NOFLOAT__
MINSTACK        equ     128     ; minimal stack size in words
ELSE
MINSTACK        equ     256     ; minimal stack size in words
ENDIF
;
;       At the start, DS and ES both point to the segment prefix.
;       SS points to the stack segment except in TINY model where
;       SS is equal to CS
;
_TEXT           SEGMENT
IFDEF           __TINY__
                ORG     100h
ENDIF
STARTX          PROC    NEAR

                call    _main
		mov     bp,sp
                mov     ah,4Ch
                mov     al,[bp+cPtrSize]
                int     21h
STARTX          ENDP

        SUBTTL  Vector save/restore & default Zero divide routines
        PAGE


; __MMODEL is used to determine the memory model or the default
; pointer types at run time.

;                public __MMODEL
;__MMODEL        dw      MMODEL

_TEXT           ENDS

                SUBTTL  Start Up Data Area
                PAGE
;[]------------------------------------------------------------[]
;|      Start Up Data Area                                      |
;|                                                              |
;|      WARNING         Do not move any variables in the data   |
;|                      segment unless you're absolutely sure   |
;|                      that it does not matter.                |
;[]------------------------------------------------------------[]

_DATA           SEGMENT

;       Magic symbol used by the debug info to locate the data segment
                public DATASEG@
DATASEG@        label   byte

IF      LDATA  EQ  false
ENDIF

_DATA           ENDS


_CVTSEG         SEGMENT
                ENDS

_SCNSEG         SEGMENT
                ENDS

IFNDEF __HUGE__
_BSS            SEGMENT
bdata@          label   byte
                ENDS

_BSSEND         SEGMENT
edata@          label   byte
                ENDS
ENDIF

                END     STARTX
