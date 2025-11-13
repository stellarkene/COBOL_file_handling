      *programmer name: Gabriel Sanchez 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. REVISED-SALESMAN-INFO.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION. 
               FILE-CONTROL.
           SELECT SEL8-FILE ASSIGN TO "sel_8.dat"
-              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD SEL8-FILE.

       01  SEL8_RECORD.
           05  SEL8_SM_NUM_FH                    PIC X(12).
           05  SEL8_SM_NAME_FH                   PIC X(25).
           05  SEL8_UNIT_SOLD_FH                 PIC ZZ,ZZ9.99.
           05  SEL8_UNIT_PRICE_FH                PIC ZZ,ZZ9.99.
           05  SEL8_SALES_OUT_FH                 PIC Z,ZZZ,ZZZ,ZZZ.99.
           05  SEL8_COMMISSION_PERCENT_FH        PIC X(3).
           05  SEL8_COMMISSION_OUT_FH            PIC Z,ZZZ,ZZZ,ZZZ.99.

       WORKING-STORAGE SECTION.
       01  SEL8_SM_NUM                 PIC 9(12).
       01  SEL8_SM_NAME                PIC X(25).
       01  SEL8_UNIT_SOLD              PIC 9(5)V99.
       01  SEL8_UNIT_PRICE             PIC 9(5)V99.
       01  SEL8_SOLVE_SALES            PIC 9(10)V99.
       01  SEL8_SALES_OUT              PIC Z,ZZZ,ZZZ,ZZZ.99.
       01  SEL8_SOLVE_COMMISSION       PIC 9(10)V99.
       01  SEL8_COMMISSION_OUT         PIC Z,ZZZ,ZZZ,ZZZ.99.
       01  SEL8_EOF                    PIC X VALUE "N".
       01  SEL8_HISTORY                PIC X VALUE "N".
      

       PROCEDURE DIVISION.
           OPEN EXTEND SEL8-FILE.

           DISPLAY "PLEASE ENTER NUMBER: " WITH NO ADVANCING.
           ACCEPT SEL8_SM_NUM.

           DISPLAY "PLEASE ENTER NAME: " WITH NO ADVANCING.
           ACCEPT SEL8_SM_NAME.

           DISPLAY "PLEASE ENTER UNITS SOLD: " WITH NO ADVANCING.
           ACCEPT SEL8_UNIT_SOLD.

           DISPLAY "PLEASE ENTER UNIT PRICE: " WITH NO ADVANCING.
           ACCEPT  SEL8_UNIT_PRICE.

           COMPUTE SEL8_SOLVE_SALES = SEL8_UNIT_SOLD * SEL8_UNIT_PRICE.
           MOVE SEL8_SOLVE_SALES TO SEL8_SALES_OUT.
           DISPLAY "TOTAL SALES: " SEL8_SALES_OUT.
               
               MOVE SEL8_SM_NUM TO SEL8_SM_NUM_FH.
               MOVE SEL8_SM_NAME TO SEL8_SM_NAME_FH.
               MOVE SEL8_UNIT_SOLD TO SEL8_UNIT_SOLD_FH.
               MOVE SEL8_UNIT_PRICE TO SEL8_UNIT_PRICE_FH.
               MOVE SEL8_SALES_OUT TO SEL8_SALES_OUT_FH.
           
           EVALUATE TRUE
           WHEN SEL8_SOLVE_SALES <= 15000
               COMPUTE SEL8_SOLVE_COMMISSION = SEL8_SOLVE_SALES * .15
               MOVE SEL8_SOLVE_COMMISSION TO SEL8_COMMISSION_OUT
               DISPLAY "WITH 15% COMMISSION AMOUNTING TO: " 
