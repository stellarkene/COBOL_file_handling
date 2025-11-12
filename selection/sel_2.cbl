      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. POSITIVE-OR-NEGATIVE.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION. 
               FILE-CONTROL.
           SELECT SEL2-FILE ASSIGN TO "sel_2.dat"
-              ORGANIZATION IS LINE SEQUENTIAL. 

       DATA DIVISION.
       FILE SECTION.
           FD SEL2-FILE.

       01  SEL2_RECORD.
            05  SEL2_INPUT_OUT_FH              PIC +Z(7).
            05  SEL2_RESULT_FH                 PIC X(20).

       WORKING-STORAGE SECTION.
       01  SEL2_USER_INPUT             PIC S9(7).
       01  SEL2_INPUT_OUT              PIC Z(7).
       01  SEL2_RESULT                 PIC X(20).
       01  SEL2_EOF                    PIC X VALUE "N".
       01  SEL2_HISTORY                PIC X VALUE "N".
      
      

       PROCEDURE DIVISION.
           DISPLAY "PLEASE INPUT A NUMBER: " WITH NO ADVANCING.
           ACCEPT SEL2_USER_INPUT.
           MOVE SEL2_USER_INPUT TO SEL2_INPUT_OUT.
           
           EVALUATE TRUE
           WHEN SEL2_USER_INPUT > 0
               MOVE " IS POSITIVE" TO SEL2_RESULT
               DISPLAY SEL2_INPUT_OUT, SEL2_RESULT

           WHEN SEL2_USER_INPUT < 0 
               MOVE " IS NEGATIVE" TO SEL2_RESULT
               DISPLAY "-" SEL2_INPUT_OUT, SEL2_RESULT

           WHEN OTHER 
               MOVE " IS ZERO" TO SEL2_RESULT
               DISPLAY SEL2_INPUT_OUT, SEL2_RESULT
               
           END-EVALUATE.

           OPEN EXTEND SEL2-FILE.
               MOVE SEL2_USER_INPUT TO SEL2_INPUT_OUT_FH.
               MOVE SEL2_RESULT TO SEL2_RESULT_FH.

               WRITE SEL2_RECORD.
           CLOSE SEL2-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT SEL2_HISTORY.

           IF SEL2_HISTORY = "Y" OR SEL2_HISTORY = "y"
           MOVE "N" TO SEL2_EOF
               OPEN INPUT SEL2-FILE
               PERFORM UNTIL SEL2_EOF = "Y"
                   READ SEL2-FILE
                       AT END
                           DISPLAY "END OF HISTORY"
                           MOVE "Y" TO SEL2_EOF

                       NOT AT END
                           DISPLAY "==============================="
                           DISPLAY "NUMBER: " SEL2_INPUT_OUT_FH
                           DISPLAY "RESULT: " SEL2_RESULT_FH
                           DISPLAY "==============================="
                           DISPLAY SPACE

                   END-READ
               END-PERFORM
               CLOSE SEL2-FILE
           END-IF.
           STOP RUN.
