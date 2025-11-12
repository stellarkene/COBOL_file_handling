      *Programmer name: Gabriel Sanchez 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COMPUTE-AVERAGE.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.

           SELECT SQNC6-FILE ASSIGN TO "sqnc_6.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.
               

       DATA DIVISION.
       FILE SECTION.
           FD SQNC6-FILE.

       01  SQNC6_RECORD.
           05  SEQ6_PRELIM_FH     PIC ZZ9.99.
           05  SEQ6_MIDTERM_FH    PIC ZZ9.99.
           05  SEQ6_FINALS_FH     PIC ZZ9.99.
           05  SEQ6_AVERAGE_FH    PIC ZZ9.99.

       WORKING-STORAGE SECTION.
       01  SEQ6_Prelim     PIC 9(3).
       01  SEQ6_Midterm    PIC 9(3).
       01  SEQ6_Finals     PIC 9(3).
       01  SEQ6_Average    PIC Z99.99.
       01  SEQ6_EOF        PIC X VALUE "N".
       01  SEQ6_HISTORY    PIC X VALUE "N".

       PROCEDURE DIVISION.
           DISPLAY "PLEASE ENTER PRELIM: " WITH NO ADVANCING.
           ACCEPT SEQ6_Prelim.

           DISPLAY "PLEASE ENTER MIDTERM: " WITH NO ADVANCING.
           ACCEPT SEQ6_Midterm.

           DISPLAY "PLEASE ENTER FINALS: " WITH NO ADVANCING.
           ACCEPT SEQ6_Finals.

           COMPUTE SEQ6_Average = 
-              (SEQ6_Prelim + SEQ6_Midterm + SEQ6_Finals) / 3.
           DISPLAY "AVERAGE: " SEQ6_Average.

           OPEN EXTEND SQNC6-FILE.
               MOVE SEQ6_Prelim TO SEQ6_PRELIM_FH.
               MOVE SEQ6_Midterm TO SEQ6_MIDTERM_FH
               MOVE SEQ6_Finals TO SEQ6_FINALS_FH.
               MOVE SEQ6_Average TO SEQ6_AVERAGE_FH.

               WRITE SQNC6_RECORD.
           CLOSE SQNC6-FILE.

           DISPLAY "VIEW  HISTORY? (Y): " WITH NO ADVANCING.
           ACCEPT SEQ6_HISTORY.

           IF SEQ6_HISTORY = "Y" OR SEQ6_HISTORY = "y"
               MOVE "N" TO SEQ6_EOF
               OPEN INPUT SQNC6-FILE  

               PERFORM UNTIL SEQ6_EOF = "Y"
                   READ SQNC6-FILE
                       AT END
                           DISPLAY "END OF HISTORY"
                           MOVE "Y" TO SEQ6_EOF

                       NOT AT END
                           DISPLAY "==============================="
                           DISPLAY "PRELIM: " SEQ6_PRELIM_FH
                           DISPLAY "MIDTERMS: " SEQ6_MIDTERM_FH
                           DISPLAY "FINALS: " SEQ6_FINALS_FH
                           DISPLAY "AVERAGE: " SEQ6_AVERAGE_FH
                           DISPLAY "==============================="
                           DISPLAY SPACE
                   END-READ
               END-PERFORM

           CLOSE SQNC6-FILE
           END-IF.


           STOP RUN.
