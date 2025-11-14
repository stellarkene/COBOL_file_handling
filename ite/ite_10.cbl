      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. GENERATE-BINARY.
       

        ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           SELECT ITE10-FILE ASSIGN TO "ite_10.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD ITE10-FILE.

       01  ITE10_RECORD.
           05  ITE10_DECIMAL_FH        PIC ZZZ,ZZ9.
           05  ITE10_BINARY_FH         PIC Z(20).

       WORKING-STORAGE SECTION.
       01  ITE10_USER_INPUT            PIC 9(6).
       01  ITE10_USERINT_OUT           PIC ZZZ,ZZ9.
       01  ITE10_PLACE_VALUE           PIC 9(20) value 1.
       01  ITE10_UI_REMAINDER          PIC 9(2).
       01  ITE10_CALC_INPUT            PIC 9(20) value 0.
       01  ITE10_STORE_BINARY          PIC Z(20).
       01  ITE10_EOF                   PIC X VALUE "N".
       01  ITE10_HISTORY               PIC X VALUE "N".



       PROCEDURE DIVISION.
           OPEN EXTEND ITE10-FILE.
           
           MOVE 0 TO ITE10_USER_INPUT.
           MOVE 0 TO ITE10_STORE_BINARY.
           MOVE 1 TO ITE10_PLACE_VALUE.
           DISPLAY "PLEASE INPUT A DECIMAL NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE10_USER_INPUT.
           MOVE ITE10_USER_INPUT TO ITE10_USERINT_OUT.
               
               MOVE ITE10_USER_INPUT TO ITE10_DECIMAL_FH.

           DISPLAY "DECIMAL: " ITE10_USERINT_OUT.
           PERFORM UNTIL ITE10_USER_INPUT = 0
               COMPUTE ITE10_UI_REMAINDER = 
-                  FUNCTION MOD(ITE10_USER_INPUT, 2)
               COMPUTE ITE10_CALC_INPUT = 
-                  ITE10_CALC_INPUT + (ITE10_UI_REMAINDER 
-                  * ITE10_PLACE_VALUE)
               COMPUTE ITE10_PLACE_VALUE = ITE10_PLACE_VALUE * 10
               COMPUTE ITE10_USER_INPUT = ITE10_USER_INPUT / 2
           END-PERFORM.

           MOVE ITE10_CALC_INPUT TO ITE10_STORE_BINARY.
           
           DISPLAY "BINARY: " ITE10_STORE_BINARY.
               
               MOVE ITE10_STORE_BINARY TO ITE10_BINARY_FH.


               WRITE ITE10_RECORD.
           CLOSE ITE10-FILE.


           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT ITE10_HISTORY.

           IF ITE10_HISTORY = "Y" OR ITE10_HISTORY = "y"
               MOVE "N" TO ITE10_EOF
               OPEN INPUT ITE10-FILE
           
               PERFORM UNTIL ITE10_EOF = "Y"
                   READ ITE10-FILE
                       AT END 
                           MOVE "Y" TO ITE10_EOF
                       NOT AT END    
                           DISPLAY "====================="
                           DISPLAY "DECIMAL: " ITE10_DECIMAL_FH
                           DISPLAY "BINARY: " ITE10_BINARY_FH
                           DISPLAY "====================="
                           DISPLAY SPACE
                   END-READ
               END-PERFORM
           
               CLOSE ITE10-FILE
               DISPLAY "END OF VIEW"
           END-IF.
       
           STOP RUN.