-                  SEL8_COMMISSION_OUT
               MOVE "15%" TO SEL8_COMMISSION_PERCENT_FH
               MOVE SEL8_COMMISSION_OUT TO SEL8_COMMISSION_OUT_FH

           WHEN SEL8_SOLVE_SALES <= 20000
               COMPUTE SEL8_SOLVE_COMMISSION = SEL8_SOLVE_SALES * .20
               MOVE SEL8_SOLVE_COMMISSION TO SEL8_COMMISSION_OUT
               DISPLAY "WITH 20% COMMISSION AMOUNTING TO: " 
-                  SEL8_COMMISSION_OUT
               MOVE "20%" TO SEL8_COMMISSION_PERCENT_FH
               MOVE SEL8_COMMISSION_OUT TO SEL8_COMMISSION_OUT_FH

           WHEN SEL8_SOLVE_SALES <= 25000
               COMPUTE SEL8_SOLVE_COMMISSION = SEL8_SOLVE_SALES * .25
               MOVE SEL8_SOLVE_COMMISSION TO SEL8_COMMISSION_OUT
               DISPLAY "WITH 25% COMMISSION AMOUNTING TO: " 
-                  SEL8_COMMISSION_OUT
               MOVE "25%" TO SEL8_COMMISSION_PERCENT_FH
               MOVE SEL8_COMMISSION_OUT TO SEL8_COMMISSION_OUT_FH

           WHEN SEL8_SOLVE_SALES <= 30000
               COMPUTE SEL8_SOLVE_COMMISSION = SEL8_SOLVE_SALES * .30
               MOVE SEL8_SOLVE_COMMISSION TO SEL8_COMMISSION_OUT
               DISPLAY "WITH 30% COMMISSION AMOUNTING TO: " 
-                  SEL8_COMMISSION_OUT
               MOVE "30%" TO SEL8_COMMISSION_PERCENT_FH
               MOVE SEL8_COMMISSION_OUT TO SEL8_COMMISSION_OUT_FH

           WHEN SEL8_SOLVE_SALES > 30000
               COMPUTE SEL8_SOLVE_COMMISSION = SEL8_SOLVE_SALES * .40
               MOVE SEL8_SOLVE_COMMISSION TO SEL8_COMMISSION_OUT
               DISPLAY "WITH 40% COMMISSION AMOUNTING TO: " 
-                  SEL8_COMMISSION_OUT
               MOVE "40%" TO SEL8_COMMISSION_PERCENT_FH
               MOVE SEL8_COMMISSION_OUT TO SEL8_COMMISSION_OUT_FH

           END-EVALUATE.

               WRITE SEL8_RECORD.
           CLOSE SEL8-FILE.

           DISPLAY "VIEW HISTORY? (Y/y): " WITH NO ADVANCING.
           ACCEPT SEL8_HISTORY.

           IF SEL8_HISTORY = "Y" OR SEL8_HISTORY = "y"
           MOVE "N" TO SEL8_EOF
               OPEN INPUT SEL8-FILE
               PERFORM UNTIL SEL8_EOF = "Y"
                   READ SEL8-FILE
                       AT END
                           DISPLAY "END OF HISTORY"
                           MOVE "Y" TO SEL8_EOF

                       NOT AT END
                       DISPLAY "==============================="
                       DISPLAY "NUMBER: " SEL8_SM_NUM_FH
                       DISPLAY "NAME: " SEL8_SM_NAME_FH
                       DISPLAY "SOLD: " SEL8_UNIT_SOLD_FH
                       DISPLAY "PRICE: " SEL8_UNIT_PRICE_FH
                       DISPLAY "SALES: " SEL8_SALES_OUT_FH
                       DISPLAY "COMMISSION: " SEL8_COMMISSION_PERCENT_FH
                       DISPLAY "AMOUNT: " SEL8_COMMISSION_OUT_FH 
                       DISPLAY "==============================="
                       DISPLAY SPACE

                   END-READ
               END-PERFORM
               CLOSE SEL8-FILE
           END-IF. 

           STOP RUN.
