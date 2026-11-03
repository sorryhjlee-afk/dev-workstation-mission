@echo off
chcp 949 >nul
setlocal
title 도커 미션 실행 메뉴

:menu
cls
echo ============================================================
echo   도커 웹서버 미션 - 단계별 실행 메뉴
echo ============================================================
echo.
echo   1. STEP 1  터미널 기본 조작
echo   2. STEP 2  권한 확인
echo   3. STEP 3  도커 설치 점검
echo   4. STEP 4  프로젝트 폴더/웹페이지 만들기
echo   5. STEP 5  Dockerfile 확인
echo   6. STEP 6  빌드 - 실행 - 접속 (8081)
echo   7. STEP 7  운영 명령 로그 모으기
echo   8. STEP 8  바인드 마운트 (8083)
echo   9. STEP 9  볼륨 영속성 (8082)
echo  10. STEP 10 Git 설정과 첫 커밋
echo  11. STEP 11 GitHub 에 올리기
echo  12. STEP 12 뒷정리 (선택)
echo.
echo   0. 끝내기
echo.
set /p SEL=번호를 입력하세요:
if "%SEL%"=="0" goto :eof
if "%SEL%"=="1"  call "%~dp0step01-terminal.bat"
if "%SEL%"=="2"  call "%~dp0step02-permission.bat"
if "%SEL%"=="3"  call "%~dp0step03-docker-check.bat"
if "%SEL%"=="4"  call "%~dp0step04-make-project.bat"
if "%SEL%"=="5"  call "%~dp0step05-dockerfile.bat"
if "%SEL%"=="6"  call "%~dp0step06-build-run.bat"
if "%SEL%"=="7"  call "%~dp0step07-operations.bat"
if "%SEL%"=="8"  call "%~dp0step08-bind-mount.bat"
if "%SEL%"=="9"  call "%~dp0step09-volume.bat"
if "%SEL%"=="10" call "%~dp0step10-git.bat"
if "%SEL%"=="11" call "%~dp0step11-github.bat"
if "%SEL%"=="12" call "%~dp0step12-cleanup.bat"
goto :menu
