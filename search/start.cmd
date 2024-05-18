echo off
setlocal
ECHO taskschd.msc
set "program_path=C:\search\AVSEARCH.EXE"
set "log_folder=C:\search\logs"

if not exist "%log_folder%" mkdir "%log_folder%"

for /f "tokens=1-3 delims=: " %%a in ("%time%") do (
    set "start_time=%%a:%%b:%%c"
)


"%program_path%"

:wait_loop
timeout /t 1 /nobreak >nul
tasklist /fi "imagename eq %program_path%" | findstr /i "%program_path%" >nul && (
    goto wait_loop
)

for /f "tokens=1-3 delims=: " %%a in ("%time%") do (
    set "end_time=%%a:%%b:%%c"
)

set "log_file=%log_folder%\log.txt"
>> "%log_file%" echo Время запуска программы: %start_time%
>> "%log_file%" echo Время завершения работы программы: %end_time%

exit /b
