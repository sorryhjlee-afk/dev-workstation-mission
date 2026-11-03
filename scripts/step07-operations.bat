@echo off
chcp 949 >nul
setlocal
set "PATH=%PATH%;C:\Program Files\Docker\Docker\resources\bin"
set "PROJ=C:\study\my-web-server"
title STEP 7. 운영/검증 명령 로그 모으기
echo ============================================================
echo  STEP 7. 운영/검증 명령 로그 모으기
echo ============================================================
echo.

cd /d "%PROJ%"
set "LOG=%PROJ%\docs\docker-operations-log.txt"
if not exist "%PROJ%\docs" mkdir "%PROJ%\docs"

echo 로그를 화면에 보여주고 동시에 파일로도 저장합니다.
echo 저장 위치: %LOG%
echo.

> "%LOG%" echo ===== Docker 운영 로그 =====
>> "%LOG%" echo 생성 시각: %date% %time%

call :run "1) docker images"      docker images
call :run "2) docker ps -a"       docker ps -a
call :run "3) docker logs"        docker logs my-site
call :run "4) docker stats"       docker stats --no-stream
call :run "5) docker inspect"     docker inspect my-site --format "{{.State.Status}}"
call :run "6) files in container" docker exec my-site ls /usr/share/nginx/html

echo.
echo [완료] 로그 파일: %LOG%
goto :end

:run
echo ------------------------------------------------------------
echo %~1
echo ------------------------------------------------------------
>> "%LOG%" echo.
>> "%LOG%" echo ----- %~1
shift
%1 %2 %3 %4 %5 %6 %7 %8 %9
%1 %2 %3 %4 %5 %6 %7 %8 %9 >> "%LOG%" 2>&1
echo.
exit /b

:end

echo.
echo ============================================================
echo  STEP 7. 운영/검증 명령 로그 모으기 - 끝
echo ============================================================
if not defined NOPAUSE pause
endlocal
