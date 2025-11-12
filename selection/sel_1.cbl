      *programmer name: Gabriel E. Sanchez 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. REVISED-GRADES.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  SEL1_PRELIM_IN              PIC 9(3)V99.
       01  SEL1_MIDTERMS_IN            PIC 9(3)V99.
       01  SEL1_FINALS_IN              PIC 9(3)V99.
       01  SEL1_COMPUTE_AVE            PIC 9(3)V99.
       01  SEL1_AVE_OUT                PIC Z99.99.
       01  SEL1_RESULT                 PIC X(6).

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
           
           STOP RUN.
