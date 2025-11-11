      * programmer name: Gabriel E. Sanchez
      *Compile with "cobc -x program_name.cbl"
      *Run program with "./program_name"
       IDENTIFICATION DIVISION.
       PROGRAM-ID. NAME-PRINT.

           ENVIRONMENT DIVISION.
               INPUT-OUTPUT SECTION.
                   FILE-CONTROL.
               SELECT SQNC1-FILE ASSIGN TO "sqnc_1.dat"
-                  ORGANIZATION IS LINE SEQUENTIAL.
        
           DATA DIVISION.
               FILE SECTION.
               FD SQNC1-FILE.
        
           01  SQNC1_RECORD.
               05 SQNC1_FH_NAME    PIC X(30).

           WORKING-STORAGE SECTION.
            01  SQNC1_NAME          PIC X(30).
            01  EOF                 PIC X VALUE "N".
               
       
       
       PROCEDURE DIVISION.
           DISPLAY "WHAT IS YOUR NAME? ".
           ACCEPT SQNC1_NAME.

           OPEN EXTEND SQNC1-FILE.
           

           PERFORM 5 TIMES
           MOVE SQNC1_NAME TO SQNC1_FH_NAME
           WRITE SQNC1_RECORD
           END-PERFORM.

           CLOSE SQNC1-FILE.

      *PRINT NAME
           DISPLAY "PRINTING 5 TIMES...".
           OPEN INPUT SQNC1-FILE.
           PERFORM UNTIL EOF = "Y"
           READ SQNC1-FILE
               AT END 
                   MOVE "Y" TO EOF

               NOT AT END 
                   DISPLAY SQNC1_FH_NAME
           
               END-READ

           END-PERFORM.
           CLOSE SQNC1-FILE.

           STOP RUN.
