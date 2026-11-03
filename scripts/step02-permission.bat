@echo off
chcp 949 >nul
setlocal
set "PATH=%PATH%;C:\Program Files\Docker\Docker\resources\bin"
set "PROJ=C:\study\my-web-server"
title STEP 2. 권한 확인
echo ============================================================
echo  STEP 2. 권한 확인
echo ============================================================
echo.

cd /d "%PROJ%"

echo [2-1] 나는 누구인가  (whoami)
whoami
echo.

echo [2-2] 지금 관리자 권한인가?
net session >nul 2>&1
if %errorlevel%==0 (
  echo   -^> 관리자 권한으로 실행 중입니다.
) else (
  echo   -^> 일반 권한입니다. ^(이 미션은 일반 권한으로 충분합니다^)
  echo      관리자가 필요하면: 이 파일 우클릭 - 관리자 권한으로 실행
)
echo.

echo [2-3] 파일 권한 보기  (icacls)
if exist Dockerfile (
  icacls Dockerfile
) else (
  echo   -^> Dockerfile 이 아직 없습니다. step04 를 먼저 실행하세요.
)
echo.

echo [2-4] PowerShell 스크립트 실행 정책
powershell -NoProfile -Command "Get-ExecutionPolicy"
echo.
echo [읽는 법] F=모두가능  M=수정가능  RX=읽기/실행만  (I)=위 폴더에서 물려받음

echo.
echo ============================================================
echo  STEP 2. 권한 확인 - 끝
echo ============================================================
if not defined NOPAUSE pause
endlocal
