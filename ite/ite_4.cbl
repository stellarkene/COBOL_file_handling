      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. NUMBERS_FROM_N_TO_N.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  ITE4_USER_INPUT_N            PIC 9(3).
       01  ITE4_USER_INPUT_M            PIC 9(3).
       01  ITE4_COUNTER                 PIC 9(3).
       01  ITE4_STORE_OUTPUT            PIC Z(3).

       PROCEDURE DIVISION.
           MOVE 0 TO ITE4_COUNTER.
           DISPLAY "PLEASE ENTER A NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE4_USER_INPUT_N.

           DISPLAY "PLEASE ENTER ANOTHER NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE4_USER_INPUT_M.


           MOVE ITE4_USER_INPUT_N TO ITE4_COUNTER.

           PERFORM UNTIL ITE4_COUNTER > ITE4_USER_INPUT_M

               IF FUNCTION MOD(ITE4_COUNTER, 2) = 0
                   MOVE ITE4_COUNTER TO ITE4_STORE_OUTPUT
                   DISPLAY ITE4_STORE_OUTPUT
               END-IF
               
               ADD 1 TO ITE4_COUNTER
           END-PERFORM.

           STOP RUN.
