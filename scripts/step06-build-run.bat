@echo off
chcp 949 >nul
setlocal
set "PATH=%PATH%;C:\Program Files\Docker\Docker\resources\bin"
set "PROJ=C:\study\my-web-server"
title STEP 6. 빌드 - 실행 - 브라우저 접속 (포트 8081)
echo ============================================================
echo  STEP 6. 빌드 - 실행 - 브라우저 접속 (포트 8081)
echo ============================================================
echo.

cd /d "%PROJ%"
if not exist Dockerfile (
  echo   [!] Dockerfile 이 없습니다. step04 를 먼저 실행하세요.
  goto :end
)

echo [6-1] 이미지 굽기  (마지막 점을 빼먹지 마세요)
docker build -t my-web-server .
if errorlevel 1 (
  echo   [!] 빌드 실패. 위 에러 메시지를 읽어보세요.
  goto :end
)
echo.

echo [6-2] 만들어진 이미지 확인
docker images my-web-server
echo.

echo [6-3] 예전 컨테이너가 있으면 정리 (이름 중복 에러 방지)
docker rm -f my-site >nul 2>&1
echo.

echo [6-4] 컨테이너 실행 : 내 컴퓨터 8081번 -^> 상자 안 80번
docker run -d -p 8081:80 --name my-site my-web-server
if errorlevel 1 (
  echo   [!] 실행 실패. 8081 포트를 다른 프로그램이 쓰고 있을 수 있습니다.
  echo       docker ps 로 확인하거나 다른 번호^(8085 등^)를 쓰세요.
  goto :end
)
echo.

echo [6-5] 실행 중인지 확인
docker ps --filter name=my-site
echo.

echo [6-6] 터미널로 접속 테스트
curl.exe -s -o NUL -w "  HTTP status = %%{http_code}\n" http://localhost:8081/
echo   ^(200 이면 성공^)
echo.

echo [6-7] 브라우저 열기
start "" http://localhost:8081
echo   -^> 브라우저가 열리면 주소창이 보이게 캡처하세요 ^(Windows+Shift+S^)
:end

echo.
echo ============================================================
echo  STEP 6. 빌드 - 실행 - 브라우저 접속 (포트 8081) - 끝
echo ============================================================
if not defined NOPAUSE pause
endlocal
