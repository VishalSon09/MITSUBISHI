;*******************************************************************************
;                                                                              * 
;	Program Collection: #3                                                 *
;	CPU		  : M16C                                               *
;                                                                              * 
;*******************************************************************************
VramTOP			.EQU		000400H	;Declares start address of RAM
VromTOP			.EQU		0F0000H	;Declares start address of ROM
;						;
	.SECTION	RAM,DATA
	.ORG		VramTOP			;RAM area
	LENGTH		.EQU		10 	;Length of area
BLOCK1:			.BLKB		LENGTH	;Area 1
BLOCK2:			.BLKB		LENGTH	;Area 2
;						;
;===============================================================================
;; 	Title:	 	 Transferring blocks
;; 	Outline:	 Example for using block transfer instruction
;; 	Input:	 ------------------------------>	Output:
;; 	R0L ()						R0L (Indeterminate)
;; 	R0H ()						R0H (Unused)
;; 	R1L ()						R1L (Unused)
;; 	R1H ()						R1H (Unused)
;; 	R2 ()						R2  (Unused)
;; 	R3 ()						R3  (Unused)
;; 	A0 ()						A0  (Indeterminate)
;; 	A1 ()						A1  (Unused)
;; 	Stack amount used: None
;; 	Notes	    	 : 
;===============================================================================
	.SECTION	PROGRAM, CODE
	.ORG		VromTOP			;ROM area
	MOV.B		#LENGTH,A0		;Sets number of transfers performed
LOOP:
	MOV.B		BLOCK1-1[A0],R0L ;
	XCHG.B		R0L,BLOCK2-1[A0] ;Changes data
	MOV.B		R0L,BLOCK1-1[A0] ;
	ADJNZ.W		#-1,A0,LOOP	 ;Looped for the number of transfers performed
	.END
	
;; This program changes memory contents consisting of the same
;; number of bytes with each other memory location. An add and
;; conditional branch instruction (ADJNZ) is used to count the
;; number of transfers performed.  In this program, memory
;; contents basically are chaged in bytes. However, if the
;; memory contents to be changed consist of even bytes, they
;; can be changed in words for increased speed of processing.
