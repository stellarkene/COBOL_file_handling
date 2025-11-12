      *programmer name: Gabriel Sanchez 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SALES-MAN-INFO.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.

           SELECT SQNC5-FILE ASSIGN TO "sqnc_5.dat"
-                  ORGANIZATION IS LINE SEQUENTIAL.  

       DATA DIVISION.
       FILE SECTION.
           FD SQNC5-FILE.

       01  SQNC5_RECORD.
           05  SEQ5_SALES_MAN_NUM_FH           PIC X(12).
           05  SEQ5_SALES_MAN_NAME_FH          PIC X(25).
           05  SEQ5_UNIT_SOLD_FH               PIC ZZ,ZZ9.
           05  SEQ5_UNIT_PRICE_FH              PIC ZZ,ZZ9.99.
           05  SEQ5_STORE_TOTAL_SALES_FH       PIC $Z,ZZZ,ZZZ,ZZ9.


       WORKING-STORAGE SECTION.
       01  SEQ5_SALES_MAN_NUM          PIC 9(12).
       01  SEQ5_SALES_MAN_NAME         PIC X(25).
       01  SEQ5_UNIT_SOLD              PIC 9(5).
       01  SEQ5_UNIT_PRICE             PIC 9(5)v99.
       01  SEQ5_STORE_TOTAL_SALES      PIC $Z,ZZZ,ZZZ,ZZ9.
       01  SEQ5_EOF                    PIC X VALUE "N".
       01  SEQ5_HISTORY                PIC X VALUE "N".

       PROCEDURE DIVISION.
           DISPLAY "PLEASE INPUT NAME: " WITH NO ADVANCING.
           ACCEPT SEQ5_SALES_MAN_NAME.

           DISPLAY "PLEASE INPUT NUM: " WITH NO ADVANCING.
           ACCEPT SEQ5_SALES_MAN_NUM.

           DISPLAY "PLEASE INPUT UNITS SOLD: " WITH NO ADVANCING.
           ACCEPT SEQ5_UNIT_SOLD.

           DISPLAY "PLEASE INPUT UNIT PRICE: " WITH NO ADVANCING.
           ACCEPT SEQ5_UNIT_PRICE.

           COMPUTE SEQ5_STORE_TOTAL_SALES = 
-              SEQ5_UNIT_SOLD * SEQ5_UNIT_PRICE.
           DISPLAY "TOTAL SALES: " SEQ5_STORE_TOTAL_SALES.

           OPEN EXTEND SQNC5-FILE.
               MOVE SEQ5_SALES_MAN_NUM TO SEQ5_SALES_MAN_NUM_FH.
               MOVE SEQ5_SALES_MAN_NAME TO SEQ5_SALES_MAN_NAME_FH.
               MOVE SEQ5_UNIT_SOLD TO SEQ5_UNIT_SOLD_FH.
               MOVE SEQ5_UNIT_PRICE TO SEQ5_UNIT_PRICE_FH.
               MOVE SEQ5_STORE_TOTAL_SALES TO SEQ5_STORE_TOTAL_SALES_FH.
               WRITE SQNC5_RECORD.
           CLOSE SQNC5-FILE.

           DISPLAY "VIEW  HISTORY? (Y): " WITH NO ADVANCING.
           ACCEPT SEQ5_HISTORY.

           IF  SEQ5_HISTORY = "Y" OR SEQ5_HISTORY = "y"
               MOVE "N" TO SEQ5_EOF
               OPEN INPUT SQNC5-FILE
                   PERFORM UNTIL SEQ5_EOF = "Y"
                       READ SQNC5-FILE
                           AT END
                               DISPLAY "END OF HISTORY"
                               MOVE "Y" TO SEQ5_EOF

                           NOT AT END
                               DISPLAY "==============================="
                               DISPLAY "NAME: " SEQ5_SALES_MAN_NAME_FH
                               DISPLAY "NUMBER: " SEQ5_SALES_MAN_NUM_FH
                               DISPLAY "UNITS SOLD" SEQ5_UNIT_SOLD_FH
                               DISPLAY "UNIT PRICE" SEQ5_UNIT_PRICE_FH
                               DISPLAY "TOTAL SALES" 
-                                  SEQ5_STORE_TOTAL_SALES_FH
                               DISPLAY "==============================="
                               DISPLAY SPACE
                       END-READ
                   END-PERFORM
               CLOSE SQNC5-FILE
           END-IF.
           
           STOP RUN.
