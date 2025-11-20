      *programmer name: Gabriel Sanchez
       IDENTIFICATION DIVISION.
       PROGRAM-ID. FH-MAIN-MENU.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.

       DATA DIVISION.
           FILE SECTION.
               COPY "fd-vars.cpy".

           WORKING-STORAGE SECTION.
               COPY "ws-vars.cpy".

       01  WS-USERCHOICE-SEQ               PIC 9.
       01  WS-USERCHOICE-SEL               PIC 9.
       01  WS-USERCHOICE-ITE               PIC 9.
       01  WS-USERCHOICE-MM                PIC 9.

       01  CLEAR-COMMAND                   PIC X(10).
       01  OS-NAME                         PIC X(50).

       01  EXT-FUNC                        PIC X.

       PROCEDURE DIVISION.
           PERFORM MAIN-MENU.

           STOP RUN.

       MAIN-MENU.
           PERFORM UNTIL WS-USERCHOICE-MM = 4
               PERFORM CLEAR-SCREEN
               

               DISPLAY "==========================="
               DISPLAY "         MAIN MENU         "
               DISPLAY "==========================="
               DISPLAY "1 - SEQUENCE MENU"
               DISPLAY "2 - SELECTION MENU"
               DISPLAY "3 - ITERATION MENU"
               DISPLAY "4 - EXIT"
               DISPLAY "ENTER CHOICE (1 - 4): "
               ACCEPT WS-USERCHOICE-MM

               EVALUATE WS-USERCHOICE-MM
                   WHEN 1

                   WHEN 2

                   WHEN 3

                   WHEN 4

                   WHEN OTHER
                       DISPLAY "INVALID INPUT"

                END-EVALUATE

           END-PERFORM

               PERFORM EXIT-PROMPT
           EXIT PARAGRAPH.

      *======================
      *FUNCTION: CLEAR-SCREEN
      *======================
       CLEAR-SCREEN.
           ACCEPT OS-NAME FROM ENVIRONMENT "OS"
           IF OS-NAME = "Windows_NT"
               MOVE "cls" TO CLEAR-COMMAND
           ELSE
               MOVE "clear" TO CLEAR-COMMAND
           END-IF

           CALL "SYSTEM" USING CLEAR-COMMAND
           
           EXIT PARAGRAPH.

       EXIT-PROMPT.
           DISPLAY "PLEASE PRESS ENTER TO EXIT"
           ACCEPT EXT-FUNC

           EXIT PARAGRAPH.
