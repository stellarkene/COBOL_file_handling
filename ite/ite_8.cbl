      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FIBONACCI.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  ITE8_FIRST_TERM              PIC 9(3) VALUE 0.
       01  ITE8_SECOND_TERM             PIC 9(3) VALUE 1.
       01  ITE8_NEXT_TERM               PIC 9(3).
       01  ITE8_NT_OUT                  PIC ZZ9.
       01  ITE8_USER_COUNTER            PIC 9(2).


       PROCEDURE DIVISION.
           DISPLAY "PLEASE INPUT A NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE8_USER_COUNTER.

           EVALUATE TRUE
           WHEN ITE8_USER_COUNTER = 1
               DISPLAY "0"
               STOP RUN
           WHEN ITE8_USER_COUNTER = 2
               DISPLAY "0 , 1"
               STOP RUN
           END-EVALUATE.

           PERFORM UNTIL ITE8_USER_COUNTER = 0
               MOVE ITE8_FIRST_TERM TO ITE8_NT_OUT
               DISPLAY ITE8_NT_OUT ", " WITH NO ADVANCING
               COMPUTE ITE8_NEXT_TERM = 
-                  ITE8_FIRST_TERM + ITE8_SECOND_TERM
               MOVE ITE8_SECOND_TERM TO ITE8_FIRST_TERM
               MOVE ITE8_NEXT_TERM TO ITE8_SECOND_TERM
               
               SUBTRACT 1 FROM ITE8_USER_COUNTER
           END-PERFORM.
           

           STOP RUN.
