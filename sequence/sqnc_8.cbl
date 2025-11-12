      *Programmer name: Gabriel Sanchez 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. RECTANGLE.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.

           SELECT SQNC8-FILE ASSIGN TO "sqnc_8.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD SQNC8-FILE.

       01  SEQ8_RECORD.
           05  SEQ8_RECT_WIDTH_FH          PIC ZZ9.99.
           05  SEQ8_RECT_LENGTH_FH         PIC ZZ9.99.
           05  SEQ8_RECT_AREA_FH           PIC ZZZ,ZZ9.99.
           05  SEQ8_RECT_PERIMETER_FH      PIC ZZZ,ZZ9.99.

       WORKING-STORAGE SECTION.
       01  SEQ8_RECT_WIDTH     PIC 9(3).
       01  SEQ8_RECT_LENGTH    PIC 9(3).
       01  SEQ8_RECT_AREA      PIC ZZZ,ZZ9.99.
       01  SEQ8_RECT_PERIMETER PIC ZZZ,ZZ9.99.
       01  SEQ8_EOF            PIC X VALUE "N".
       01  SEQ8_HISTORY        PIC X VALUE "N".


       PROCEDURE DIVISION.
           DISPLAY "PLEASE INPUT WIDTH: " WITH NO ADVANCING.
           ACCEPT SEQ8_RECT_WIDTH.

           DISPLAY "PLEASE INPUT LENGTH: " WITH NO ADVANCING.
           ACCEPT SEQ8_RECT_LENGTH.

           COMPUTE SEQ8_RECT_AREA = SEQ8_RECT_WIDTH * SEQ8_RECT_LENGTH.
           DISPLAY "AREA: " SEQ8_RECT_AREA.

           COMPUTE SEQ8_RECT_PERIMETER = 
-          2 * (SEQ8_RECT_WIDTH + SEQ8_RECT_LENGTH).
           DISPLAY "PERIMETER: " SEQ8_RECT_PERIMETER.

           OPEN EXTEND SQNC8-FILE.
               MOVE SEQ8_RECT_WIDTH TO SEQ8_RECT_WIDTH_FH.
               MOVE SEQ8_RECT_LENGTH TO SEQ8_RECT_LENGTH_FH.
               MOVE SEQ8_RECT_AREA TO SEQ8_RECT_AREA_FH.
               MOVE SEQ8_RECT_PERIMETER TO SEQ8_RECT_PERIMETER_FH

               WRITE SEQ8_RECORD.
           CLOSE SQNC8-FILE.

           DISPLAY "VIEW  HISTORY? (Y): " WITH NO ADVANCING.
           ACCEPT SEQ8_HISTORY.

           IF SEQ8_HISTORY = "Y" OR SEQ8_HISTORY = "y"
               MOVE "N" TO SEQ8_EOF
               OPEN INPUT SQNC8-FILE
               
               PERFORM UNTIL SEQ8_EOF = "Y"
               READ SQNC8-FILE
                   AT END
                       DISPLAY "END OF HISTORY"
                       MOVE "Y" TO SEQ8_EOF

                   NOT AT END
                       DISPLAY "==============================="
                       DISPLAY "WIDTH: " SEQ8_RECT_WIDTH_FH
                       DISPLAY "LENGTH: " SEQ8_RECT_LENGTH_FH
                       DISPLAY "AREA: " SEQ8_RECT_AREA_FH
                       DISPLAY "PERIMETER: " SEQ8_RECT_PERIMETER_FH
                       DISPLAY "==============================="
                       DISPLAY SPACE

               END-READ
               END-PERFORM

               CLOSE SQNC8-FILE

           END-IF.
           
           STOP RUN.
