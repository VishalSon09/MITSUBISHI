;*******************************************************************************
;                                                                              * 
;	Program Collection: #2                                                 *
;	CPU		  : M16C                                               *
;                                                                              * 
;*******************************************************************************
VramTOP			.EQU		000400H	;Declares start address of RAM
VromTOP			.EQU		0F0000H	;Declares start address of ROM
;						;
	.SECTION	RAM,DATA
	.ORG		VramTOP			;RAM area
	LENGTH		.EQU		10 	;Length of area
BLOCK1:			.BLKB		LENGTH	;Source area of transfer
BLOCK2:			.BLKB		LENGTH	;Destination area of transfer
;						;
;===============================================================================
;; 	Title:	 	 Transferring blocks
;; 	Outline:	 Example for using block transfer instruction
;; 	Input:	 ------------------------------>	Output:
;; 	R0L ()						R0L (Unused)
;; 	R0H ()						R0H (Unused)
;; 	R1L ()						R1L (Unused)
;; 	R1H ()						R1H (Indeterminate)
;; 	R2 ()						R2  (Unused)
;; 	R3 ()						R3  (Indeterminate)
;; 	A0 ()						A0  (Indeterminate)
;; 	A1 ()						A1  (Indeterminate)
;; 	Stack amount used: None
;; 	Notes	    	 : 
;===============================================================================
	.SECTION	PROGRAM, CODE
	.ORG		VromTOP			;ROM area
	MOV.W	#LENGTH,R3			;Sets number of transfer performed
	MOV.W	#BLOCK1 & 0FFFFH,A0		;Sets low-order half of the source address
	MOV.W	#BLOCK1>>16,R1H			;Sets high-order half of the source address
	MOV.W	#BLOCK2,A1			;Sets destination address
	SMOVF.B					;Executes transfer of blocks
	.END

;; This program transfers memoory contents from one location
;; to another by using a block transfer instruction(SMOVF).
;; The program sets the number of transfers performed in R3,
;; the high-order 4-bits of the source's start address in R1H,
;; the low-order 16 bits of the source's start address in A0,
;; and the destinations's start address in A1 before executing
;; the SMOVF instruction
