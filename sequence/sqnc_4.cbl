      *programmer name: Gabriel Sanchez 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CEL-FAHRENHEIT.

       ENVIRONMENT DIVISION.
               INPUT-OUTPUT SECTION.
                   FILE-CONTROL.
       SELECT SQNC4-FILE ASSIGN TO "sqnc_4.dat"
-                  ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
           FILE SECTION.
               FD SQNC4-FILE.

       01  SQNC4_RECORD.
           05  SEQ4_CELCIUS_FH        PIC +ZZ,ZZ9.99.
           05  SEQ4_FAHRENHEIT_FH     PIC +ZZ,ZZ9.99. 
           
           WORKING-STORAGE SECTION.
       01  SEQ4_CELCIUS        PIC S9(5)v99.
       01  SEQ4_FAHRENHEIT     PIC S9(5)v99.
       01  SEQ4_F_OUT          PIC ZZ,ZZZ.99.
       01  SEQ4_HISTORY        PIC X VALUE "N".
       01  SEQ4_EOF            PIC X VALUE "N".


       PROCEDURE DIVISION.
           

           DISPLAY "PLEASE INPUT SEQ4_CELCIUS: " WITH NO ADVANCING.
           ACCEPT SEQ4_CELCIUS.

           COMPUTE SEQ4_FAHRENHEIT = (SEQ4_CELCIUS * 9 / 5) + 32.
           MOVE SEQ4_FAHRENHEIT TO SEQ4_F_OUT.

           
           OPEN EXTEND SQNC4-FILE.
               MOVE SEQ4_CELCIUS TO SEQ4_CELCIUS_FH.
               MOVE SEQ4_FAHRENHEIT TO SEQ4_FAHRENHEIT_FH.
               WRITE SQNC4_RECORD.

           CLOSE SQNC4-FILE.

           DISPLAY "CONVERTED TO SEQ4_FAHRENHEIT: " SEQ4_F_OUT.

           DISPLAY "VIEW  HISTORY? (Y): " WITH NO ADVANCING.
           ACCEPT SEQ4_HISTORY.

           IF SEQ4_HISTORY = "Y" OR SEQ4_HISTORY = "y"
               MOVE "N" TO SEQ4_EOF

               OPEN INPUT SQNC4-FILE
                   PERFORM UNTIL SEQ4_EOF = "Y"
                       READ SQNC4-FILE
                           AT END
                               DISPLAY "END OF HISTORY"
                               MOVE "Y" TO SEQ4_EOF
                           NOT AT END
                               DISPLAY SEQ4_CELCIUS_FH "C = " 
-                                  SEQ4_FAHRENHEIT_FH "F"
                       END-READ
                   END-PERFORM
               CLOSE SQNC4-FILE
           END-IF.
           STOP RUN.

      *check .dat existance
       