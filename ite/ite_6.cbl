      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FACTORIAL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  ITE6_USER_INPUT              PIC 9(2).
       01  ITE6_COUNTER                 PIC 9(2).
       01  ITE6_CALC_FACTORIAL          PIC 9(19).
       01  ITE6_STORE_FAC               PIC Z,ZZZ,ZZZ,ZZZ,ZZZ,ZZZ,ZZZ.


       PROCEDURE DIVISION.
           MOVE 21 TO ITE6_USER_INPUT.
           
           PERFORM UNTIL ITE6_USER_INPUT <= 20
               DISPLAY "PLEASE INPUT A NUMBER: " WITH NO ADVANCING
               ACCEPT ITE6_USER_INPUT
               IF ITE6_USER_INPUT > 20
                   DISPLAY "FACTORIAL TOO LARGE PLEASE INPUT BELOW 21."
               END-IF
           END-PERFORM.

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
           
           
           MOVE ITE6_CALC_FACTORIAL TO ITE6_STORE_FAC.
           DISPLAY "FACTORIAL OF " 
-                  ITE6_USER_INPUT " IS " ITE6_STORE_FAC.

           STOP RUN.
