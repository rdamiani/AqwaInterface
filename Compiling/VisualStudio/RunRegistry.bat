@ECHO OFF

set lines=======================================================================
echo %lines%
IF "%1"=="" (
ECHO.
ECHO   The calling syntax for this script is
ECHO             RunRegistry ModuleName
ECHO.
GOTO Done
)


REM ----------------------------------------------------------------------------
REM ------------------------- LOCAL PATHS --------------------------------------
REM ----------------------------------------------------------------------------
REM -- USERS MAY EDIT THESE PATHS TO POINT TO FOLDERS ON THEIR LOCAL MACHINES. -
REM -- NOTE: do not use quotation marks around the path names!!!! --------------
REM ----------------------------------------------------------------------------
REM ----------------------------------------------------------------------------

SET Registry=C:\Users\aplatt\Documents\software_development\windsvn\FAST\branches\FAST_Registry\bin\Registry_Win32.exe

SET NWTC_Lib_Loc=C:\Users\aplatt\Documents\software_development\windsvn\NWTC_Library\trunk\source


SET Orca_Reg_Loc=C:\Users\aplatt\Documents\software_development\wind-dev\OrcaFlexInterface\trunk\Source\Registry
SET Orca_Reg_OutLoc=C:\Users\aplatt\Documents\software_development\wind-dev\OrcaFlexInterface\trunk\Source


SET ModuleName=%1

GOTO %ModuleName%

REM ----------------------------------------------------------------------------
REM ---------------- RUN THE REGISTRY TO AUTO-GENERATE FILES -------------------
REM ----------------------------------------------------------------------------
:OrcaFlexInterface
SET CURR_LOC=%Orca_Reg_Loc%
%REGISTRY% "%CURR_LOC%\OrcaFlexInterface.txt" -I "%NWTC_Lib_Loc%"  -O "%Orca_Reg_OutLoc%"
GOTO checkError


:checkError
ECHO.
IF %ERRORLEVEL% NEQ 0 (
ECHO Error running FAST Registry for %ModuleName%.
) ELSE (
ECHO Registry for %ModuleName% completed.
REM COPY /Y "%ModuleName%_Types.f90"   "%CURR_LOC%"
rem IF /I "%ModuleName%"=="MAP" COPY /Y "%ModuleName%_Types.h" "%CURR_LOC%"
)




:end
REM ----------------------------------------------------------------------------
REM ------------------------- CLEAR MEMORY -------------------------------------
REM ----------------------------------------------------------------------------
ECHO. 


SET REGISTRY=

SET NWTC_Lib_Loc=
SET ED_Loc=
SET SrvD_Loc=
SET AD14_Loc=
SET AD_Loc=
SET AFI_Loc=
SET BEMT_Loc=
SET UA_Loc=
SET DWM_Loc=
SET IfW_Loc=
SET HD_Loc=
SET SD_Loc=
SET MAP_Loc=
SET FEAM_Loc=
SET IceF_Loc=
SET ID_Loc=
SET FAST_Loc=
SET MAP_Include_Lib=
SET HD_Reg_Loc=
SET IfW_Reg_Loc=
SET FEAM_Reg_Loc=
SET MD_Loc=

SET ModuleName=
SET CURR_LOC=
:Done
echo %lines%
set lines=