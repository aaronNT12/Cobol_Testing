01 some-string PIC X(32).

...

MOVE " a string literal" TO some-string

DISPLAY ":" some-string":"
DISPLAY ":" FUNCTION TRIM (some-string) ":"
DISPLAY ":" FUNCTION TRIM (some-string LEADING) ":"
DISPLAY ":" FUNCTION TRIM (some-string TRAILING) ":"
