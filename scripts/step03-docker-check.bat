@echo off
chcp 949 >nul
setlocal
set "PATH=%PATH%;C:\Program Files\Docker\Docker\resources\bin"
set "PROJ=C:\study\my-web-server"
title STEP 3. 도커 설치 점검
echo ============================================================
echo  STEP 3. 도커 설치 점검
echo ============================================================
echo.

echo [3-1] 버전 확인
docker --version
if errorlevel 1 (
  echo.
  echo   [!] docker 명령을 찾을 수 없습니다.
  echo       1^) Docker Desktop 이 설치되어 있는지 확인
  echo       2^) 작업표시줄 고래 아이콘이 있는지 확인
  echo       3^) 설치했다면 컴퓨터를 한 번 재부팅
  goto :end
)
docker compose version
git --version
echo.

echo [3-2] 엔진이 살아있는지 확인
rem  주의: docker --format 안에는 한글을 넣지 않습니다 (콘솔 코드페이지 때문에 깨집니다)
docker info --format "ServerVersion={{.ServerVersion}}  Running={{.ContainersRunning}}  Images={{.Images}}"
if errorlevel 1 (
  echo.
  echo   [!] 엔진에 연결할 수 없습니다. Docker Desktop 을 실행하고
  echo       고래 아이콘이 잠잠해질 때까지 1~2분 기다린 뒤 다시 실행하세요.
  goto :end
)
echo.

echo [3-3] 진짜로 컨테이너 한 번 돌려보기 (hello-world)
docker run --rm hello-world
echo.
echo [성공 확인] 위에 Hello from Docker! 가 보이면 설치 완벽!
:end

echo.
echo ============================================================
echo  STEP 3. 도커 설치 점검 - 끝
echo ============================================================
if not defined NOPAUSE pause
endlocal
