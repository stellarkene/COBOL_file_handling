      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEMPARATURE-INFO.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  SEL7_USER_TEMP_IN            PIC S9(5)V99.
       

       PROCEDURE DIVISION.
           DISPLAY "PLEASE ENTER YOUR TEMPERATURE: " WITH NO ADVANCING.
           ACCEPT SEL7_USER_TEMP_IN.
           
           EVALUATE TRUE
           WHEN  SEL7_USER_TEMP_IN < 0
               DISPLAY "FREEZING WEATHER."

           WHEN SEL7_USER_TEMP_IN >= 0 AND SEL7_USER_TEMP_IN <= 10
               DISPLAY "VERY COLD WEATHER."

           WHEN SEL7_USER_TEMP_IN >= 11 AND SEL7_USER_TEMP_IN <= 20
               DISPLAY "COLD WEATHER."

           WHEN SEL7_USER_TEMP_IN >= 21 AND SEL7_USER_TEMP_IN <= 30
               DISPLAY "NORMAL TEMPERATURE." 

           WHEN SEL7_USER_TEMP_IN >= 31 AND SEL7_USER_TEMP_IN <= 40
               DISPLAY "ITS HOT."

           WHEN OTHER
               DISPLAY "ITS VERY HOT."
               
           END-EVALUATE.

           STOP RUN.
