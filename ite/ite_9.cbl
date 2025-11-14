      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRIME_OR_NOT.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           SELECT ITE9-FILE ASSIGN TO "ite_9.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.   
           FD ITE9-FILE.

       01  ITE9_RECORD.
           05  ITE9_NUMBER_FH             PIC ZZ9.
           05  ITE9_PRIME_CHECK_FH        PIC X(10).

       WORKING-STORAGE SECTION.
       01  ITE9_USER_COUNTER            PIC 9(3).
       01  ITE9_USER_COUNTER_OUT        PIC ZZ9.
       01  ITE9_P_N                     PIC 9(1).
       01  ITE9_LOOP_COUNT              PIC 9(3).
       01  ITE9_EOF                    PIC X VALUE "N".
       01  ITE9_HISTORY                PIC X VALUE "N".
       


       PROCEDURE DIVISION.
           OPEN EXTEND ITE9-FILE.
           DISPLAY "PLEASE INPUT A NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE9_USER_COUNTER.
               
               MOVE ITE9_USER_COUNTER TO ITE9_NUMBER_FH.

           MOVE ITE9_USER_COUNTER TO ITE9_USER_COUNTER_OUT.
           DISPLAY ITE9_USER_COUNTER_OUT " IS " WITH NO ADVANCING.
           
           EVALUATE TRUE
           WHEN ITE9_USER_COUNTER = 0 OR ITE9_USER_COUNTER = 1
               DISPLAY "NOT A PRIME NUMBER"
               MOVE "NOT PRIME" TO ITE9_PRIME_CHECK_FH
           WHEN ITE9_USER_COUNTER = 2 
               DISPLAY "A PRIME NUMBER"
               MOVE "PRIME" TO ITE9_PRIME_CHECK_FH
           END-EVALUATE.

           MOVE 1 TO ITE9_P_N.
           MOVE 2 TO ITE9_LOOP_COUNT.
           PERFORM UNTIL ITE9_LOOP_COUNT = ITE9_USER_COUNTER
               IF FUNCTION MOD(ITE9_USER_COUNTER, ITE9_LOOP_COUNT) = 0  
                   MOVE 0 TO ITE9_P_N
                   EXIT PERFORM
               END-IF
               
               ADD 1 TO ITE9_LOOP_COUNT
           END-PERFORM.
           
           IF ITE9_P_N = 1
               DISPLAY  " A PRIME NUMBER"
               MOVE "PRIME" TO ITE9_PRIME_CHECK_FH
           ELSE
               DISPLAY  " NOT A PRIME NUMBER"
               MOVE "NOT PRIME" TO ITE9_PRIME_CHECK_FH
           END-IF.
               
               WRITE ITE9_RECORD.
           CLOSE ITE9-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT ITE9_HISTORY.

           IF ITE9_HISTORY = "Y" OR ITE9_HISTORY = "y"
               MOVE "N" TO ITE9_EOF
               OPEN INPUT ITE9-FILE
           
               PERFORM UNTIL ITE9_EOF = "Y"
                   READ ITE9-FILE
                       AT END 
                           MOVE "Y" TO ITE9_EOF
                       NOT AT END    
                           DISPLAY "====================="
                           DISPLAY "NUMBER: " ITE9_NUMBER_FH
                           DISPLAY "RESULT: " ITE9_PRIME_CHECK_FH
                           DISPLAY "====================="
                           DISPLAY SPACE
                   END-READ
               END-PERFORM
           
               CLOSE ITE9-FILE
               DISPLAY "END OF VIEW"
           END-IF.
       
           
           STOP RUN.
