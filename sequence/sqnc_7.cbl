      *Programmer name: Gabriel Sanchez 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CUBE-AND-SQUARE.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           SELECT SQNC7-FILE ASSIGN TO "sqnc_7.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD SQNC7-FILE.

       01  SQNC7_RECORD.
           05  SEQ7_USER_NUMBER_FH         PIC ZZ9.
           05  SEQ7_SQUARE_FH              PIC ZZZ,ZZ9.
           05  SEQ7_CUBE_FH                PIC ZZZ,ZZZ,ZZ9.

       WORKING-STORAGE SECTION.
       01  SEQ7_USER_NUMBER        PIC 9(3).
       01  SEQ7_STORE_RESULT       PIC ZZZ,ZZZ,ZZ9.
       01  SEQ7_EOF                PIC X VALUE "N".
       01  SEQ7_HISTORY            PIC X VALUE "N".


       PROCEDURE DIVISION.
           OPEN EXTEND SQNC7-FILE

           DISPLAY "PLEASE INPUT A NUMBER: " WITH NO ADVANCING.
           ACCEPT SEQ7_USER_NUMBER.
           MOVE SEQ7_USER_NUMBER TO SEQ7_USER_NUMBER_FH.

           COMPUTE SEQ7_STORE_RESULT = SEQ7_USER_NUMBER ** 2.
           DISPLAY "SQUARE: " SEQ7_STORE_RESULT
           MOVE SEQ7_STORE_RESULT TO SEQ7_SQUARE_FH.
           
           COMPUTE SEQ7_STORE_RESULT = SEQ7_USER_NUMBER ** 3.
           DISPLAY "CUBE: " SEQ7_STORE_RESULT.
           MOVE SEQ7_STORE_RESULT TO SEQ7_CUBE_FH.


           WRITE SQNC7_RECORD.
           CLOSE SQNC7-FILE.

           DISPLAY "VIEW  HISTORY? (Y): " WITH NO ADVANCING.
           ACCEPT SEQ7_HISTORY.

           IF SEQ7_HISTORY = "Y" OR SEQ7_HISTORY = "y"
               MOVE "N" TO SEQ7_EOF
               OPEN INPUT SQNC7-FILE
               
               PERFORM UNTIL SEQ7_EOF = "Y"
               READ SQNC7-FILE
                   AT END
                       DISPLAY "END OF HISTORY"
                       MOVE "Y" TO SEQ7_EOF

                   NOT AT END
                       DISPLAY "==============================="
                       DISPLAY "NUMBER: " SEQ7_USER_NUMBER_FH
                       DISPLAY "SQUARE: " SEQ7_SQUARE_FH
                       DISPLAY "CUBE: " SEQ7_CUBE_FH
                       DISPLAY "==============================="
                       DISPLAY SPACE

               END-READ
               END-PERFORM

               CLOSE SQNC7-FILE

           END-IF
         
           STOP RUN.
