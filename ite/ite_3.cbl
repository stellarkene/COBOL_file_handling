      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EVEN-NUMBERS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  ITE3_USER_INPUT_IN               PIC 9(4).
       01  ITE3_USER_INTPUT_OUT             PIC Z,ZZZ.
       01  ITE3_COUNTER                     PIC 9(4).

       PROCEDURE DIVISION.
           DISPLAY "PLEASE ENTER A NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE3_USER_INPUT_IN.

           MOVE 1 TO ITE3_COUNTER.
           PERFORM ITE3_USER_INPUT_IN TIMES

               IF FUNCTION MOD(ITE3_COUNTER, 2) IS EQUAL TO 0
                   MOVE ITE3_COUNTER TO ITE3_USER_INTPUT_OUT
                   DISPLAY ITE3_USER_INTPUT_OUT
               END-IF

               ADD 1 TO ITE3_COUNTER
           END-PERFORM.

           STOP RUN.
