      *programmer name: Gabriel Sanchez 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. REVISED_GRADES.

         ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION. 
               FILE-CONTROL.
           SELECT SEL6-FILE ASSIGN TO "sel_6.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD SEL6-FILE.

       01  SEL6_RECORD.
           05  SEL6_PRELIM_FH              PIC ZZ9.99.
           05  SEL6_MIDTERMS_FH            PIC ZZ9.99.
           05  SEL6_FINALS_FH              PIC ZZ9.99.
           05  SEL6_AVE_OUT_FH             PIC ZZ9.99.
           05  SEL6_RESULT_N               PIC X(3).
           05  SEL6_PASSED_CHECK           PIC X(7).                 

       
       WORKING-STORAGE SECTION.
       01  SEL6_PRELIM_IN              PIC 9(3)V99.
       
       01  SEL6_MIDTERMS_IN            PIC 9(3)V99.
       
       01  SEL6_FINALS_IN              PIC 9(3)V99.
       
       01  SEL6_CALC_AVE               PIC 9(3)V99.
       01  SEL6_AVE_OUT                PIC Z(3).99.
       01  SEL6_EOF                    PIC X VALUE "N".
       01  SEL6_HISTORY                PIC X VALUE "N".

       PROCEDURE DIVISION.

           OPEN EXTEND SEL6-FILE.
           DISPLAY "PLEASE INPUT PRELIM: " WITH NO ADVANCING.
           ACCEPT SEL6_PRELIM_IN.

           DISPLAY "PLEASE INPUT MIDTERMS: " WITH NO ADVANCING.
           ACCEPT SEL6_MIDTERMS_IN.

           DISPLAY "PLEASE INPUT FINALS: " WITH NO ADVANCING.
           ACCEPT SEL6_FINALS_IN.

           COMPUTE SEL6_CALC_AVE = 
-              (SEL6_PRELIM_IN + SEL6_MIDTERMS_IN + SEL6_FINALS_IN) / 3.
           MOVE SEL6_CALC_AVE TO SEL6_AVE_OUT.
               
               MOVE SEL6_PRELIM_IN TO SEL6_PRELIM_FH.
               MOVE SEL6_MIDTERMS_IN TO SEL6_MIDTERMS_FH.
               MOVE SEL6_FINALS_IN TO SEL6_FINALS_FH.
               MOVE SEL6_AVE_OUT TO SEL6_AVE_OUT_FH.

           DISPLAY "AVERAGE GRADE: " SEL6_AVE_OUT.
           
           EVALUATE TRUE
           WHEN SEL6_CALC_AVE > 100 
               DISPLAY "GRADE EXCEEDED LIMIT."
               MOVE "ERR" TO SEL6_RESULT_N
               MOVE "ERR" TO SEL6_PASSED_CHECK

           WHEN SEL6_CALC_AVE >= 97 AND SEL6_CALC_AVE <= 100
               DISPLAY "EQUIVALENT GRADE: 1.00"
               MOVE "1.00" TO SEL6_RESULT_N
               MOVE "PASSED" TO SEL6_PASSED_CHECK

           WHEN SEL6_CALC_AVE >= 94 AND SEL6_CALC_AVE <= 96
               DISPLAY "EQUIVALNET GRADE: 1.25"
               MOVE "1.25" TO SEL6_RESULT_N
               MOVE "PASSED" TO SEL6_PASSED_CHECK

           WHEN SEL6_CALC_AVE >= 91 AND SEL6_CALC_AVE <= 93
               DISPLAY "EQUIVALENT GRADE: 1.5"
               MOVE "1.50" TO SEL6_RESULT_N
               MOVE "PASSED" TO SEL6_PASSED_CHECK

           WHEN SEL6_CALC_AVE >= 88 AND SEL6_CALC_AVE <= 90
               DISPLAY "EQUIVALENT GRADE: 1.75"
               MOVE "1.75" TO SEL6_RESULT_N
               MOVE "PASSED" TO SEL6_PASSED_CHECK

           WHEN SEL6_CALC_AVE >= 85 AND  SEL6_CALC_AVE <= 87
               DISPLAY "EQUIVALENT GRADE: 2.00"
               MOVE "2.00" TO SEL6_RESULT_N
               MOVE "PASSED" TO SEL6_PASSED_CHECK

           WHEN SEL6_CALC_AVE >= 82 AND SEL6_CALC_AVE <= 84
               DISPLAY "EQUIVALENT GRADE: 2.25"
               MOVE "2.25" TO SEL6_RESULT_N
               MOVE "PASSED" TO SEL6_PASSED_CHECK

           WHEN SEL6_CALC_AVE >= 79 AND SEL6_CALC_AVE <= 81
               DISPLAY "EQUIVALENT GRADE: 2.5"
               MOVE "2.50" TO SEL6_RESULT_N
               MOVE "PASSED" TO SEL6_PASSED_CHECK

           WHEN SEL6_CALC_AVE >= 76 AND SEL6_CALC_AVE <= 78
               DISPLAY "EQUIVALENT GRADE: 2.75"
               MOVE "2.75" TO SEL6_RESULT_N
               MOVE "PASSED" TO SEL6_PASSED_CHECK 

           WHEN SEL6_CALC_AVE = 75
               DISPLAY "EQUIVALENT GRADE: 3.00"
               MOVE "3.00" TO SEL6_RESULT_N
               MOVE "PASSED" TO SEL6_PASSED_CHECK

           WHEN OTHER 
               DISPLAY "EQUIVALENT GRADE: 5.00"
               MOVE "5.00" TO SEL6_RESULT_N
               MOVE "FAILED" TO SEL6_PASSED_CHECK
               
           END-EVALUATE.

               WRITE SEL6_RECORD.
           CLOSE SEL6-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT SEL6_HISTORY.

           IF SEL6_HISTORY = "Y" OR SEL6_HISTORY = "y"
           MOVE "N" TO SEL6_EOF
               OPEN INPUT SEL6-FILE
               PERFORM UNTIL SEL6_EOF = "Y"
                   READ SEL6-FILE
                       AT END
                           DISPLAY "END OF HISTORY"
                           MOVE "Y" TO SEL6_EOF

                       NOT AT END
                           DISPLAY "==============================="
                           DISPLAY "PRELIM: " SEL6_PRELIM_FH
                           DISPLAY "MIDTERMS: " SEL6_MIDTERMS_FH
                           DISPLAY "FINALS: " SEL6_FINALS_FH
                           DISPLAY "AVERAGE: " SEL6_AVE_OUT_FH
                           DISPLAY "RESULT: " SEL6_RESULT_N SPACE
                           DISPLAY SEL6_PASSED_CHECK
                           DISPLAY "==============================="
                           DISPLAY SPACE

                   END-READ
               END-PERFORM
               CLOSE SEL6-FILE
           END-IF.            
           
           STOP RUN.
