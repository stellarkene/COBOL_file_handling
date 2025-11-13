      *prgrammer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRINT-1-TO-5.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  ITE2_COUNTER             PIC 9(1).

       PROCEDURE DIVISION.
           MOVE 1 TO ITE2_COUNTER.
           PERFORM 5 TIMES 
               DISPLAY ITE2_COUNTER
               ADD 1 TO ITE2_COUNTER
           END-PERFORM.

           STOP RUN.
