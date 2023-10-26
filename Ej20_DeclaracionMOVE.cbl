01 a PIC 9.
01 b PIC 99.
01 c PIC 999.

01 s PIC X(4).

01 RECORD-GROUP.
	05 field-a PIC 9.
	05 field-b PIC 99.
	05 field-c PIC 999.
01 DISPLAY-RECORD.
	05 field-a PIC Z.
	05 field-b PIC ZZ.
	05 field-c PIC $Z9.
	
*> numeric fields are moved left to right 
*> a set to 3, b set to 23, c set to 123

MOVE 123 TO a b c 

*> moves can also be by matching names with  groups
MOVE a TO field-a OF RECORD-GROUP
MOVE a TO field-b OF RECORD-GROUP
MOVE a TO field-c OF RECORD-GROUP
MOVE CORRESPONDING RECORD-GROUP TO DISPLAY-RECORD
*> character data is moved right to left 
*> s will be set to xyzz
MOVE "xyzzy" TO s 