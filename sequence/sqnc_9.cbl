      *Programmer Name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. AREA-CIRCUM-CIRCLE.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           SELECT SEQ9-FILE ASSIGN TO "sqnc_9.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.
       

       DATA DIVISION.
       FILE SECTION.
           FD SEQ9-FILE.

       01  SEQ9_RECORD.
           05  SEQ9_DIAMETER_FH        PIC Z9.99.
           05  SEQ9_CIR_AREA_FH        PIC ZZZ,ZZ9.99.
           05  SEQ9_CIRCUMEFERENCE_FH  PIC ZZZ,ZZ9.99.

       WORKING-STORAGE SECTION.
       01  SEQ9_PI                 PIC 9(1)V99 VALUE 3.14.
       01  SEQ9_DIAMETER           PIC 9(2).
       01  SEQ9_RADIUS             PIC 9(4)V99.
       01  SEQ9_CIR_AREA           PIC ZZZ,ZZ9.99.
       01  SEQ9_CIRCUMEFERENCE     PIC ZZZ,ZZ9.99.
       01  SEQ9_EOF                PIC X VALUE "N".
       01  SEQ9_HISTORY            PIC X VALUE "N".


       PROCEDURE DIVISION.
           DISPLAY "PLEASE INPUT DIAMETER: " WITH NO ADVANCING.
           ACCEPT SEQ9_DIAMETER.

           COMPUTE SEQ9_RADIUS = SEQ9_DIAMETER / 2.
           COMPUTE SEQ9_CIR_AREA = SEQ9_PI * SEQ9_RADIUS * SEQ9_RADIUS.
           DISPLAY "AREA: " SEQ9_CIR_AREA.

           COMPUTE SEQ9_CIRCUMEFERENCE = 2 * SEQ9_PI * SEQ9_RADIUS.
           DISPLAY "CIRCUMFERENCE: " SEQ9_CIRCUMEFERENCE.
           
           OPEN EXTEND SEQ9-FILE
               MOVE SEQ9_DIAMETER TO SEQ9_DIAMETER_FH.
               MOVE SEQ9_CIR_AREA TO SEQ9_CIR_AREA_FH.
               MOVE SEQ9_CIRCUMEFERENCE TO SEQ9_CIRCUMEFERENCE_FH.

               WRITE SEQ9_RECORD.

           CLOSE SEQ9-FILE.

           DISPLAY "VIEW  HISTORY? (Y): " WITH NO ADVANCING.
           ACCEPT SEQ9_HISTORY.

           IF SEQ9_HISTORY = "Y" OR SEQ9_HISTORY = "y"
               MOVE "N" TO SEQ9_EOF
               OPEN INPUT SEQ9-FILE
               
               PERFORM UNTIL SEQ9_EOF = "Y"
               READ SEQ9-FILE
                   AT END
                       DISPLAY "END OF HISTORY"
                       MOVE "Y" TO SEQ9_EOF

                   NOT AT END
                       DISPLAY "==============================="
                       DISPLAY "DIAMETER: " SEQ9_DIAMETER_FH
                       DISPLAY "AREA: " SEQ9_CIR_AREA_FH
                       DISPLAY "CIRCUMFERENCE: " SEQ9_CIRCUMEFERENCE_FH
                       DISPLAY "==============================="
                       DISPLAY SPACE

               END-READ
               END-PERFORM

               CLOSE SEQ9-FILE

           END-IF.

           STOP RUN.
