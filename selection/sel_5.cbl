      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SMALLEST-OF-THREE.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION. 
               FILE-CONTROL.
           SELECT SEL5-FILE ASSIGN TO "sel_5.dat"
-              ORGANIZATION IS LINE SEQUENTIAL. 

       DATA DIVISION.
       FILE SECTION.
           FD SEL5-FILE.

       01  SEL5_RECORD.
           05  SEL5_F_OUTPUT_FH            PIC ZZ,ZZZ.
           05  SEL5_S_OUTPUT_FH            PIC ZZ,ZZZ.
           05  SEL5_T_OUTPUT_FH            PIC ZZ,ZZZ.
           05  SEL5_RESULT_FH              PIC ZZ,ZZZ.
           
           
       WORKING-STORAGE SECTION.
       01  SEL5_F_INPUT                PIC 9(5).
       01  SEL5_F_OUTPUT               PIC Z(5).
       01  SEL5_S_INPUT                PIC 9(5).
       01  SEL5_S_OUTPUT               PIC Z(5).
       01  SEL5_T_INPUT                PIC 9(5).
       01  SEL5_T_OUTPUT               PIC Z(5).

       01  SEL5_EOF                    PIC X VALUE "N".
       01  SEL5_HISTORY                PIC X VALUE "N".
      

       PROCEDURE DIVISION.
           DISPLAY "PLEASE INPUT THE FIRST NUMBER: "
-             WITH NO ADVANCING.
           ACCEPT SEL5_F_INPUT.
           MOVE SEL5_F_INPUT TO SEL5_F_OUTPUT.

           DISPLAY "PLEASE INPUT THE SECOND NUMBER: "
-              WITH NO ADVANCING.
           ACCEPT SEL5_S_INPUT.
           MOVE SEL5_S_INPUT TO SEL5_S_OUTPUT.

           DISPLAY "PLEASE INPUT THE THIRD NUMBER: "
-              WITH NO ADVANCING.
           ACCEPT SEL5_T_INPUT.
           MOVE SEL5_T_INPUT TO SEL5_T_OUTPUT.

           OPEN EXTEND SEL5-FILE.
               MOVE SEL5_F_INPUT TO SEL5_F_OUTPUT_FH.
               MOVE SEL5_S_INPUT TO SEL5_S_OUTPUT_FH.
               MOVE SEL5_T_INPUT TO SEL5_T_OUTPUT_FH.
           
           EVALUATE TRUE

           WHEN SEL5_F_INPUT <= SEL5_S_INPUT 
-              AND SEL5_F_INPUT <= SEL5_T_INPUT
                   DISPLAY SEL5_F_OUTPUT " IS THE LOWEST NUMBER"
                   MOVE SEL5_F_OUTPUT_FH TO SEL5_RESULT_FH

           WHEN SEL5_S_INPUT <= SEL5_F_INPUT 
-              AND SEL5_S_INPUT <= SEL5_T_INPUT
                   DISPLAY SEL5_S_OUTPUT " IS THE LOWEST NUMBER"
                   MOVE SEL5_S_OUTPUT_FH TO SEL5_RESULT_FH

           WHEN OTHER 
               DISPLAY SEL5_T_OUTPUT " IS THE LOWEST NUMBER"
               MOVE SEL5_T_OUTPUT_FH TO SEL5_RESULT_FH
           END-EVALUATE.   

               WRITE SEL5_RECORD.
           CLOSE SEL5-FILE.    

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT SEL5_HISTORY.

           IF SEL5_HISTORY = "Y" OR SEL5_HISTORY = "y"
           MOVE "N" TO SEL5_EOF
               OPEN INPUT SEL5-FILE
               PERFORM UNTIL SEL5_EOF = "Y"
                   READ SEL5-FILE
                       AT END
                           DISPLAY "END OF HISTORY"
                           MOVE "Y" TO SEL5_EOF

                       NOT AT END
                           DISPLAY "==============================="
                           DISPLAY "FIRST NUMBER: " SEL5_F_OUTPUT_FH
                           DISPLAY "SECOND NUMBER: " SEL5_S_OUTPUT_FH
                           DISPLAY "THIRD NUMBER: " SEL5_T_OUTPUT_FH
                           DISPLAY "LOWEST NUMBER: " SEL5_RESULT_FH
                           DISPLAY "==============================="
                           DISPLAY SPACE

                   END-READ
               END-PERFORM
               CLOSE SEL5-FILE
           END-IF.                               
           
           STOP RUN.
