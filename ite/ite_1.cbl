      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRINT-NAME-5-TIMES.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  ITE1_COUNTER             PIC 9 VALUE 5.

       PROCEDURE DIVISION.

           PERFORM ITE1_COUNTER TIMES
               DISPLAY "GABRIEL E. SANCHEZ"
           END-PERFORM.

           STOP RUN.
