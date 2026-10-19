;*******************************************************************************
;                                                                              * 
;	Program Collection: #8                                                 *
;	CPU		  : M16C                                               *
;                                                                              * 
;*******************************************************************************
VromTOP			.EQU		0F0000H	;Declares start address of ROM
;						;
;===============================================================================
;; 	Title:	 	 Comparing 32-bits
;; 	Outline:	 Compares 32-bits data between **registers**
;; 	Input:	 ------------------------------>	Output:
;; 	R0 (Lower half of comparing data)		R0 (Does not change)
;; 	R1 (Lower half of compared data)		R1 (Does not change)
;; 	R2 (Upper half of comparing data)		R2 (Does not change)
;; 	R3 (Upper half of compared data)		R3 (Does not change)
;; 	A0 ()						A0 (Unused)
;; 	A1 ()						A1 (Unused)
;; 	Stack amount used: None
;; 	Notes	    	 : Result is returned by Z and C flags
;===============================================================================
	.SECTION	PROGRAM, CODE
	.ORG		VromTOP		;ROM area
Comp32:					;
	CMP.W		R2,R3		;Compares high-order bits
	JNE		COMP32exit	;Result is output after comparing
					;; only high order bits
	CMP.W		R0,R1		;Compares low-order bits
COMP32exit:
	RTS				;
;					;
;===============================================================================
;; 	Title:	 	 Comparing 32-bits
;; 	Outline:	 Compares 32-bits data between **memory locations**
;; 	Input:	 ------------------------------>	Output:
;; 	R0 ()						R0 (Unused)
;; 	R1 ()						R1 (Unused)
;; 	R2 ()						R2 (Unused)
;; 	R3 ()						R3 (Unused)
;; 	A0 (Address of comparing data)			A0 (Does not change)
;; 	A1 (Address of compared data)			A1 (Does not change)
;; 	Stack amount used: None
;; 	Notes	    	 : Result is returned by Z and C flags
;===============================================================================
COMPmemory32:
	CMP.W		2[A0],2[A1]		;Compares high-order bits
	JNE		COMPmemory32exit	;-->Result is output after comparing
						; only high order bits		 
	CMP.W		[A0],[A1]		;Compares low-order bits
COMPmemory32exit:
	RTS					;
						;
	.END					;
