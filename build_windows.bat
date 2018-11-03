@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS

REM Parameter %1: C file to compile
REM Parameter %2: Run method, one of:
REM               Empty - run the program with an empty stdin, i.e. just EOF
REM               EmptyOut - run the program with an empty stdin, and output to %3 stdout file
REM               Interactive - open a new cmd window to run the compiled program and allow the user to interact with it. However, the input & output will be lost when the window is closed.
REM               Test - run all tests in the current folder of the format: <filename>.exe < <filename>in#.txt > out.txt, and compare with <filename>out#.txt
REM               In - run with parameter %3 as stdin file and output to the screen.
REM               InOut - run with parameter %3 as stdin file and output to %4 stdout file.
REM Parameter %3: Depends on the run method.
REM               EmptyOut: stdout output file
REM               In, InOut: stdin input file
REM Paramater %4: InOut only - stdout output file

REM Start compilation
REM =================
ECHO Compiling %1 to %~n1.exe ...

gcc -O -Wall -Wextra -Werror -Wpedantic -std=c99 %1 -o %~n1.exe

REM Check for compilation errors
REM ============================
IF %ERRORLEVEL% NEQ 0 (
    ECHO.
    ECHO Compilation failed.
    ECHO.
    EXIT
)

ECHO Compilation finished successfully.
ECHO.


REM Run appropriate execution method
REM ================================
IF /I [%2] EQU [Empty] (
    ECHO Running program with no stdin...
    %~n1.exe < NUL

) ELSE IF /I [%2] EQU [Interactive] (
    ECHO Running program interactively in new window...
    START /WAIT CMD /c "%~n1.exe & PAUSE"
    ECHO Finished.

) ELSE IF /I [%2] EQU [Test] (
    ECHO Testing program...
    ECHO.

    REM Find test files:
    FOR /R %%T IN (%~n1in*.txt) DO (
        SET _input=%%T
        REM Find corresponding expected output file by replacing in with out:
        SET _expected=!_input:%~n1in=%~n1out!


        REM To do: Check that _expected exists, and run the tests including comparison with FC
        ECHO.

        

        ECHO Input - !_input!:
        TYPE !_input!

        ECHO.
        ECHO.
        ECHO Output:

        %~n1.exe < !_input! > test_out.txt
        TYPE test_out.txt

        ECHO.
        ECHO.
        IF EXIST !_expected! (
            REM Compare expected output and actual output
            FC /B !_expected! test_out.txt > NUL
            IF !ERRORLEVEL! EQU 0 (ECHO TEST PASSED^^!) ELSE (
                REM There is a difference.
                ECHO.
                ECHO.
                ECHO TEST FAILED - output doesn't match^^!
                FC /N !_expected! test_out.txt
                IF !ERRORLEVEL! EQU 0 ECHO However, there is a missing or extra newline ^(\n^) at the end of the file^^!
            )

        ) ELSE ECHO Test file !_input! - corresponding output file missing: !_expected! not found
        ECHO.
        ECHO ------------

    )

) ELSE IF /I [%2] EQU [In]  (
    ECHO stdin - %3:
    TYPE %3
    ECHO.
    ECHO.
    ECHO Running program...
    REM %~n1.exe ^< %3
)
