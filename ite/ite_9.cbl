      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRIME_OR_NOT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  ITE9_USER_COUNTER            PIC 9(3).
       01  ITE9_USER_COUNTER_OUT        PIC ZZ9.
       01  ITE9_P_N                     PIC 9(1).
       01  ITE9_LOOP_COUNT              PIC 9(3).
       


       PROCEDURE DIVISION.
           DISPLAY "PLEASE INPUT A NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE9_USER_COUNTER.

           MOVE ITE9_USER_COUNTER TO ITE9_USER_COUNTER_OUT.
           DISPLAY ITE9_USER_COUNTER_OUT " IS " WITH NO ADVANCING.
           
           EVALUATE TRUE
           WHEN ITE9_USER_COUNTER = 0 OR ITE9_USER_COUNTER = 1
               DISPLAY "NOT A PRIME NUMBER"
               STOP RUN
           WHEN ITE9_USER_COUNTER = 2 
               DISPLAY "A PRIME NUMBER"
               STOP RUN
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
           ELSE
               DISPLAY  " NOT A PRIME NUMBER"
           END-IF.
       
           
           STOP RUN.
