      *programmer name: Gabriel Sanchez 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EVEN-ODD.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION. 
               FILE-CONTROL.
           SELECT SEL3-FILE ASSIGN TO "sel_3.dat"
-              ORGANIZATION IS LINE SEQUENTIAL. 

       DATA DIVISION.
       FILE SECTION.
           FD SEL3-FILE.

       01  SEL3_RECORD.
            05  SEL3_USER_INPUT_OUT_FH             PIC Z(3).
            05  SEL3_RESULT_FH                     PIC X(20).


       WORKING-STORAGE SECTION.
       01  SEL3_USER_INPUT_IN              PIC 9(3).
       01  SEL3_USER_INPUT_OUT             PIC Z(3).
       01  SEL3_RESULT                     PIC X(20).
       01  SEL3_EOF                        PIC X VALUE "N".
       01  SEL3_HISTORY                    PIC X VALUE "N".

       PROCEDURE DIVISION.
           DISPLAY "PLEASE INPUT A NUMBER: " WITH NO ADVANCING.
           ACCEPT SEL3_USER_INPUT_IN.
           MOVE SEL3_USER_INPUT_IN TO SEL3_USER_INPUT_OUT.

           IF FUNCTION MOD(SEL3_USER_INPUT_IN, 2) = 0
               MOVE " IS EVEN" TO SEL3_RESULT
               DISPLAY SEL3_USER_INPUT_OUT, SEL3_RESULT
           ELSE 
               MOVE " IS ODD" TO SEL3_RESULT
               DISPLAY SEL3_USER_INPUT_OUT, SEL3_RESULT
           END-IF.

           OPEN EXTEND SEL3-FILE.
               MOVE SEL3_USER_INPUT_IN TO SEL3_USER_INPUT_OUT_FH.
               MOVE SEL3_RESULT TO SEL3_RESULT_FH.

               WRITE SEL3_RECORD.
           CLOSE SEL3-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT SEL3_HISTORY.

           IF SEL3_HISTORY = "Y" OR SEL3_HISTORY = "y"
           MOVE "N" TO SEL3_EOF
               OPEN INPUT SEL3-FILE
               PERFORM UNTIL SEL3_EOF = "Y"
                   READ SEL3-FILE
                       AT END
                           DISPLAY "END OF HISTORY"
                           MOVE "Y" TO SEL3_EOF

                       NOT AT END
                           DISPLAY "==============================="
                           DISPLAY "NUMBER: " SEL3_USER_INPUT_OUT_FH
                           DISPLAY "RESULT: " SEL3_RESULT_FH
                           DISPLAY "==============================="
                           DISPLAY SPACE

                   END-READ
               END-PERFORM
               CLOSE SEL3-FILE
           END-IF.

           STOP RUN.
