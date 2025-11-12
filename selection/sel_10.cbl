      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. VOWEL-CONSONANT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      
       01  SEL10_USER_CHARAC             PIC X(1).

       PROCEDURE DIVISION.
           DISPLAY "PLEASE INPUT A CHARACTER: " WITH NO ADVANCING.
           ACCEPT SEL10_USER_CHARAC.

           IF SEL10_USER_CHARAC = 'A' OR SEL10_USER_CHARAC = "a" OR
-              SEL10_USER_CHARAC = 'E' OR SEL10_USER_CHARAC = "e" OR
-              SEL10_USER_CHARAC = 'I' OR SEL10_USER_CHARAC = "i" OR
-              SEL10_USER_CHARAC = 'O' OR SEL10_USER_CHARAC = "o" OR
-              SEL10_USER_CHARAC = 'U' OR SEL10_USER_CHARAC = "u" 
           
               DISPLAY SEL10_USER_CHARAC " IS A VOWEL"
           ELSE 
               DISPLAY SEL10_USER_CHARAC " IS A CONSONANT"
           END-IF.
           STOP RUN.
