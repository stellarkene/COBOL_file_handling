      * programmer name: Gabriel E. Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SWAP-NUM.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           SELECT SQNC2-FILE ASSIGN TO "sqnc_2.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
           FILE SECTION.
           FD SQNC2-FILE.

       01  SQNC2_RECORD.
           05  SEQ2_numA_FH     PIC 9(2) VALUE 10.
           05  SEQ2_numB_FH     PIC 9(2) VALUE 5.
           05  SEQ2_numC_FH     PIC Z(2).
       
       
       WORKING-STORAGE SECTION.
       01  SEQ2_numA            PIC 9(2) VALUE 10.
       01  SEQ2_numB            PIC 9(2) VALUE 5.
       01  SEQ2_numC            PIC Z(2).
       01  EOF                 PIC X VALUE "N".

       PROCEDURE DIVISION.
           
           OPEN INPUT SQNC2-FILE
           READ SQNC2-FILE
           AT END
               CLOSE SQNC2-FILE
               OPEN OUTPUT SQNC2-FILE
               MOVE SEQ2_numA TO SEQ2_numA_FH
               MOVE SEQ2_numB TO SEQ2_numB_FH
               WRITE SQNC2_RECORD
               CLOSE SQNC2-FILE
               MOVE "Y" TO EOF
           END-READ
    
           IF EOF = "Y"
               OPEN INPUT SQNC2-FILE
               READ SQNC2-FILE
               CLOSE SQNC2-FILE
           END-IF
    
           MOVE SEQ2_numA_FH TO SEQ2_numA
           MOVE SEQ2_numB_FH TO SEQ2_numB


           DISPLAY "BEFORE SWAP: ".
           DISPLAY "A: " SEQ2_numA.
           DISPLAY "B: " SEQ2_numB.
 
           MOVE SEQ2_numB TO SEQ2_numC.
           MOVE SEQ2_numA TO SEQ2_numB.
           MOVE SEQ2_numC TO SEQ2_numA. 
 
           DISPLAY "AFTER SWAP: ".
           DISPLAY "A: " SEQ2_numA.
           DISPLAY "B: " SEQ2_numB.

           CLOSE SQNC2-FILE
           STOP RUN.
