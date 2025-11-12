      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SMALLEST-OF-THREE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  SEL5_F_INPUT             PIC 9(5).
       01  SEL5_F_OUTPUT            PIC Z(5).
       01  SEL5_S_INPUT             PIC 9(5).
       01  SEL5_S_OUTPUT            PIC Z(5).
       01  SEL5_T_INPUT             PIC 9(5).
       01  SEL5_T_OUTPUT            PIC Z(5).
      

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
           
           EVALUATE TRUE

           WHEN SEL5_F_INPUT <= SEL5_S_INPUT 
-              AND SEL5_F_INPUT <= SEL5_T_INPUT
                   DISPLAY SEL5_F_OUTPUT " IS THE LOWEST NUMBER"

           WHEN SEL5_S_INPUT <= SEL5_F_INPUT 
-              AND SEL5_S_INPUT <= SEL5_T_INPUT
                   DISPLAY SEL5_S_OUTPUT " IS THE LOWEST NUMBER"

           WHEN OTHER 
               DISPLAY SEL5_T_OUTPUT " IS THE LOWEST NUMBER"
           END-EVALUATE.                                      
           
           STOP RUN.
