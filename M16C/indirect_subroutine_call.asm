;; For indirect jump based on relative addresses, this program
;; uses an extended access instruction(LDE) to set the
;; relative jump address for the indirect jump. In this
;; program, since relative addresses are within the range than
;; can be represented with 8 bits, ".B (byte size)" is used to
;; set the offset data.  For indirect jump based on absolute
;; addresses, this program adds the content of the adrerss
;; refister, with its sign ignored, to the start addtess of
;; the memory area where 20-bit absolute addresses are stored
;; with its sign ignored, to the start address of the memory
;; area where 20-bit absolute addresses are stored and jumps
;; to the memory location(20-bit absolute address) indicated
;; by the result. The memory area in which to store 20-bit
;; absolute addresses is allocated in unit of 3 bytes.


;*******************************************************************************
;                                                                              * 
;	Program Collection: #4                                                 *
;	CPU		  : M16C                                               *
;                                                                              * 
;*******************************************************************************
VramTOP			.EQU		000400H	;Declares start address of RAM
VromTOP			.EQU		0F0000H	;Declares start address of ROM
Vsb			.EQU		0400H	;Sets SB
;						;
	.SECTION	RAM,DATA
	.ORG		VramTOP			;RAM area
MODE:	.BLKB		1			;Processing status
MD_0:	.EQU		0			;Status number 0
MD_1:	.EQU		1			;Status number 1
;						;
;===============================================================================
;; 	Title:	 	 Indirect subroutine call
;; 	Outline:	 Branches processing using an indirect subroutine call(relative)
;; 	Input:	 ------------------------------>	Output:
;; 	R0 ()						R0  (Unused)
;; 	R1 ()						R1  (Unused)
;; 	R2 ()						R2  (Unused)
;; 	R3 ()						R3  (Unused)
;; 	A0 ()						A0  (Indeterminate)
;; 	A1 ()						A1  (Indeterminate)
;; 	Stack amount used: 3 bytes
;; 	Notes	    	 : 
;===============================================================================
	.SECTION	PROGRAM, CODE
	.ORG		VromTOP			;ROM area
	.SB		Vsb			;Declares SB register value
	.SBSYM		MODE			;
SUBIND_W:
	MOV.B		MODE,A0			;
	LDE.B		JUMPaddress[A0],A1	;Sets jump address
JUMP_offset:
	JSRI.W		A1			;Jumps to each processing
	RTS
MODE_0:
	MOV.B		#MD_1,MODE 		;
	RTS
MODE_1:
	MOV.B		#MD_0,MODE 		;
	RTS
JUMPaddress:
	.BYTE	MODE_0-JUMP_offset ;
	.BYTE	MODE_1-JUMP_offset ;


;===============================================================================
;; 	Title:	 	 Indirect subroutine call
;; 	Outline:	 Branches processing using an indirect subroutine call(absolute)
;; 	Input:	 ------------------------------>	Output:
;; 	R0 ()						R0  (Unused)
;; 	R1 ()						R1  (Unused)
;; 	R2 ()						R2  (Unused)
;; 	R3 ()						R3  (Unused)
;; 	A0 ()						A0  (Indeterminate)
;; 	A1 ()						A1  ()
;; 	Stack amount used: 3 bytes
;; 	Notes	    	 : 
;===============================================================================

SUBIND_A:
	MOV.B		MODE,A0			;
	SHL.W		#1,A0			;
	ADD.B		MODE,A0			;Sets jump pointer
	JSRI.A		JSRaddress[A0]		;Jumps to each processing
	RTS
JSR_0:
	MOV.B		#MD_1,MODE ;
	RTS
JSR_1:
	MOV.B		#MD_0,MODE ;
	RTS
JSRaddress:
	.ADDR	JSR_0		;
	.ADDR	JSR_1		;
	.END
