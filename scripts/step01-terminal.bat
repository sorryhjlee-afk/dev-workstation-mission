@echo off
chcp 949 >nul
setlocal
set "PATH=%PATH%;C:\Program Files\Docker\Docker\resources\bin"
set "PROJ=C:\study\my-web-server"
title STEP 1. 터미널 기본 조작
echo ============================================================
echo  STEP 1. 터미널 기본 조작
echo ============================================================
echo.

echo [1-1] 내가 지금 있는 폴더 보기  (pwd)
cd
echo.

echo [1-2] 작업 폴더 만들기  (mkdir)
if not exist "%PROJ%\app" (
  mkdir "%PROJ%\app"
  echo   -^> 새로 만들었습니다: %PROJ%\app
) else (
  echo   -^> 이미 있습니다: %PROJ%\app
)
echo.

echo [1-3] 그 폴더로 이동하기  (cd)
cd /d "%PROJ%"
cd
echo.

echo [1-4] 폴더 안에 뭐가 있나 보기  (dir)
dir /b
echo.

echo [1-5] 연습용 파일 만들고 읽어보기
echo hello terminal> memo-test.txt
type memo-test.txt
del memo-test.txt
echo   -^> 만들고, 읽고, 지웠습니다.
echo.
echo [성공 확인] 위에 %PROJ% 경로와 app 폴더가 보이면 OK!

echo.
echo ============================================================
echo  STEP 1. 터미널 기본 조작 - 끝
echo ============================================================
if not defined NOPAUSE pause
endlocal
