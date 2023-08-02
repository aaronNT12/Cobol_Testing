GCobol >>SOURCE FORMAT IS FIXED
	*>*********************************************************************************
	
	*> Purpose: Demostration of the SEARCH verb
	*> Tectonics: cob -x searchlinear.cob
	*> ********************************************************************************
	IDENTIFICATION DIVISION.
	PROGRAM-ID. searchlinear.
	
	DATA DIVISION.
	
	WORKING-STORAGE SECTION.
	01 taxinfo.
		05 tax-table occurs 4 times idexed by tt-index.
			10 province		pic x(2).
			10 taxrate		pic 999v9999.
			10 federal		pic 999v9999.
			01 prov 		pic x(2).
			01 percent		pic 999v9999.
			01 percentage	pic 999v9999.
	*>**********************************************************************************
	*> Sample for linear SEARCH, requires INDEXED BY table 
	*>populate the provincial tax table;
	*> *** (not really, only a couple of sample provinces) ***
	*> populate Ontario and PEI using different field loaders
	move 'AB' to provice(1)
	move 'ON' to provide(2)
	move 0.08 to taxrate(2)
	move 0.05 to federal(2)
	move 'PE00014000000000' to tax-table(3)
	move  'YT' to province(4)
	
	
	*>Find Ontario tax rate
	move "ON" to prov
	perform search-for-taxrate
	
	*>Setup for Prince Edward Island
	move 'PE' to prov
	perform search-for-taxrate
	
	*>Setup for failure
	move 'ZZ' to prov
	perform search-for-taxrate
	
	goback.
	
*>***********************************************************************************************

search-for-taxrate.
	set tt-index to 1
	search tax-table
		at end display "no province: " prov end-display 
		when privince (tt-index) = prov 
			perform display-taxrate
		end-search
		
	.
	
	display-taxrate.
		compute percent = taxrate (tt-index) * 100
		move percent to percentage
		display
			"found: "prov " at "taxrate(tt-index)
			","percentage "%, federal rate of " federal (tt-index)
		end-display
	.
	
	
	end program searchlinear.
		