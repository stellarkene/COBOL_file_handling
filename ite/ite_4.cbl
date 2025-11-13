      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. NUMBERS_FROM_N_TO_N.

        ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           SELECT ITE4-FILE ASSIGN TO "ite_4.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD ITE4-FILE.

       01  ITE4_RECORD.
           05 ITE4_START_NUM_FH            PIC ZZZ.
           05 ITE4_EVEN_NUM_FH             PIC ZZZ.
           05 ITE4_END_NUM_FH              PIC ZZZ.
           05 ITE4_END_BLOCK_FH            PIC X.         
       WORKING-STORAGE SECTION.
       01  ITE4_USER_INPUT_N           PIC 9(3).
       01  ITE4_USER_INPUT_M           PIC 9(3).
       01  ITE4_COUNTER                PIC 9(3).
       01  ITE4_STORE_OUTPUT           PIC Z(3).
       01  ITE4_EOF                    PIC X VALUE "N".
       01  ITE4_HISTORY                PIC X VALUE "N".

       PROCEDURE DIVISION.
           OPEN EXTEND ITE4-FILE.

           MOVE 0 TO ITE4_COUNTER.
           DISPLAY "PLEASE ENTER A NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE4_USER_INPUT_N.

           DISPLAY "PLEASE ENTER ANOTHER NUMBER: " WITH NO ADVANCING.
           ACCEPT ITE4_USER_INPUT_M.

               MOVE ITE4_USER_INPUT_N TO ITE4_START_NUM_FH.
               MOVE ITE4_USER_INPUT_M TO ITE4_END_NUM_FH.
               WRITE ITE4_RECORD.

           MOVE ITE4_USER_INPUT_N TO ITE4_COUNTER.

           PERFORM UNTIL ITE4_COUNTER > ITE4_USER_INPUT_M

               IF FUNCTION MOD(ITE4_COUNTER, 2) = 0
                   MOVE ITE4_COUNTER TO ITE4_STORE_OUTPUT
                   DISPLAY ITE4_STORE_OUTPUT
                   MOVE ITE4_COUNTER TO ITE4_EVEN_NUM_FH
                   WRITE ITE4_RECORD
               END-IF
               
               ADD 1 TO ITE4_COUNTER
           END-PERFORM.

               MOVE "*" TO ITE4_END_BLOCK_FH.
               WRITE ITE4_RECORD.

           CLOSE ITE4-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT ITE4_HISTORY.

           IF ITE4_HISTORY = "Y" OR ITE4_HISTORY = "y"
               MOVE "N" TO ITE4_EOF
               OPEN INPUT ITE4-FILE
           
               DISPLAY "====================="
               PERFORM UNTIL ITE4_EOF = "Y"
                   READ ITE4-FILE
                       AT END 
                           MOVE "Y" TO ITE4_EOF
                       NOT AT END    
                           IF ITE4_END_BLOCK_FH = "*"
                               DISPLAY "STARTED AT: " ITE4_START_NUM_FH
                               DISPLAY "UP TO: " ITE4_END_NUM_FH
                               DISPLAY "====================="
                               DISPLAY SPACE
                               DISPLAY "====================="
                           ELSE
                               DISPLAY ITE4_EVEN_NUM_FH
                           END-IF
                   END-READ
               END-PERFORM
           
               CLOSE ITE4-FILE
               DISPLAY "END OF VIEW"
           END-IF.

           STOP RUN.
