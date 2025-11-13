      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. VOWEL-CONSONANT.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION. 
               FILE-CONTROL.
           SELECT SEL10-FILE ASSIGN TO "sel_10.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD SEL10-FILE.

       01  SEL10_RECORD.
           05 SEL10_CHARACTER_FH           PIC X.
           05 SEL10_RESULT_FH              PIC X(10).

       WORKING-STORAGE SECTION.
      
       01  SEL10_USER_CHARAC               PIC X.
       01  SEL10_EOF                       PIC X VALUE "N".
       01  SEL10_HISTORY                   PIC X VALUE "N".

       PROCEDURE DIVISION.
           OPEN EXTEND SEL10-FILE.

           DISPLAY "PLEASE INPUT A CHARACTER: " WITH NO ADVANCING.
           ACCEPT SEL10_USER_CHARAC.
               MOVE SEL10_USER_CHARAC TO SEL10_CHARACTER_FH.

           IF SEL10_USER_CHARAC = 'A' OR SEL10_USER_CHARAC = "a" OR
-              SEL10_USER_CHARAC = 'E' OR SEL10_USER_CHARAC = "e" OR
-              SEL10_USER_CHARAC = 'I' OR SEL10_USER_CHARAC = "i" OR
-              SEL10_USER_CHARAC = 'O' OR SEL10_USER_CHARAC = "o" OR
-              SEL10_USER_CHARAC = 'U' OR SEL10_USER_CHARAC = "u" 
           
               DISPLAY SEL10_USER_CHARAC " IS A VOWEL"
               MOVE "VOWEL" TO SEL10_RESULT_FH
           ELSE 
               DISPLAY SEL10_USER_CHARAC " IS A CONSONANT"
               MOVE "CONSONANT" TO SEL10_RESULT_FH
           END-IF.
           
               WRITE SEL10_RECORD.
           CLOSE SEL10-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT SEL10_HISTORY.

           IF SEL10_HISTORY = "Y" OR SEL10_HISTORY = "y"
           MOVE "N" TO SEL10_EOF
               OPEN INPUT SEL10-FILE
               PERFORM UNTIL SEL10_EOF = "Y"
                   READ SEL10-FILE
                       AT END
                           DISPLAY "END OF HISTORY"
                           MOVE "Y" TO SEL10_EOF

                       NOT AT END
                       DISPLAY "==============================="
                       DISPLAY "CAHARACTER: " SEL10_CHARACTER_FH
                       DISPLAY SEL10_RESULT_FH 
                       DISPLAY "==============================="
                       DISPLAY SPACE

                   END-READ
               END-PERFORM
               CLOSE SEL10-FILE
           END-IF. 
           STOP RUN.
