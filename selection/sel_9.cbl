      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY_NUMBER.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION. 
               FILE-CONTROL.
           SELECT SEL9-FILE ASSIGN TO "sel_9.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD SEL9-FILE.

       01  SEL9_RECORD.
           05  SEL9_NUM_FH         PIC Z9.
           05  SEL9_DAY_FH         PIC X(10).

       WORKING-STORAGE SECTION.
       01  SEL9_USER_NUM           PIC 9(2).
       01  SEL9_EOF                PIC X VALUE "N".
       01  SEL9_HISTORY            PIC X VALUE "N".

       PROCEDURE DIVISION.
           OPEN EXTEND SEL9-FILE.

           DISPLAY "PLEASE INPUT A NUMBER(1-7): " WITH NO ADVANCING.
           ACCEPT SEL9_USER_NUM.

           MOVE SEL9_USER_NUM TO SEL9_NUM_FH.

           EVALUATE TRUE
           WHEN SEL9_USER_NUM = 1
               DISPLAY "ITS MONDAY!"
               MOVE "MONDAY!" TO SEL9_DAY_FH
               
           WHEN SEL9_USER_NUM = 2
               DISPLAY "ITS TUESDAY!"
               MOVE "TUESDAY!" TO SEL9_DAY_FH

           WHEN SEL9_USER_NUM = 3
               DISPLAY "ITS WEDNESDAY!"
               MOVE "WEDNESDAY!" TO SEL9_DAY_FH

           WHEN SEL9_USER_NUM = 4
               DISPLAY "ITS THURSDAY!"
               MOVE "THURSDAY!" TO SEL9_DAY_FH

           WHEN SEL9_USER_NUM = 5
               DISPLAY "ITS FRIDAY!"
               MOVE "FRIDAY!" TO SEL9_DAY_FH

           WHEN SEL9_USER_NUM = 6
               DISPLAY "ITS SATURDAY!"
               MOVE "SATURDAY!" TO SEL9_DAY_FH

           WHEN SEL9_USER_NUM = 7
               DISPLAY "ITS SUNDAY!"
               MOVE "SUNDAY!" TO SEL9_DAY_FH

           WHEN OTHER 
               DISPLAY "INVALID INPUT"
               MOVE "ERR!" TO SEL9_DAY_FH

           END-EVALUATE.

               WRITE SEL9_RECORD.
           CLOSE SEL9-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT SEL9_HISTORY.

           IF SEL9_HISTORY = "Y" OR SEL9_HISTORY = "y"
           MOVE "N" TO SEL9_EOF
               OPEN INPUT SEL9-FILE
               PERFORM UNTIL SEL9_EOF = "Y"
                   READ SEL9-FILE
                       AT END
                           DISPLAY "END OF HISTORY"
                           MOVE "Y" TO SEL9_EOF

                       NOT AT END
                       DISPLAY "==============================="
                       DISPLAY "NUMBER: " SEL9_NUM_FH
                       DISPLAY SEL9_DAY_FH 
                       DISPLAY "==============================="
                       DISPLAY SPACE

                   END-READ
               END-PERFORM
               CLOSE SEL9-FILE
           END-IF. 
           STOP RUN.
