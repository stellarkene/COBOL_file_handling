      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUM-OF-ODD-NUM.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           SELECT ITE5-FILE ASSIGN TO "ite_5.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD ITE5-FILE.

       01  ITE5_RECORD.
           05  ITE5_START_FH           PIC ZZZ.
           05  ITE5_END_FH             PIC ZZZ.
           05  ITE5_RESULT             PIC ZZZ.

       WORKING-STORAGE SECTION.
       01  ITE5_USER_INPUT_N           PIC 9(3).
       01  ITE5_USER_INPUT_M           PIC 9(3).
       01  ITE5_STORE_SUM              PIC 9(3).
       01  ITE5_COUNTER                PIC 9(3).
       01  ITE5_SUM_OUT                PIC Z(3).
       01  ITE5_EOF                    PIC X VALUE "N".
       01  ITE5_HISTORY                PIC X VALUE "N".

       PROCEDURE DIVISION.
           OPEN EXTEND ITE5-FILE.

           MOVE 0 TO ITE5_STORE_SUM.
           DISPLAY "PLEASE INSERT A NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE5_USER_INPUT_N.

           DISPLAY "PLEASE INPUT ANOTHER NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE5_USER_INPUT_M.

           MOVE ITE5_USER_INPUT_N TO ITE5_COUNTER.
               
               MOVE ITE5_USER_INPUT_N TO ITE5_START_FH.
               MOVE ITE5_USER_INPUT_M TO ITE5_END_FH.
               

           PERFORM UNTIL ITE5_COUNTER > ITE5_USER_INPUT_M
               IF FUNCTION MOD(ITE5_COUNTER, 2) IS NOT EQUAL TO 0
                   ADD ITE5_COUNTER TO ITE5_STORE_SUM
               END-IF
               ADD 1 TO ITE5_COUNTER
           END-PERFORM.
           
           MOVE ITE5_STORE_SUM TO ITE5_SUM_OUT.
           DISPLAY "SUM OF ODD NUMBERS: " ITE5_SUM_OUT.

               MOVE ITE5_SUM_OUT TO ITE5_RESULT.
               WRITE ITE5_RECORD.
           CLOSE ITE5-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT ITE5_HISTORY.

           IF ITE5_HISTORY = "Y" OR ITE5_HISTORY = "y"
               MOVE "N" TO ITE5_EOF
               OPEN INPUT ITE5-FILE
           
               PERFORM UNTIL ITE5_EOF = "Y"
                   READ ITE5-FILE
                       AT END 
                           MOVE "Y" TO ITE5_EOF
                       NOT AT END    
                           DISPLAY "====================="
                           DISPLAY "START: " ITE5_START_FH
                           DISPLAY "END: " ITE5_END_FH
                           DISPLAY "SUM OF ODD NUMBERS: " ITE5_RESULT
                           DISPLAY "====================="
                           DISPLAY SPACE
                   END-READ
               END-PERFORM
           
               CLOSE ITE5-FILE
               DISPLAY "END OF VIEW"
           END-IF.

           STOP RUN.
