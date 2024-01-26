*****************************************************
*> Ejemplo de prueba técnica de programación en COBOL
*> Aarón Naveira Taibo 26.01.2024

*> Este programa realiza un ordenamiento de registros 
*> en un archivo utilizando el algoritmo de ordenamiento por burbuja.
*****************************************************

IDENTIFICATION DIVISION.
PROGRAM-ID. BUBBLE-SORT.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
	SELECT UNSORTED-FILE ASSIGN TO 'UNSORTED.TXT'.
	SELECT SORTED-FILE ASSIGN TO 'SORTED.TXT'.
DATA DIVISION.
FILE SECTION.
FD UNSORTED-FILE.
01 UNSORTED-RECORD.
	05 ID-NUMBER PIC 9(5).
FD SORTED-FILE.
01 SORTED-RECORD.
	05 ID-NUMBER PIC 9(5)
WORKING-STORAGE SECTION.
01 WS-ID-NUMBERS.
	05 ID-NUMBER OCCURS 100 TIMES PIC 9(5).
01 WS-COMPUTER PIC 9(3) VALUE ZERO.
01 WS-SWAP PIC X(1) VALUE 'N'
PROCEDURE DIVISION.
BEGIN.
	OPEN INPUT UNSORTED-FILE.
	OPEN INPUT SORTED-FILE.
	PERFORM UNTIL WS-COMPUTER = 100
		READ UNSORTED-FILE.
			AT END MOVE ID-NUMBER OF UNSORTED-RECORD TO ID-NUMBER (WS-COMPUTER)
		END-READ
		ADD 1 TO WS-COMPUTER
		END-PERFORM.
		CLOSE UNSORTED-FILE.
		PERFORM UNTIL WS-SWAP = 'N'
			MOVE 'N' TO WS-SWAP
			PERFORM VARYING WS-COMPUTER FROM 1 BY 1 UNTIL WS-COMPUTER = 99
				IF ID-NUMBER (WS-COMPUTER) > ID-NUMBER (WS-COMPUTER + 1)
99
					MOVE ID-NUMBER (WS-COMPUTER) TO ID-NUMBER
					MOVE ID-NUMBER (WS-COMPUTER + 1) TO ID-NUMBER (WS-COMPUTER)
					MOVE ID-NUMBER TO ID-NUMBER (WS-COMPUTER + 1)
					MOVE 'Y' TO WS-SWAP
				END-IF
			END-PERFORM
		END-PERFORM.
		PERFORM VARYING WS-COUNTER FROM 1 BY 1 UNTIL WS-COMPUTER > 100
			MOVE ID-NUMBER (WS-COMPUTER) TO ID-NUMBER OF SORTED-RECORD
			WRITE SORTED-RECORD
		END-PERFORM.
		CLOSE SORTED-FILE.
		STOP RUN.
		