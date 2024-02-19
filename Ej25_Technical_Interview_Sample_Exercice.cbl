IDENTIFICATION DIVISION.
PROGRAM-ID. SeniorTestProgram.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
	SELECT EmployeeFile ASSIGN TO 'EMPLOYEE.DAT'
		ORGANIZATION IS LINE SEQUENTIAL.
	SELECT ReportFile ASSIGN TO 'REPORT.TXT'
		ORGANIZATION IS LINE SEQUENTIAL.
		
DATA DIVISION.
FILE SECTION.
FD EmployeeFile.
01 EmployeeRecord.
	05 EmployeeID PIC 9(5).
	05 EmployeeName PIC X(30).
	05 EmployeeSalary PIC 9(7)V99.
	
FD ReportFile.
01 ReportLine PIC X(80).

WORKING-STORAGE SECTION.
01 EOF PIC X VALUE 'N'.
01 TotalSalary PIC 9(9)V99 VALUE ZERO.

PROCEDURE DIVISION.
Begin.
    OPEN INPUT EmployeeFile.
    OPEN OUTPUT ReportFile.
    READ EmployeeFile
        AT END SET EOF TO 'Y'
        NOT AT END ADD EmployeeSalary TO TotalSalary
    END-READ
    PERFORM UNTIL EOF = 'Y'
        READ EmployeeFile
            AT END SET EOF TO 'Y'
            NOT AT END ADD EmployeeSalary TO TotalSalary
        END-READ
    END-PERFORM
	
    MOVE "Total Salary: " TO ReportLine.
    STRING TotalSalary DELIMITED BY SIZE INTO ReportLine WITH POINTER 14.
    WRITE ReportLine.
    CLOSE EmployeeFile, ReportFile
    STOP RUN.