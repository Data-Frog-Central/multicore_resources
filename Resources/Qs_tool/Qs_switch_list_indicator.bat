@ECHO OFF
@REM ===========================================================================
SET QS_MODE=[36mStandard Game List Indicator[0m
SET QS_FOLDER_NAM_SYSTEM_START_NUM=15
SET QS_FOLDER_NAM_RES=list_indicator_

@REM ===========================================================================
PUSHD "%~dp0\%..\"
SET QS_RES_DIR=%CD%
POPD 
IF NOT EXIST "%QS_RES_DIR%\Foldername.ini%" (
  ECHO ! Couldn't find "Foldername.ini" file "[93m%QS_RES_DIR%\Foldername.ini[0m"
  ECHO   Check the provided path points to an SD card!
  PAUSE>NUL
  EXIT /B -1
)

CALL :GET_FOLDER_NAM
IF ERRORLEVEL 1 GOTO :NO_SWITCH_EXIT

SET QS_FOLDER_NAM_RES=%QS_FOLDER_NAM_RES%clear
IF "%QS_FOLDER_NAM%" == "460 44" GOTO :SWITCH_CHECK
SET QS_FOLDER_NAM_RES=%QS_FOLDER_NAM_RES:clear=simple%
SET QS_MODE=[93mClear Game List Indicator[0m
IF "%QS_FOLDER_NAM%" == "460 42" GOTO :SWITCH_CHECK
SET QS_FOLDER_NAM_RES=%QS_FOLDER_NAM_RES:simple=orig%
SET QS_MODE=[90mSimple Game List Indicator[0m

@REM ===========================================================================
:SWITCH_CHECK

IF NOT EXIST "%~dp0%QS_FOLDER_NAM_RES%\Foldername.ini%" (
  ECHO ! Couldn't find Resource folder "[93m%~dp0%QS_FOLDER_NAM_RES%[0m"
  ECHO   Check the provided path points to an SD card!
  PAUSE>NUL
  EXIT /B -1
)

@REM ===========================================================================
:SWITCH_CONFIRM

ECHO [90mCURRENT MODE:[0m %QS_MODE%
ECHO.
SET QS_SWITCH_CONFIRM=
SET /P QS_SWITCH_CONFIRM="Press Enter key to switch mode (Enter [n] to cancel) [y]: "
IF "%QS_SWITCH_CONFIRM%" == ""    GOTO :SWITCH_START
IF "%QS_SWITCH_CONFIRM%" == "Y"   GOTO :SWITCH_START
IF "%QS_SWITCH_CONFIRM%" == "y"   GOTO :SWITCH_START
IF "%QS_SWITCH_CONFIRM%" == "yes" GOTO :SWITCH_START
IF "%QS_SWITCH_CONFIRM%" == "YES" GOTO :SWITCH_START
IF "%QS_SWITCH_CONFIRM%" == "Yes" GOTO :SWITCH_START

GOTO NO_SWITCH_EXIT

@REM ===========================================================================
:SWITCH_START

@REM --- Copy Resource Files ---
XCOPY /Y /R "%~dp0%QS_FOLDER_NAM_RES%\*" "%QS_RES_DIR%\"

@REM ===========================================================================
SET QS_MODE=[90mSimple Game List Indicator[0m
IF "%QS_FOLDER_NAM%" == "460 42" GOTO :SWITCH_END
SET QS_MODE=[93mClear Game List Indicator[0m
IF "%QS_FOLDER_NAM%" == "460 44" GOTO :SWITCH_END
SET QS_MODE=[36mStandard Game List Indicator[0m

:SWITCH_END

CLS
ECHO Switch complete.
ECHO.
ECHO [90mCURRENT MODE:[0m %QS_MODE%
ECHO.
PAUSE
EXIT /B 0

:NO_SWITCH_EXIT

ECHO.
ECHO Switch was aborted.
PAUSE
EXIT /B 1


@REM ###########################################################################
:GET_FOLDER_NAM

SET QS_SYSTEM_LIST=
SET QS_FOLDER_NAM=
SET QS_FOR_PARAM=usebackq skip=%QS_FOLDER_NAM_SYSTEM_START_NUM% tokens=1-2
FOR /F "%QS_FOR_PARAM%" %%S IN ("%QS_RES_DIR%\Foldername.ini") DO (
  SET QS_FOR_SYS=
  IF "%%S" == "" GOTO :GET_FOLDER_NAM_EXIT
  CALL :NUMBER_CHK %%S
  IF DEFINED QS_NUM GOTO :GET_FOLDER_NAM_EXIT
  SET QS_FOLDER_NAM=%%S %%T
  GOTO :GET_FOLDER_NAM_EXIT
)

:GET_FOLDER_NAM_EXIT
IF NOT "%QS_FOLDER_NAM%" == "" EXIT /B 0

ECHO ! SD card not read file. "[93m%QS_RES_DIR%\Foldername.ini[0m"
ECHO ! If [93mFordername.ini[0m is open, close and try running again.
EXIT /B 1

@REM ###########################################################################
:NUMBER_CHK

SET QS_NUM=%1

IF DEFINED QS_NUM SET QS_NUM=%QS_NUM:0=%
IF DEFINED QS_NUM SET QS_NUM=%QS_NUM:1=%
IF DEFINED QS_NUM SET QS_NUM=%QS_NUM:2=%
IF DEFINED QS_NUM SET QS_NUM=%QS_NUM:3=%
IF DEFINED QS_NUM SET QS_NUM=%QS_NUM:4=%
IF DEFINED QS_NUM SET QS_NUM=%QS_NUM:5=%
IF DEFINED QS_NUM SET QS_NUM=%QS_NUM:6=%
IF DEFINED QS_NUM SET QS_NUM=%QS_NUM:7=%
IF DEFINED QS_NUM SET QS_NUM=%QS_NUM:8=%
IF DEFINED QS_NUM SET QS_NUM=%QS_NUM:9=%

EXIT /B
