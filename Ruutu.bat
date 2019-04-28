@ECHO OFF
SETLOCAL
CHCP 1252 | PROMPT
ECHO.

REM ** Constant variables.
REM ** Ruutu 1.2.0 **
SET "html_file=html.txt"
SET "xml_file=xml.txt"
SET "chunk_file=chunk.txt"
SET "wget_log_file=wget.txt"
SET "wget_retries=3"
SET "info="
SET "log_folder=temp%random%"
SET "program_folder=Ruutu 1.2.0"
SET "program_name=Ruutu-lataaja v1.2.0"
SET "wget_options=--no-verbose --tries=%wget_retries% --append-output=%wget_log_file%
SET "ffmpeg_options= --user-agent=^"Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:67.0) Gecko/20100101 Firefox/67.0^""

TITLE %program_name%
:START
REM ** Getting a special "carriage return" character to a variable.
FOR /F %%a IN ('COPY /Z "%~dpf0" NUL') DO SET "CR=%%a"

MD "%log_folder%" 2>NUL

IF %ERRORLEVEL% NEQ 0 (
	REM ** Change console colors, light red text on black background.
	COLOR 0C
	TITLE ERROR! %program_name%
	ECHO. &ECHO ERROR! Write access denied! Please start this script from another location.
	ECHO. &ECHO Exiting. &ECHO.
	PAUSE
	EXIT
)

PUSHD "%log_folder%"

REM ** Ask user for the URL.
:URL
SET /P "video_url=Jakson osoite: "


SET "user_input_validation="
SET "token_string=%video_url%"
:FIND_VIDEOID_LOOP
FOR /F "tokens=1* delims=/" %%a IN ("%token_string%") DO (
	REM ** Validate user input, part 1, the URL.
	IF "%%a" EQU "www.ruutu.fi" SET "user_input_validation=%user_input_validation%y"
	IF "%%a" EQU "video" SET "user_input_validation=%user_input_validation%y"
	IF "%%a" EQU "www.supla.fi" SET "user_input_validation=%user_input_validation%y"
	IF "%%a" EQU "supla" SET "user_input_validation=%user_input_validation%y"
	IF "%%a" EQU "video" SET  "info=videota"	
	IF "%%a" EQU "supla" SET  "info=podcastia"	

	SET "video_id=%%a"
	SET "token_string=%%b"
	GOTO FIND_VIDEOID_LOOP

)	

	
SET "is_number="
FOR /F "delims=0123456789" %%a IN ("%video_id%") DO SET "is_number=%%a"
IF "%is_number%" EQU "" SET "user_input_validation=%user_input_validation%y"

IF "%user_input_validation%" NEQ "yyy" (
	ECHO. &ECHO HUOM! Osoitetta ei tuettu!
	ECHO Tarkista osoite ja kokeile uudelleen.
	ECHO.
	ECHO Esimerkki: https://www.ruutu.fi/video/1234567
	ECHO.
	ECHO.
	IF NOT EXIST "%video_url%" GOTO URL
)
ECHO.

REM ** HTML Download
ECHO.

SET /P "echo_line_string=Tiedostonimi: "

ECHO. &ECHO Aloitetaan lataamaan %info%...


SETLOCAL ENABLEDELAYEDEXPANSION
ECHO.
ENDLOCAL

REM ** Download the html file of the video.
..\wget.exe %wget_options% --output-document="%html_file%" "%video_url%" 


IF %ERRORLEVEL% NEQ 0 (
	ECHO %echo_line_string%
	ECHO. &ECHO HUOM! Jakson html-osoitetta ei havaittu!
	
)


REM ** XML Download

SETLOCAL ENABLEDELAYEDEXPANSION
ECHO.
ENDLOCAL

REM ** Download the xml file of the video.

..\wget.exe %wget_options% --output-document="%xml_file%" "http://gatling.nelonenmedia.fi/media-xml-cache?id=%video_id%"


IF %ERRORLEVEL% NEQ 0 (
	ECHO %echo_line_string%
	ECHO. &ECHO HUOM! Jakson xml-osoitetta ei havaittu!
	
)

REM ** Get the video playlist URL from the xml file. Using rather strict search to test that we're getting proper input.

IF EXIST "video" %%a IN ('FINDSTR /I "<variable name="media_type" value="video"/>" "%xml_file%" ') DO SET "video=base_url"
IF EXIST "podcast" %%a IN ('FINDSTR /I "<variable name="media_type" value="podcast"/>" "%xml_file%" ') DO SET "podcast=audio_url" 
FOR /F "tokens=3 delims=<>" %%a IN ('FINDSTR /I "<AppleMediaFile>http://.*/playlist.m3u8</AppleMediaFile>" "%xml_file%" ') DO SET "base_url=%%a"
FOR /F "tokens=3 delims=<>" %%a IN ('FINDSTR /I "<AudioMediaFile>https://.*/*.mp3</AudioMediaFile>" "%xml_file%" ') DO SET "audio_url=%%a"


REM ** Test if "baseurl" information was found.

IF "%base_url%" EQU "" (

	ECHO. &ECHO HUOM! Videon osoitetta ei havaittu! Videota ei voi ladata.
	ECHO.
	ECHO Videossa saattaa olla DRM-suojaus aktiivinen. Kokeile toista videota.
	ECHO.
	ECHO Jos kyseessä on podcast, kokeile toista jaksoa.
	ECHO.
	IF NOT EXIST "%base_url%" GOTO URL
)

SETLOCAL ENABLEEXTENSIONS

IF EXIST "html.txt" DEL "html.txt"
IF EXIST "xml.txt" DEL "xml.txt"
IF EXIST "wget.txt" DEL "wget.txt"

POPD
IF EXIST "%log_folder%" RD "%log_folder%" /S /Q

TITLE Ladataan %info%... " %echo_line_string% "
"..\ffmpeg.exe" -i "%base_url%" -v quiet -progress - -y -c copy "C:\Users\%USERNAME%\%echo_line_string%.mp4" || "..\ffmpeg.exe" -i "%audio_url%" -v quiet -stats "C:\Users\%USERNAME%\%echo_line_string%.mp3"
TITLE %program_name%

@ECHO OFF
ECHO.
ECHO.
SET /P "var=Haluatko ladata uuden jakson? [K/E]: "
ECHO.
IF /I "%var%"=="K" GOTO CLS
IF /I "%var%"=="E" GOTO EXIT
:CLS
CLS
ECHO.
GOTO START

:EXIT
EXIT

