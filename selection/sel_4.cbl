      *programmer name: Gabriel Sanchez 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. LARGER-OF-TWO.

        ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION. 
               FILE-CONTROL.
           SELECT SEL4-FILE ASSIGN TO "sel_4.dat"
-              ORGANIZATION IS LINE SEQUENTIAL. 

       DATA DIVISION.
       FILE SECTION.
           FD SEL4-FILE.

       01  SEL4_RECORD.
           05  SEL4_GREATER_FH             PIC ZZ,ZZZ.
           05  SEL4_RESULT_FH              PIC X(17).
           05  SEL4_LOWER_FH               PIC ZZ,ZZZ.
           

       WORKING-STORAGE SECTION.
       01  SEL4_FIRST_INPUT                PIC 9(5).
       01  SEL4_FIRST_INPUT_OUT            PIC Z(5).
       01  SEL4_SEC_INPUT                  PIC 9(5).
       01  SEL4_SEC_INPUT_OUT              PIC Z(5).
       01  SEL4_EOF                        PIC X VALUE "N".
       01  SEL4_HISTORY                    PIC X VALUE "N".

       PROCEDURE DIVISION.
           DISPLAY "PLEASE ENTER A NUMBER: " WITH NO ADVANCING.
           ACCEPT SEL4_FIRST_INPUT.
           MOVE SEL4_FIRST_INPUT TO SEL4_FIRST_INPUT_OUT.

           DISPLAY "PLEASE ENTER ANOTHER NUMBER: " WITH NO ADVANCING.
           ACCEPT SEL4_SEC_INPUT.
           MOVE SEL4_SEC_INPUT TO SEL4_SEC_INPUT_OUT.

           EVALUATE TRUE
           WHEN SEL4_FIRST_INPUT > SEL4_SEC_INPUT
               DISPLAY SEL4_FIRST_INPUT_OUT " IS GREATER THAN " 
-                  SEL4_SEC_INPUT_OUT
               OPEN EXTEND SEL4-FILE
                   MOVE SEL4_FIRST_INPUT TO SEL4_GREATER_FH
                   MOVE SEL4_SEC_INPUT TO SEL4_LOWER_FH
                   MOVE " IS GREATER THAN " TO SEL4_RESULT_FH

                   WRITE SEL4_RECORD
               CLOSE SEL4-FILE

           WHEN SEL4_FIRST_INPUT < SEL4_SEC_INPUT
               DISPLAY SEL4_SEC_INPUT_OUT " IS GREATER THAN "
-                  SEL4_FIRST_INPUT_OUT
                   OPEN EXTEND SEL4-FILE
                   MOVE SEL4_FIRST_INPUT TO SEL4_LOWER_FH
                   MOVE SEL4_SEC_INPUT TO SEL4_GREATER_FH
                   MOVE " IS GREATER THAN " TO SEL4_RESULT_FH

                   WRITE SEL4_RECORD
               CLOSE SEL4-FILE

           WHEN OTHER
               DISPLAY "INPUTS ARE EQUAL"
               OPEN EXTEND SEL4-FILE
                   MOVE SEL4_FIRST_INPUT TO SEL4_GREATER_FH
                   MOVE SEL4_SEC_INPUT TO SEL4_LOWER_FH
                   MOVE " IS EQUAL TO " TO SEL4_RESULT_FH

                   WRITE SEL4_RECORD
               CLOSE SEL4-FILE
               
           END-EVALUATE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT SEL4_HISTORY.

           IF SEL4_HISTORY = "Y" OR SEL4_HISTORY = "y"
           MOVE "N" TO SEL4_EOF
               OPEN INPUT SEL4-FILE
               PERFORM UNTIL SEL4_EOF = "Y"
                   READ SEL4-FILE
                       AT END
                           DISPLAY "END OF HISTORY"
                           MOVE "Y" TO SEL4_EOF

                       NOT AT END
                           DISPLAY "==============================="
                           DISPLAY SEL4_GREATER_FH WITH NO ADVANCING
                           DISPLAY SEL4_RESULT_FH WITH NO ADVANCING
                           DISPLAY SEL4_LOWER_FH 
                           DISPLAY "==============================="
                           DISPLAY SPACE

                   END-READ
               END-PERFORM
               CLOSE SEL4-FILE
           END-IF.


           STOP RUN.
