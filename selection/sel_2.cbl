      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. POSITIVE-OR-NEGATIVE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  SEL2_USER_INPUT             PIC S9(7).
       01  SEL2_INPUT_OUT              PIC Z(7).
       01  SEL2_RESULT                 PIC X (20).
      
      

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
           STOP RUN.
