      *programmer name: Gabriel E. Sanchez 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. REVISED-GRADES.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION. 
               FILE-CONTROL.
           SELECT SEL1-FILE ASSIGN TO "sel_1.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.           

       DATA DIVISION.
       FILE SECTION.
           FD SEL1-FILE.

       01  SEL1_RECORD.
           05  SEL1_PRELIM_IN_FH              PIC ZZ9.99.
           05  SEL1_MIDTERMS_IN_FH            PIC ZZ9.99.
           05  SEL1_FINALS_IN_FH              PIC ZZ9.99.
           05  SEL1_COMPUTE_AVE_FH            PIC ZZ9.99.
           05  SEL1_RESULT_FH                 PIC X(6).

       WORKING-STORAGE SECTION.
       01  SEL1_PRELIM_IN              PIC 9(3)V99.
       01  SEL1_MIDTERMS_IN            PIC 9(3)V99.
       01  SEL1_FINALS_IN              PIC 9(3)V99.
       01  SEL1_COMPUTE_AVE            PIC 9(3)V99.
       01  SEL1_AVE_OUT                PIC Z99.99.
       01  SEL1_RESULT                 PIC X(6).
       01  SEL1_EOF                    PIC X VALUE "N".
       01  SEL1_HISTORY                PIC X VALUE "N".

       PROCEDURE DIVISION.
           DISPLAY "PLEASE INPUT PRELIM: " WITH NO ADVANCING.
           ACCEPT SEL1_PRELIM_IN.

           DISPLAY "PLEASE INPUT MIDTERMS: " WITH NO ADVANCING.
           ACCEPT SEL1_MIDTERMS_IN.

           DISPLAY "PLEASE INPUT FINALS: " WITH NO ADVANCING.
           ACCEPT SEL1_FINALS_IN.

           COMPUTE SEL1_COMPUTE_AVE = 
-          (SEL1_PRELIM_IN + SEL1_MIDTERMS_IN + SEL1_FINALS_IN) / 3.
           MOVE SEL1_COMPUTE_AVE TO SEL1_AVE_OUT.

           DISPLAY "AVERAGE IS: " SEL1_AVE_OUT.

           IF SEL1_COMPUTE_AVE >= 75
               MOVE "PASSED" TO SEL1_RESULT
               DISPLAY SEL1_RESULT
           ELSE 
              MOVE "FAILED" TO SEL1_RESULT
              DISPLAY SEL1_RESULT
           END-IF.

           OPEN EXTEND SEL1-FILE.
               MOVE SEL1_PRELIM_IN TO SEL1_PRELIM_IN_FH.
               MOVE SEL1_MIDTERMS_IN TO SEL1_MIDTERMS_IN_FH.
               MOVE SEL1_FINALS_IN TO SEL1_FINALS_IN_FH.
               MOVE SEL1_COMPUTE_AVE TO SEL1_COMPUTE_AVE_FH.
               MOVE SEL1_RESULT TO SEL1_RESULT_FH.

               WRITE SEL1_RECORD.
           CLOSE SEL1-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT SEL1_HISTORY.

           IF SEL1_HISTORY = "Y" OR SEL1_HISTORY = "y"
           MOVE "N" TO SEL1_EOF
               OPEN INPUT SEL1-FILE
               PERFORM UNTIL SEL1_EOF = "Y"
                   READ SEL1-FILE
                       AT END
                           DISPLAY "END OF HISTORY"
                           MOVE "Y" TO SEL1_EOF

                       NOT AT END
                           DISPLAY "==============================="
                           DISPLAY "PRELIM: " SEL1_PRELIM_IN_FH
                           DISPLAY "MIDTERMS: " SEL1_MIDTERMS_IN_FH
                           DISPLAY "FINALS: " SEL1_FINALS_IN_FH
                           DISPLAY "AVERAGE: " SEL1_COMPUTE_AVE_FH
                           DISPLAY "RESULT: " SEL1_RESULT_FH
                           DISPLAY "==============================="
                           DISPLAY SPACE

                   END-READ
               END-PERFORM
               CLOSE SEL1-FILE
           END-IF.
           
           STOP RUN.
