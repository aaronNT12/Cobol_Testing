GCobol >>SOURCE FORMAT IS FIXED
	*>***********************************************************
	*> Purpose: Demostration of the SEARCH verb
	*> Tectonics: cobc -x searchlienar.cob 
	*>***********************************************************
	IDENTIFICATION DIVISION.
	PROGRAM-ID. searchlienar.
	
	DATA DIVISION.
	
	WORKING-STORAGE SECTION.
	01 taxinfo.
		05 tax-table OCCURS 4 TIMES INDEXED BY tt-INDEX.
			10 province		pic x(2).
			10 taxrate 		pic 999v9999.
			10 federal 		pic 999v9999.
	01 prov 				pic x(2).
	01 percent				pic 999v9999.
	01 percentage			pic zz9.99.
	
	*>************************************************************
	PROCEDURE DIVISION.
	begin.
	
	*>************************************************************
	*> Sample for lienear SEARCH, requires INDEXED BY table 
	*> populate the provincial tax table;
	*> *** (not really, only a cople of sample provinces) ***
	*> populate Ontario and PEI using different field  loaders
	MOVE 'AB' TO province(1)
	MOVE 'ON' TO province(2)
	MOVE 0.08 TO taxrate (2)
	MOVE 0.05 TO federal (2)
	MOVE 'PE00014000000000' TO tax-table(3)
	MOVE 'YT' TO province(4)
	
	*>Find Ontario tax rate
	MOVE "ON" TO prov
	PERFORM search-for-taxrate
	
	*> Setup for Prince Edward Island
	MOVE 'PE' TO prov
	PERFORM search-for-taxrate
	
	*>Setup for failure
	MOVE 'ZZ' TO prov
	PERFORM search-for-taxrate
	
	GOBACK.
	*>****************************************************************************************
	
	search-for-taxrate.
		SET tt-index TO
		SEARCH tax-table
			AT END DISPLAY "no province: " prov END-DISPLAY
			WHEN province(tt-index) = prov
				PERFORM display-taxrate
			END-SEARCH
		.
		END PROGRAM searchlienar.
	