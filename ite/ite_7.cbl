      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUM-OF-DIGITS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  ITE7_USER_INPUT              PIC 9(10).
       01  ITE7_STORE_SUM               PIC Z(3).
       01  ITE7_CALC_SUM                PIC 9(10).
       
       

       PROCEDURE DIVISION.
           MOVE 0 TO ITE7_CALC_SUM.
           DISPLAY "PLEASE INPUT A NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE7_USER_INPUT.

           PERFORM UNTIL ITE7_USER_INPUT = 0
               ADD FUNCTION MOD(ITE7_USER_INPUT, 10) TO ITE7_CALC_SUM
               COMPUTE ITE7_USER_INPUT = ITE7_USER_INPUT / 10
           END-PERFORM.
           
           MOVE ITE7_CALC_SUM TO ITE7_STORE_SUM.
           DISPLAY "IS: " ITE7_STORE_SUM.

           STOP RUN.
