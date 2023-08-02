01 fillertest.
	03 fillertest-1 PIC 9(10) value 2222222222.
	03 filler PIC X value '|'.
	03 fillertest-2 PIC X(10) value all 'A'.
	03 filler PIC 9(03) value 111.
	03 filler PIC X value '.'.
INITIALIZE fillertest

INITIALIZE fillertest REPLACING NUMERIC BY 9

INITIALIZE fillertest REPLACING ALPHANUMERIC BY 'X'

INITIALIZE fillertest REPLACING ALPHANUMERIC BY ALL 'X'

INITIALIZE fillertest WITH FILLER

INITIALIZE fillertext ALL TO VALUE