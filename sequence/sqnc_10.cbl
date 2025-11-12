      *Programmer Name: Gabriel Sanchez.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TRIANGLE.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
           
           SELECT SEQ10-FILE ASSIGN TO "sqnc_10.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.


       DATA DIVISION.
       FILE SECTION.
           FD SEQ10-FILE.

       01  SEQ10_RECORD.
           05  SEQ10_T_BASE_FH      PIC ZZZ.
           05  SEQ10_T_HEIGHT_FH    PIC ZZZ.
           05  SEQ10_SIDE_A_FH      PIC ZZZ.
           05  SEQ10_SIDE_B_FH      PIC ZZZ.
           05  SEQ10_SIDE_C_FH      PIC ZZZ.
    
           05  SEQ10_T_AREA_FH      PIC ZZ,ZZZ.99.
           05  SEQ10_T_PERI_FH      PIC ZZ,ZZZ.99.

       WORKING-STORAGE SECTION.
       
       01  SEQ10_T_BASE        PIC 9(3).
       01  SEQ10_T_HEIGHT      PIC 9(3).
       01  SEQ10_SIDE_A        PIC 9(3).
       01  SEQ10_SIDE_B        PIC 9(3).
       01  SEQ10_SIDE_C        PIC 9(3).

       01  SEQ10_T_AREA        PIC ZZ,ZZZ.99.
       01  SEQ10_T_PERI        PIC ZZ,ZZZ.99.
       01  SEQ10_EOF           PIC X VALUE "N".
       01  SEQ10_HISTORY       PIC X VALUE "N".

       PROCEDURE DIVISION.
           DISPLAY "INPUT BASE: " WITH NO ADVANCING.
           ACCEPT SEQ10_T_BASE.

           DISPLAY "INPUT HEIGHT: " WITH NO ADVANCING.
           ACCEPT SEQ10_T_HEIGHT.

           COMPUTE SEQ10_T_AREA = 1/2 * SEQ10_T_BASE * SEQ10_T_HEIGHT.
           DISPLAY "AREA: " SEQ10_T_AREA.

           DISPLAY "INPUT SIDE A: " WITH NO ADVANCING.
           ACCEPT SEQ10_SIDE_A.

           DISPLAY "INPUT SIDE B: " WITH NO ADVANCING.
           ACCEPT SEQ10_SIDE_B.
           
           DISPLAY "INPUT SIDE C: " WITH NO ADVANCING.
           ACCEPT SEQ10_SIDE_C.
           
           COMPUTE SEQ10_T_PERI = 
-              SEQ10_SIDE_A + SEQ10_SIDE_B + SEQ10_SIDE_C.
           DISPLAY "PERIMETER: " SEQ10_T_PERI.
           
           OPEN EXTEND SEQ10-FILE
               MOVE SEQ10_T_BASE TO SEQ10_T_BASE_FH.
               MOVE SEQ10_T_HEIGHT TO SEQ10_T_HEIGHT_FH.
               MOVE SEQ10_SIDE_A TO SEQ10_SIDE_A_FH.
               MOVE SEQ10_SIDE_B TO SEQ10_SIDE_B_FH.
               MOVE SEQ10_SIDE_C TO SEQ10_SIDE_C_FH.
               MOVE SEQ10_T_AREA TO SEQ10_T_AREA_FH.
               MOVE SEQ10_T_PERI TO SEQ10_T_PERI_FH.

               WRITE SEQ10_RECORD.
           CLOSE SEQ10-FILE.

           DISPLAY "VIEW  HISTORY? (Y): " WITH NO ADVANCING.
           ACCEPT SEQ10_HISTORY.

           IF SEQ10_HISTORY = "Y" OR SEQ10_HISTORY = "y"
               MOVE "N" TO SEQ10_EOF
               OPEN INPUT SEQ10-FILE
               
               PERFORM UNTIL SEQ10_EOF = "Y"
               READ SEQ10-FILE
                   AT END
                       DISPLAY "END OF HISTORY"
                       MOVE "Y" TO SEQ10_EOF

                   NOT AT END
                       DISPLAY "==============================="
                       DISPLAY "BASE: " SEQ10_T_BASE_FH
                       DISPLAY "HEIGHT: " SEQ10_T_HEIGHT_FH
                       DISPLAY "SIDE A: " SEQ10_SIDE_A_FH
                       DISPLAY "SIDE B: " SEQ10_SIDE_B_FH
                       DISPLAY "SIDE C: " SEQ10_SIDE_C_FH
                       DISPLAY "AREA: " SEQ10_T_AREA_FH
                       DISPLAY "PERIMETER: " SEQ10_T_PERI_FH
                       DISPLAY "==============================="
                       DISPLAY SPACE

               END-READ
               END-PERFORM

               CLOSE SEQ10-FILE

           END-IF.

           STOP RUN.
