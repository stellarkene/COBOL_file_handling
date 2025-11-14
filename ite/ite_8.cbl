      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FIBONACCI.

         ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           SELECT ITE8-FILE ASSIGN TO "ite_8.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD ITE8-FILE.

       01  ITE8_RECORD.
           05  ITE8_NTH_TERM_FH        PIC Z9.
           05  ITE8_RESULT_FH          PIC X(100).

       WORKING-STORAGE SECTION.
       01  ITE8_FIRST_TERM             PIC 9(3) VALUE 0.
       01  ITE8_SECOND_TERM            PIC 9(3) VALUE 1.
       01  ITE8_NEXT_TERM              PIC 9(3).
       01  ITE8_NT_OUT                 PIC ZZ9.
       01  ITE8_USER_COUNTER           PIC 9(2).
       01  ITE8_STORE_FIBO             PIC X(100).
       01  ITE8_TMP_STRING             PIC X(3).
       01  ITE8_EOF                    PIC X VALUE "N".
       01  ITE8_HISTORY                PIC X VALUE "N".


       PROCEDURE DIVISION.
            

           DISPLAY "PLEASE INPUT A NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE8_USER_COUNTER.
           
           

           EVALUATE TRUE
           WHEN ITE8_USER_COUNTER = 1
               DISPLAY "0"

               OPEN EXTEND ITE8-FILE
               MOVE "0" TO ITE8_STORE_FIBO
               WRITE ITE8_RECORD
               CLOSE ITE8-FILE

               
           WHEN ITE8_USER_COUNTER = 2
               DISPLAY "0 , 1"

               OPEN EXTEND ITE8-FILE
               MOVE "0, 1" TO ITE8_STORE_FIBO
               WRITE ITE8_RECORD
               CLOSE ITE8-FILE

           
           END-EVALUATE.
           
           MOVE SPACES TO ITE8_STORE_FIBO.

           OPEN EXTEND ITE8-FILE.
               

           PERFORM UNTIL ITE8_USER_COUNTER = 0
               MOVE ITE8_FIRST_TERM TO ITE8_NT_OUT
               MOVE ITE8_FIRST_TERM TO ITE8_TMP_STRING

               STRING
                   ITE8_STORE_FIBO     
                   ITE8_TMP_STRING         
                   ", "                

               INTO ITE8_STORE_FIBO
               END-STRING

               
               DISPLAY ITE8_NT_OUT ", " WITH NO ADVANCING
               COMPUTE ITE8_NEXT_TERM = 
-                  ITE8_FIRST_TERM + ITE8_SECOND_TERM
               MOVE ITE8_SECOND_TERM TO ITE8_FIRST_TERM
               MOVE ITE8_NEXT_TERM TO ITE8_SECOND_TERM

               
               SUBTRACT 1 FROM ITE8_USER_COUNTER
           END-PERFORM.
               
               MOVE ITE8_STORE_FIBO TO ITE8_RESULT_FH.
           
               WRITE ITE8_RECORD.
           CLOSE ITE8-FILE.

           DISPLAY ITE8_STORE_FIBO.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT ITE8_HISTORY.

           IF ITE8_HISTORY = "Y" OR ITE8_HISTORY = "y"
               MOVE "N" TO ITE8_EOF
               OPEN INPUT ITE8-FILE
           
               PERFORM UNTIL ITE8_EOF = "Y"
                   READ ITE8-FILE
                       AT END 
                           MOVE "Y" TO ITE8_EOF
                       NOT AT END    
                           DISPLAY "====================="
                           DISPLAY "NTH TERM: " ITE8_NTH_TERM_FH
                           DISPLAY "SEQUENCE: " ITE8_RESULT_FH
                           DISPLAY "====================="
                           DISPLAY SPACE
                   END-READ
               END-PERFORM
           
               CLOSE ITE8-FILE
               DISPLAY "END OF VIEW"
           END-IF.
           

           STOP RUN.
