DISPLAY "An error ocurred with " tracked-resource UPON SYSERR

DISPLAY A, B, C UPON CONSOLE

DISPLAY group-data UPON user-device
	ON EXCEPTION
		WRITE device-exception-notice
	NOT ON EXCEPTION
		WRITE device-usage-log 
END-DISPLAY
