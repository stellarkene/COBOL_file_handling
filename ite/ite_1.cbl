      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRINT-NAME-5-TIMES.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           SELECT ITE1-FILE ASSIGN TO "ite_1.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.   
           FD ITE1-FILE.

       01  ITE1_RECORD.
           05  ITE1_NAME_FH            PIC X(30).

       WORKING-STORAGE SECTION.
       01  ITE1_COUNTER                PIC 9 VALUE 5.
       01  ITE1_EOF                    PIC X VALUE "N".
       01  ITE1_HISTORY                PIC X VALUE "N".

       PROCEDURE DIVISION.
           
           OPEN EXTEND ITE1-FILE.

           PERFORM ITE1_COUNTER TIMES
               DISPLAY "GABRIEL E. SANCHEZ"
               
           END-PERFORM.
      *NOT REALLY SURE IF I WILL WRITE IN THE LOOP BUT SINCE ITS JUST 
      *PRINTING 5 TIMES, I WILL JUST WRITE 1 TIME AND PRINT 5 TIMES
               MOVE "GABRIEL E. SANCHEZ" TO ITE1_NAME_FH        
               WRITE ITE1_RECORD.
           CLOSE ITE1-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT ITE1_HISTORY.

           IF ITE1_HISTORY = "Y" OR ITE1_HISTORY = "y"
           MOVE "N" TO ITE1_EOF
               OPEN INPUT ITE1-FILE
               
               PERFORM UNTIL ITE1_EOF = "Y"
               READ ITE1-FILE
                   AT END 
                       DISPLAY "END OF VIEW"
                       MOVE "Y" TO ITE1_EOF

                   NOT AT END
                       DISPLAY "====================="
                       PERFORM 5 TIMES
                           DISPLAY ITE1_NAME_FH
                       END-PERFORM
                       DISPLAY "====================="
                       DISPLAY SPACE

               END-READ
               END-PERFORM
               
               CLOSE ITE1-FILE
           END-IF.

           STOP RUN.
