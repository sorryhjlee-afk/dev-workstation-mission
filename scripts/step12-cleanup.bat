@echo off
chcp 949 >nul
setlocal
set "PATH=%PATH%;C:\Program Files\Docker\Docker\resources\bin"
set "PROJ=C:\study\my-web-server"
title STEP 12. 실습 뒷정리 (선택)
echo ============================================================
echo  STEP 12. 실습 뒷정리 (선택)
echo ============================================================
echo.

echo 현재 상태
docker ps -a
echo.
echo 주의: my-site ^(8081^) 는 제출 증거이므로 남겨 둡니다.
echo.
set /p YN=실습용 컨테이너(live-site, vol-test2)와 볼륨을 정리할까요? (y/n)
if /i not "%YN%"=="y" goto :end
docker rm -f live-site vol-test2
docker volume rm my-volume
echo.
echo 정리 후 상태
docker ps -a
:end

echo.
echo ============================================================
echo  STEP 12. 실습 뒷정리 (선택) - 끝
echo ============================================================
if not defined NOPAUSE pause
endlocal
