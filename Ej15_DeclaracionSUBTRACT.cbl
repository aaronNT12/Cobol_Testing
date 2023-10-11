SUBTRACT item-a item-b item-c FROM account -z ROUNDED MODE IS NEAREST-EVEN
	ON SIZE ERROR
		DISPLAY "CALL THE BOSS, Acocount `Z` is OUT OF MONEY" END-DISPLAY
		PERFORM promisary-processing
	NOT ON SIZE ERROR
		PERFORM normal-procesing
	END-SUBTRACT