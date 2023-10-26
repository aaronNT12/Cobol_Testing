*>Multiply Formats***************

*>Example 1º*********************
MULTIPLY 5 BY a 

*>Example 2º*********************

MULTIPLY a BY b 
	ON SIZE ERROR
		PERFORM error-handling
	NOT ON SIZE ERROR
		PERFORM who-does-that
END MULTIPLY

*>Example 3º*********************

MULTIPLY a BY b GIVING x ROUNDED MODE IS PROHIBITED
					   y ROUNDED MODE IS NEAREST-EVEN
					   z ROUNDED

