      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY_NUMBER.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  SEL9_USER_NUM            PIC 9(1).

       PROCEDURE DIVISION.
           DISPLAY "PLEASE INPUT A NUMBER(1-7): " WITH NO ADVANCING.
           ACCEPT SEL9_USER_NUM.

           EVALUATE TRUE
           WHEN SEL9_USER_NUM = 1
               DISPLAY "ITS MONDAY!"
               
           WHEN SEL9_USER_NUM = 2
               DISPLAY "ITS TUESDAY!"

           WHEN SEL9_USER_NUM = 3
               DISPLAY "ITS WEDNESDAY"

           WHEN SEL9_USER_NUM = 4
               DISPLAY "ITS THURSDAY!"

           WHEN SEL9_USER_NUM = 5
               DISPLAY "ITS FRIDAY!"

           WHEN SEL9_USER_NUM = 6
               DISPLAY "ITS SATURDAY!"

           WHEN SEL9_USER_NUM = 7
               DISPLAY "ITS SUNDAY!"

           WHEN OTHER 
               DISPLAY "INVALID INPUT"

           END-EVALUATE.
           STOP RUN.
