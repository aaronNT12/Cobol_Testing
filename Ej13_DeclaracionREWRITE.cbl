GCobol >> SOURCE FORMAT IS FIXED
	*>******************************************************************************
	*> Purpose: RELATIVE file organization REWRITE example
	*> Tectonics: cobc -g -debug -W -x relatives.cob 
	*>******************************************************************************
	
	IDENTIFICATION DIVISION.
	
	PROGRAM-ID. relatives.
	
	ENVIRONMENT DIVISION.
	CONFIGURATION SECTION.
	REPOSITORY.
		FUNCTION ALL INTRINSIC.
		
	INPUT-OUTPUT SECTION.
	FILE-CONTROL.
		SELECT OPTIONAL relatives
			ASSIGN TO "relatives.dat"
			FILE STATUS IS filestatus
			ORGANIZATION IS RELATIVE
			ACCESS MODE IS DYNAMIC
			RELATIVE KEY IS nicknum.
			
		DATA DIVISION.
		FILE SECTION.
		FD relatives.
			01 person.
				05 firstname	PIC x(48).
				05 lastname		PIC x(64).
				05 relationship	PIC x(32).
				
		WORKING-STORAGE SECTION.
		77 filestatus PIC 9(2).
			88 satisfied VALUE 1 WHEN SET TO FALSE IS 0.
			
		77 satisfaction PIC 9.
			88 satisfied VALUE 1 WHEN SET TO FALSE IS 0.
			
		77 nicknum PIC 9(2).
		
		77 title-line PIC x(34).
			88 writing-names VALUE "Adding, Overwriting. 00 TO finish".
			88 reading-names VALUE "Which record?		00 TO quit".
		77 problem	PIC x(80).
		
		SCREEN SECTION.
		01 DETAIL-SCREEN.
			05			 LINE 1 COLUMN 1  FROM title-line ERASE EOS.
			05			 LINE 2 COLUMN 1  VALUE "Record: ".
			05 PIC 9(2)  LINE 2 COLUMN 16 USING nicknum.
			05			 LINE 3 COLUMN 1  VALUE "First name: ".
			05 PIC x(48) LINE 3 COLUMN 16 USING firstname.
			05 			 LINE 4 COLUMN 1  VALUE "Last Name: ".
			05 PIC x(64) LINE 4 COLUMN 16 USING lastname.
			05 			 LINE 5 COLUMN 1  VALUE "Relation: ".
			05 PIC x(32) LINE 5 COLUMN 16 USING relationship.
			05 PIC x(80) LINE 6 COLUMN 1  FROM problem.
			
		01 show-screen. 
			05				LINE 1 COLUMN 1   FROM title-line ERASE EOS.
			05				LINE 2 COLUMN 1   VALUE "Record: ".
			05 PIC 9(2)		LINE 2 COLUMN 16  USING nicknum.
			05 				LINE 3 COLUMN 1   VALUE "First name: ".
			05 PIC x(48) 	LINE 3 COLUMN 16  FROM firstname.
			05				LINE 4 COLUMN 1   VALUE "Last name: ".
			05 PIC x(64) 	LINE 4 COLUMN 16  FROM lastname.
			05				LINE 5 COLUMN 1   VALUE "Relation: ".
			05 PIC x(32)	LINE 5 COLUMN 16  FROM relationship.
			05 PIC x(80)	LINE 6 COLUMN 1	  FROM problem.
		*> -****************************************************************************************
		
		PROCEDURE DIVISION.
		beginning.
		
		*> Open the file and find the highest record number 
		*> which is a sequential read operation after START
			open INPUT relatives
			
			MOVE 99 TO nicknum
			START relatives key IS LESS THAN OR EQUAL TO nicknum
				INVALID KEY
					MOVE CONCATENATE ('NO START' SPACE filestatus)
						TO problem
					MOVE 00 TO nicknum
					NOT INVALID KEY
						READ relatives NEXT END-READ
					END-START
		*> Close and open for i-o 
			CLOSE relatives
			OPEN I-O relatives
			
		*> Prompt for numbers and names to add until 00
			SET writting-names TO TRUE
			SET satisfied TO FALSE
			PERFORM fill-file THROUGH fill-file-end 
				UNTIL satisfied
				
			CLOSE relatives
			
		*> Prompt for numbers to view names of until 00
			OPEN INPUT relatives
			
			SET reading-names TO TRUE
			SET satisfied TO FALSE
			PERFORM record-request THROUGH record-request-end
				UNTIL satisfied
				
			PERFORM close-shop
		.
		ending.
			GOBACK.
			
		*> get some user data to add
			fill-file.
			DISPLAY DETAIL-SCREEN.
			ACCEPT DETAIL-SCREEN.
			MOVE SPACES TO problem
			IF nicknum equal 0
				SET satisfied TO TRUE
				GO TO fill-file-end
			end-if.
		.
		WRITE-FILE.
		WRITE person
			INVALID KEY
				MOVE CONCATENATE("overwriting: " nicknum) TO problem
				REWRITE person
					INVALID KEY
						MOVE CONCATENATE (
							EXCEPTION-LOCATION() SPACE nicknum
							SPACE filestatus)
						TO problem
					END-REWRITE
				END-WRITE.
				DISPLAY DETAIL-SCREEN
			.
			fill-file-end.
			.
			
			*>get keys to display
			record-request.
				DISPLAY show-screen
				ACCEPT show-screen
				MOVE SPACES TO problem
				IF nicknum EQUALS 0
					SET satisfied TO TRUE
					GO TO record-request-end 
				end-if
			.
			*> The magic of relative record number reads
			READ-RELATION.
				READ relatives
					INVALID KEY
						MOVE EXCEPTION-LOCATION() TO problem
					NOT INVALID KEY
						MOVE SPACES TO problem
					END-READ
					DISPLAY show-screen
				.
				record-request-end.
				.
			*> get out <*
			close-shop.
				CLOSE relatives.
				GOBACK.
			.
			END PROGRAM relatives.
				
		
			