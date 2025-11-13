      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEMPARATURE-INFO.

          ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION. 
               FILE-CONTROL.
           SELECT SEL7-FILE ASSIGN TO "sel_7.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD SEL7-FILE.

       01  SEL7_RECORD.
           05  SEL7_TEMP_FH                PIC +ZZ,ZZ9.99.
           05  SEL7_RESULT                 PIC X(20). 
           

       WORKING-STORAGE SECTION.
       01  SEL7_USER_TEMP_IN           PIC S9(5)V99.
       01  SEL7_EOF                    PIC X VALUE "N".
       01  SEL7_HISTORY                PIC X VALUE "N".                    
       

       PROCEDURE DIVISION.
           OPEN EXTEND SEL7-FILE.
           
           DISPLAY "PLEASE ENTER YOUR TEMPERATURE: " WITH NO ADVANCING.
           ACCEPT SEL7_USER_TEMP_IN.
               
               MOVE SEL7_USER_TEMP_IN TO SEL7_TEMP_FH.
           
           EVALUATE TRUE
           WHEN  SEL7_USER_TEMP_IN < 0
               DISPLAY "FREEZING WEATHER."
               MOVE "FREEZING WEATHER." TO SEL7_RESULT

           WHEN SEL7_USER_TEMP_IN >= 0 AND SEL7_USER_TEMP_IN <= 10
               DISPLAY "VERY COLD WEATHER."
               MOVE "VERY COLD WEATHER." TO SEL7_RESULT

           WHEN SEL7_USER_TEMP_IN >= 11 AND SEL7_USER_TEMP_IN <= 20
               DISPLAY "COLD WEATHER."
               MOVE "COLD WEATHER." TO SEL7_RESULT

           WHEN SEL7_USER_TEMP_IN >= 21 AND SEL7_USER_TEMP_IN <= 30
               DISPLAY "NORMAL TEMPERATURE."
               MOVE "NORMAL TEMPERATURE." TO SEL7_RESULT 

           WHEN SEL7_USER_TEMP_IN >= 31 AND SEL7_USER_TEMP_IN <= 40
               DISPLAY "ITS HOT."
               MOVE "ITS HOT." TO SEL7_RESULT

           WHEN OTHER
               DISPLAY "ITS VERY HOT."
               MOVE "ITS VERY HOT." TO SEL7_RESULT
               
           END-EVALUATE.

               WRITE SEL7_RECORD.
           CLOSE SEL7-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT SEL7_HISTORY.

           IF SEL7_HISTORY = "Y" OR SEL7_HISTORY = "y"
           MOVE "N" TO SEL7_EOF
               OPEN INPUT SEL7-FILE
               PERFORM UNTIL SEL7_EOF = "Y"
                   READ SEL7-FILE
                       AT END
                           DISPLAY "END OF HISTORY"
                           MOVE "Y" TO SEL7_EOF

                       NOT AT END
                           DISPLAY "==============================="
                           DISPLAY "TEMPERATURE: " SEL7_TEMP_FH
                           DISPLAY SEL7_RESULT
                           DISPLAY "==============================="
                           DISPLAY SPACE

                   END-READ
               END-PERFORM
               CLOSE SEL7-FILE
           END-IF.            

           STOP RUN.
