*****************************************************************************************************
*>PROGRAMA DE GESTIÓN BANCARIA					 
*> Aaron Naveira / 24.01.23

*>Este programa lee un archivo de transacciones, donde cada registro contiene un número de cuenta,
 *>un tipo de transacción (depósito o retiro), y una cantidad.
 *>Luego procesa cada transacción y muestra un mensaje apropiado.


*****************************************************************************************************

IDENTIFICATION DIVISION.
PROGRAM-ID. BANK-TRANSACTION.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 ACCOUNT-NO PIC 9(10).
01 TRANSACTION-TYPE PIC X.
01 AMOUNT PIC 9(7)V99.

FILE SECTION.
FD TRANSACTION-FILE.
01 TRANSACTION-RECORD.
	05 T-ACCOUNT-NO PIC 9(10).
	05 T-TYPE PIC X.
	05 T-AMOUNT PIC 9(7)V99.

PROCEDURE DIVISION.
BEGIN.
	OPEN INPUT TRANSACTION-FILE.
	READ TRANSACTION-FILE INTO TRANSACTION-RECORD.
	PERFORM UNTIL END-OF-FILE
		MOVE T-ACCOUNT-NO TO ACCOUNT-NO
		MOVE T-TYPE TO TRANSACTION-TYPE
		MOVE T-AMOUNT TO T-AMOUNT
		PERFORM TRANSACTION-PROCESS
		READ TRANSACTION-FILE INTO TRANSACTION-RECORD
	END-PERFORM.
	CLOSE TRANSACTION-FILE.
	STOP RUN.
	
TRANSACTION-PROCESS.
	IF TRANSACTION-TYPE = 'D'
		DISPLAY 'Deposited ' AMOUNT ' into account ' ACCOUNT-NO
	ELSE IF TRANSACTION-TYPE = 'W'
		DISPLAY 'Withdrew ' AMOUNT ' from account ' ACCOUNT-NO
	ELSE
		DISPLAY 'Invalid transaction type for account ' ACCOUNT-NO.