      *Programmer name: Gabriel Sanchez 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COMPUTE-AVERAGE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  SEQ6_Prelim     PIC 9(3).
       01  SEQ6_Midterm    PIC 9(3).
       01  SEQ6_Finals     PIC 9(3).
       01  SEQ6_Average    PIC Z99.99.

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


           STOP RUN.
