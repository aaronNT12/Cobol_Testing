UNSTRING INPUT-ADDRESS
	DELIMITED BY "," OR "/"
	INTO
		Street-Address DELIMITER D1 COUNT C1
		Apt-Number DELIMITER D2 COUNT C2
		City DELIMITER D3 COUNT C3
		State DELIMITER D4 COUNT C4
		Zip-Code DELIMITER D5 COUNT C5
	WITH POINTER ptr-1
	ON OVERFLOW
		SET more-fields TO TRUE
	END-UNSTRING