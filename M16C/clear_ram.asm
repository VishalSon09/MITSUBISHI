;*******************************************************************************
;                                                                              * 
;	Program Collection: #1                                                 *
;	CPU		  : M16C                                               *
;                                                                              * 
;*******************************************************************************
VramTOP			.EQU		000400H	;Declares start address of RAM
VramEND			.EQU		002C00H	;Declares start address of RAM
VromTOP			.EQU		0F0000H	;Declares start address of ROM
;						;
;===============================================================================
;; 	Title:	 	 Clearing RAM
;; 	Outline:	 Clears RAM using block constant setup instruction
;; 	Input:	 ------------------------------>	Output:
;; 	R0 ()						R0 (Transfer data)
;; 	R1 ()						R1 (Unused)
;; 	R2 ()						R2 (Unused)
;; 	R3 ()						R3 (Indeterminate)
;; 	A0 ()						A0 (Unused)
;; 	A1 ()						A1 (Indeterminate)
;; 	Stack amount used: None
;; 	Notes	    	 : 
;===============================================================================
	.SECTION	PROGRAM, CODE
	.ORG		VromTOP			;ROM area
	MOV.W	#0,R0				;Sets transfer data
	MOV.W	#((VramEND+1)-VramTOP)/2,R3	;Sets number of transfers performed
	MOV.W	#VramTOP,A1			;Sets destination address
	SSTR.W					;Executes clearing of RAM
	.END
