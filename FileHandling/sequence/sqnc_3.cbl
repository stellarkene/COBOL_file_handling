      * programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TWO-NUM-OPERATION.

       ENVIRONMENT DIVISION.
               INPUT-OUTPUT SECTION.
                   FILE-CONTROL.
               SELECT SQNC3-FILE ASSIGN TO "sqnc_3.dat"
-                  ORGANIZATION IS LINE SEQUENTIAL.
        
           DATA DIVISION.
               FILE SECTION.
               FD SQNC3-FILE.
        
       01  SQNC3_RECORD.
           05  SEQ3_NumberA_FH         PIC ZZZ,ZZZ.99.
           05  SEQ3_OPERATOR           PIC X.
           05  SEQ3_NumberB_FH         PIC ZZZ,ZZZ.99.
           05  SEQ3_SolvedDisplay_FH   PIC ZZZ,ZZZ.99.

       WORKING-STORAGE SECTION.
       01  SEQ3_NumberA                PIC 999999V99.
       01  SEQ3_NumberB                PIC 999999V99.
       01  SEQ3_A_OUT                  PIC ZZZ,ZZZ.99.
       01  SEQ3_B_OUT                  PIC ZZZ,ZZZ.99.
       01  SEQ3_SolvedDisplay          PIC ZZZ,ZZZ.99.
       01  EOF                         PIC X VALUE "N".
       01  SEQ3_HISTORY                PIC X VALUE "N".
       01  SEQ3_OPERATION              PIC X(20).

       PROCEDURE DIVISION.
           DISPLAY "Please input for A: " WITH NO ADVANCING.
           ACCEPT SEQ3_NumberA.
           MOVE SEQ3_NumberA TO SEQ3_A_OUT.

           DISPLAY "Please input for B: " WITH NO ADVANCING.
           ACCEPT SEQ3_NumberB.
           MOVE SEQ3_NumberB TO SEQ3_B_OUT.

           OPEN EXTEND SQNC3-FILE.
           MOVE SEQ3_A_OUT TO SEQ3_NumberA_FH.
           MOVE SEQ3_B_OUT TO SEQ3_NumberB_FH.
           WRITE SQNC3_RECORD.
           CLOSE SQNC3-FILE.

           DISPLAY "ADDITION: ".
           COMPUTE SEQ3_SolvedDisplay = SEQ3_NumberA + SEQ3_NumberB.
           DISPLAY " " SEQ3_A_OUT, " + ", " " SEQ3_B_OUT, " = "  
-          SEQ3_SolvedDisplay.
           MOVE "ADDITION" TO SEQ3_OPERATION.

           PERFORM WRITE-FD.

           DISPLAY "SUBSTRACTION: ".
           COMPUTE SEQ3_SolvedDisplay = SEQ3_NumberA - SEQ3_NumberB.
           DISPLAY " " SEQ3_A_OUT, " - ", " " SEQ3_B_OUT, " = "  
-          SEQ3_SolvedDisplay.
           MOVE "SUBTRACTION" TO SEQ3_OPERATION.

           PERFORM WRITE-FD.

           DISPLAY "MULTIPLICATION: ".
           COMPUTE SEQ3_SolvedDisplay = SEQ3_NumberA * SEQ3_NumberB.
           DISPLAY " " SEQ3_A_OUT, " * ", " " SEQ3_B_OUT, " = "  
-          SEQ3_SolvedDisplay.
           MOVE "MULTIPLICATION" TO SEQ3_OPERATION.

           PERFORM WRITE-FD.

           DISPLAY "DIVISION: ".
           COMPUTE SEQ3_SolvedDisplay = SEQ3_NumberA / SEQ3_NumberB.
           DISPLAY " " SEQ3_A_OUT, " / ", " " SEQ3_B_OUT, " = "  
-          SEQ3_SolvedDisplay.
           MOVE "DIVISION" TO SEQ3_OPERATION.

           PERFORM WRITE-FD.

           DISPLAY "VIEW  HISTORY? (Y): " WITH NO ADVANCING.
           ACCEPT SEQ3_HISTORY.

           IF SEQ3_HISTORY = 'Y' OR SEQ3_HISTORY = 'y'
           MOVE "N" TO EOF

               OPEN INPUT SQNC3-FILE
                   PERFORM UNTIL EOF = "Y"
                   READ SQNC3-FILE
                       AT END 
                           MOVE "Y" TO EOF
        
                       NOT AT END 
                    DISPLAY SEQ3_NumberA_FH SPACE SEQ3_OPERATOR SPACE 
-                SEQ3_NumberB_FH " = " SEQ3_SolvedDisplay_FH
                   
                       END-READ
        
                   END-PERFORM
                   CLOSE SQNC3-FILE
           END-IF.


           STOP RUN.

      *WRITE FUNCTION
       WRITE-FD.
           OPEN EXTEND SQNC3-FILE.
           MOVE SEQ3_SolvedDisplay TO SEQ3_SolvedDisplay_FH.
           EVALUATE TRUE
               WHEN SEQ3_OPERATION = "ADDITION"
                   MOVE "+" TO SEQ3_OPERATOR
               WHEN SEQ3_OPERATION = "SUBTRACTION"
                   MOVE "-" TO SEQ3_OPERATOR
               WHEN SEQ3_OPERATION = "MULTIPLICATION"
                   MOVE "*" TO SEQ3_OPERATOR
               WHEN SEQ3_OPERATION = "DIVISION"
                   MOVE "/" TO SEQ3_OPERATOR
           END-EVALUATE
           WRITE SQNC3_RECORD.
           CLOSE SQNC3-FILE.
           EXIT PARAGRAPH.
