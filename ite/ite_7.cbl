      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUM-OF-DIGITS.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           SELECT ITE7-FILE ASSIGN TO "ite_7.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD ITE7-FILE.

       01  ITE7_RECORD.
           05  ITE7_DIGITS             PIC Z,ZZZ,ZZZ,ZZZ.
           05  ITE7_RESULT             PIC ZZZ.

       WORKING-STORAGE SECTION.
       01  ITE7_USER_INPUT             PIC 9(10).
       01  ITE7_STORE_SUM              PIC Z(3).
       01  ITE7_CALC_SUM               PIC 9(10).
       01  ITE7_EOF                    PIC X VALUE "N".
       01  ITE7_HISTORY                PIC X VALUE "N".
       
       

       PROCEDURE DIVISION.
           OPEN EXTEND ITE7-FILE.

           MOVE 0 TO ITE7_CALC_SUM.
           DISPLAY "PLEASE INPUT A NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE7_USER_INPUT.

               MOVE ITE7_USER_INPUT TO ITE7_DIGITS.

           PERFORM UNTIL ITE7_USER_INPUT = 0
               ADD FUNCTION MOD(ITE7_USER_INPUT, 10) TO ITE7_CALC_SUM
               COMPUTE ITE7_USER_INPUT = ITE7_USER_INPUT / 10
           END-PERFORM.

               MOVE ITE7_CALC_SUM TO ITE7_RESULT.
           
           MOVE ITE7_CALC_SUM TO ITE7_STORE_SUM.
           DISPLAY "IS: " ITE7_STORE_SUM.

               WRITE ITE7_RECORD.
           CLOSE ITE7-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT ITE7_HISTORY.

           IF ITE7_HISTORY = "Y" OR ITE7_HISTORY = "y"
               MOVE "N" TO ITE7_EOF
               OPEN INPUT ITE7-FILE
           
               PERFORM UNTIL ITE7_EOF = "Y"
                   READ ITE7-FILE
                       AT END 
                           MOVE "Y" TO ITE7_EOF
                       NOT AT END    
                           DISPLAY "====================="
                           DISPLAY "NUMBER: " ITE7_DIGITS
                           DISPLAY "RESULT: " ITE7_RESULT
                           DISPLAY "====================="
                           DISPLAY SPACE
                   END-READ
               END-PERFORM
           
               CLOSE ITE7-FILE
               DISPLAY "END OF VIEW"
           END-IF.

           STOP RUN.
