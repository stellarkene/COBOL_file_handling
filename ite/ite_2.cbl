      *prgrammer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRINT-1-TO-5.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           SELECT ITE2-FILE ASSIGN TO "ite_2.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD ITE2-FILE.

       01  ITE2_RECORD.
           05  ITE2_NUMBER_FH             PIC X(1).

       WORKING-STORAGE SECTION.
       01  ITE2_COUNTER                PIC 9(1).
       01  ITE2_EOF                    PIC X VALUE "N".
       01  ITE2_HISTORY                PIC X VALUE "N".

       PROCEDURE DIVISION.
           OPEN EXTEND ITE2-FILE.

           MOVE 1 TO ITE2_COUNTER.
           PERFORM 5 TIMES 
               DISPLAY ITE2_COUNTER
               MOVE ITE2_COUNTER TO ITE2_NUMBER_FH
               WRITE ITE2_RECORD
               ADD 1 TO ITE2_COUNTER
           END-PERFORM.
               MOVE "*" TO ITE2_NUMBER_FH.
               WRITE ITE2_RECORD.
           CLOSE ITE2-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT ITE2_HISTORY.

           IF ITE2_HISTORY = "Y" OR ITE2_HISTORY = "y"
               MOVE "N" TO ITE2_EOF
               OPEN INPUT ITE2-FILE
           
               DISPLAY "====================="
               PERFORM UNTIL ITE2_EOF = "Y"
                   READ ITE2-FILE
                       AT END 
                           MOVE "Y" TO ITE2_EOF
                       NOT AT END
                           IF ITE2_NUMBER_FH = "*"
                               DISPLAY "====================="
                               DISPLAY SPACE
                               DISPLAY "====================="
                           ELSE
                               DISPLAY ITE2_NUMBER_FH
                           END-IF
                   END-READ
               END-PERFORM
           
               CLOSE ITE2-FILE
               DISPLAY "END OF VIEW"
           END-IF.


           STOP RUN.
