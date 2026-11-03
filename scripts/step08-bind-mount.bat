@echo off
chcp 949 >nul
setlocal
set "PATH=%PATH%;C:\Program Files\Docker\Docker\resources\bin"
set "PROJ=C:\study\my-web-server"
title STEP 8. 바인드 마운트 (포트 8083)
echo ============================================================
echo  STEP 8. 바인드 마운트 (포트 8083)
echo ============================================================
echo.

cd /d "%PROJ%"

echo [8-1] 예전 컨테이너 정리
docker rm -f live-site >nul 2>&1

echo [8-2] 내 폴더를 상자에 연결해서 실행
echo       -v "%PROJ%\app : /usr/share/nginx/html"
docker run -d -p 8083:80 --name live-site -v "%PROJ%\app:/usr/share/nginx/html" my-web-server
if errorlevel 1 goto :end
echo.

ping -n 3 127.0.0.1 >nul
echo [8-3] 지금 화면 내용 ^(변경 전^)
call :peek 8083
echo.
start "" http://localhost:8083
echo   -^> 브라우저 캡처하세요. 파일명 예: docs\images\bind-before.png
echo.
echo ------------------------------------------------------------
echo  이제 app\index.html 을 고치고 저장하세요 ^(UTF-8^).
echo    - Hello Docker!  ->  안녕하세요, 도커!
echo    - version 1.0    ->  version 2.0 (수정됨)
echo ------------------------------------------------------------
notepad "%PROJ%\app\index.html"
echo.
echo 메모장을 닫으면 계속합니다...
pause

echo [8-4] 다시 확인 ^(변경 후^) - 빌드를 다시 하지 않았습니다!
call :peek 8083
echo.
echo [8-5] 비교: 같은 순간 8081 ^(COPY 로 구운 컨테이너^)
call :peek 8081
echo.
echo [성공 확인] 8083 은 바뀌고 8081 은 그대로면 바인드 마운트 성공!
start "" http://localhost:8083
echo   -^> 브라우저 캡처하세요. 파일명 예: docs\images\bind-after.png
goto :end

:peek
rem  웹페이지는 UTF-8 이라 PowerShell 로 읽어야 한글이 안 깨집니다.
powershell -NoProfile -Command "$r=(Invoke-WebRequest -UseBasicParsing ('http://localhost:' + '%~1' + '/')).Content -split \"`n\"; $r | Select-String -Pattern '<h1>','class=\"ver\"','linear-gradient' | ForEach-Object { '   [%~1] ' + $_.ToString().Trim() }"
exit /b

:end

echo.
echo ============================================================
echo  STEP 8. 바인드 마운트 (포트 8083) - 끝
echo ============================================================
if not defined NOPAUSE pause
endlocal
