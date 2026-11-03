@echo off
chcp 949 >nul
setlocal
set "PATH=%PATH%;C:\Program Files\Docker\Docker\resources\bin"
set "PROJ=C:\study\my-web-server"
title STEP 4. 프로젝트 폴더와 웹페이지 만들기
echo ============================================================
echo  STEP 4. 프로젝트 폴더와 웹페이지 만들기
echo ============================================================
echo.

set "SRC=%~dp0..\templates"

echo [4-1] 폴더 만들기
if not exist "%PROJ%\app" mkdir "%PROJ%\app"
if not exist "%PROJ%\docs\images" mkdir "%PROJ%\docs\images"
echo   -^> %PROJ%\app
echo   -^> %PROJ%\docs\images
echo.

echo [4-2] 준비된 템플릿 복사 (UTF-8 그대로 복사하므로 한글이 안 깨집니다)
copy /y "%SRC%\index.html"   "%PROJ%\app\index.html"   >nul && echo   -^> app\index.html
copy /y "%SRC%\Dockerfile"   "%PROJ%\Dockerfile"       >nul && echo   -^> Dockerfile
copy /y "%SRC%\gitignore.txt" "%PROJ%\.gitignore"      >nul && echo   -^> .gitignore
copy /y "%SRC%\dockerignore.txt" "%PROJ%\.dockerignore" >nul && echo   -^> .dockerignore
echo.

echo [4-3] 확인
cd /d "%PROJ%"
dir /b
echo.
echo [할 일] app\index.html 을 메모장이나 VSCode 로 열어서
echo        "만든 사람: 홍길동" 을 내 이름으로 바꾸세요.
echo        ^(저장할 때 인코딩은 반드시 UTF-8^)
echo.
set /p OPEN=지금 열어볼까요? (y/n)
if /i "%OPEN%"=="y" notepad "%PROJ%\app\index.html"

echo.
echo ============================================================
echo  STEP 4. 프로젝트 폴더와 웹페이지 만들기 - 끝
echo ============================================================
if not defined NOPAUSE pause
endlocal
