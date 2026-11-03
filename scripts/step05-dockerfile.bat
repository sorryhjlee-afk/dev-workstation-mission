@echo off
chcp 949 >nul
setlocal
set "PATH=%PATH%;C:\Program Files\Docker\Docker\resources\bin"
set "PROJ=C:\study\my-web-server"
title STEP 5. Dockerfile 확인하기
echo ============================================================
echo  STEP 5. Dockerfile 확인하기
echo ============================================================
echo.

cd /d "%PROJ%"

if not exist Dockerfile (
  echo   [!] Dockerfile 이 없습니다. step04-make-project.bat 를 먼저 실행하세요.
  goto :end
)

echo [5-1] Dockerfile 내용
echo ------------------------------------------------------------
rem  Dockerfile 은 UTF-8 이고 콘솔은 CP949 라서 type 으로 보면 한글이 깨집니다.
rem  PowerShell 로 읽으면 콘솔 코드페이지에 맞게 변환되어 제대로 보입니다.
powershell -NoProfile -Command "Get-Content -LiteralPath 'Dockerfile' -Encoding UTF8"
echo ------------------------------------------------------------
echo.

echo [5-2] 파일 이름이 정확한지 확인 (확장자가 없어야 함)
dir /b Dockerfile*
echo.
echo   Dockerfile          -^> 정답
echo   Dockerfile.txt      -^> 틀림! 이름을 바꿔야 빌드됩니다.
echo.

echo [5-3] 한 줄씩 뜻
echo   FROM nginx:latest              = 완성된 웹서버(nginx)를 바탕으로 시작
echo   LABEL ...                      = 만든 사람 이름표
echo   COPY app/ /usr/share/nginx/html/ = 내 웹페이지를 상자 안으로 복사
echo   EXPOSE 80                      = 상자는 80번 포트를 쓴다는 안내
echo   CMD ["nginx","-g","daemon off;"] = 켜질 때 nginx 를 계속 실행
:end

echo.
echo ============================================================
echo  STEP 5. Dockerfile 확인하기 - 끝
echo ============================================================
if not defined NOPAUSE pause
endlocal
