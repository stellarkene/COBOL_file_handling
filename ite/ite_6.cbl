      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FACTORIAL.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           SELECT ITE6-FILE ASSIGN TO "ite_6.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD ITE6-FILE.

       01  ITE6_RECORD.
           05  ITE6_USER_NUM_FH        PIC Z9.
           05  ITE6_RESULT_FH          PIC Z,ZZZ,ZZZ,ZZZ,ZZZ,ZZZ,ZZZ.

       WORKING-STORAGE SECTION.
       01  ITE6_USER_INPUT             PIC 9(2).
       01  ITE6_COUNTER                PIC 9(2).
       01  ITE6_CALC_FACTORIAL         PIC 9(19).
       01  ITE6_STORE_FAC              PIC Z,ZZZ,ZZZ,ZZZ,ZZZ,ZZZ,ZZZ.
       01  ITE6_EOF                    PIC X VALUE "N".
       01  ITE6_HISTORY                PIC X VALUE "N".


       PROCEDURE DIVISION.
           OPEN EXTEND ITE6-FILE.

           MOVE 21 TO ITE6_USER_INPUT.
           
           PERFORM UNTIL ITE6_USER_INPUT <= 20
               DISPLAY "PLEASE INPUT A NUMBER: " WITH NO ADVANCING
               ACCEPT ITE6_USER_INPUT
               IF ITE6_USER_INPUT > 20
                   DISPLAY "FACTORIAL TOO LARGE PLEASE INPUT BELOW 21."
               END-IF
           END-PERFORM.
               
               MOVE ITE6_USER_INPUT TO ITE6_USER_NUM_FH.

           MOVE ITE6_USER_INPUT TO ITE6_COUNTER.
           IF ITE6_USER_INPUT = 0 
               DISPLAY "1"
               STOP RUN
           END-IF.
           MOVE 1 TO ITE6_CALC_FACTORIAL.

           PERFORM UNTIL ITE6_COUNTER = 1
               COMPUTE ITE6_CALC_FACTORIAL = 
-                  ITE6_CALC_FACTORIAL * ITE6_COUNTER
               SUBTRACT 1 FROM ITE6_COUNTER
           END-PERFORM.

               MOVE ITE6_CALC_FACTORIAL TO ITE6_RESULT_FH.
           
           
           MOVE ITE6_CALC_FACTORIAL TO ITE6_STORE_FAC.
           DISPLAY "FACTORIAL OF " 
-                  ITE6_USER_INPUT " IS " ITE6_STORE_FAC.

               WRITE ITE6_RECORD.
           CLOSE ITE6-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT ITE6_HISTORY.

           IF ITE6_HISTORY = "Y" OR ITE6_HISTORY = "y"
               MOVE "N" TO ITE6_EOF
               OPEN INPUT ITE6-FILE
           
               PERFORM UNTIL ITE6_EOF = "Y"
                   READ ITE6-FILE
                       AT END 
                           MOVE "Y" TO ITE6_EOF
                       NOT AT END    
                           DISPLAY "====================="
                           DISPLAY ITE6_USER_NUM_FH "!"
                           DISPLAY "RESULT: " ITE6_RESULT_FH
                           DISPLAY "====================="
                           DISPLAY SPACE
                   END-READ
               END-PERFORM
           
               CLOSE ITE6-FILE
               DISPLAY "END OF VIEW"
           END-IF.

           STOP RUN.
