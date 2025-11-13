      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EVEN-NUMBERS.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           SELECT ITE3-FILE ASSIGN TO "ite_3.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD ITE3-FILE.

       01  ITE3_RECORD.
           05  ITE3_LIMIT_FH               PIC Z,ZZZ.
           05  ITE3_EVEN_NUM_FH            PIC Z,ZZZ.
           05  ITE3_END_BLOCK_FH           PIC X.

       WORKING-STORAGE SECTION.
       01  ITE3_USER_INPUT_IN              PIC 9(4).
       01  ITE3_USER_INTPUT_OUT            PIC Z,ZZZ.
       01  ITE3_COUNTER                    PIC 9(4).
       01  ITE3_EOF                        PIC X VALUE "N".
       01  ITE3_HISTORY                    PIC X VALUE "N".

       PROCEDURE DIVISION.
           OPEN EXTEND ITE3-FILE.

           DISPLAY "PLEASE ENTER A NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE3_USER_INPUT_IN.

               MOVE ITE3_USER_INPUT_IN TO ITE3_LIMIT_FH.
               WRITE ITE3_RECORD.

           MOVE 1 TO ITE3_COUNTER.
           PERFORM ITE3_USER_INPUT_IN TIMES

               IF FUNCTION MOD(ITE3_COUNTER, 2) IS EQUAL TO 0
                   MOVE ITE3_COUNTER TO ITE3_USER_INTPUT_OUT
                   DISPLAY ITE3_USER_INTPUT_OUT
                   MOVE ITE3_COUNTER TO ITE3_EVEN_NUM_FH
                   WRITE ITE3_RECORD
               END-IF

               ADD 1 TO ITE3_COUNTER
           END-PERFORM.

               MOVE "*" TO ITE3_END_BLOCK_FH.
               WRITE ITE3_RECORD
           CLOSE ITE3-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT ITE3_HISTORY.

           IF ITE3_HISTORY = "Y" OR ITE3_HISTORY = "y"
               MOVE "N" TO ITE3_EOF
               OPEN INPUT ITE3-FILE
           
               DISPLAY "====================="
               PERFORM UNTIL ITE3_EOF = "Y"
                   READ ITE3-FILE
                       AT END 
                           MOVE "Y" TO ITE3_EOF
                       NOT AT END                           
                           IF ITE3_END_BLOCK_FH = "*"
                               DISPLAY "UP TO: " ITE3_LIMIT_FH
                               DISPLAY "====================="
                               DISPLAY SPACE
                               DISPLAY "====================="
                           ELSE
                               DISPLAY ITE3_EVEN_NUM_FH
                           END-IF
                   END-READ
               END-PERFORM
           
               CLOSE ITE3-FILE
               DISPLAY "END OF VIEW"
           END-IF.


           STOP RUN.
