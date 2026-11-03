@echo off
chcp 949 >nul
setlocal
set "PATH=%PATH%;C:\Program Files\Docker\Docker\resources\bin"
set "PROJ=C:\study\my-web-server"
title STEP 9. 볼륨 영속성 (포트 8082)
echo ============================================================
echo  STEP 9. 볼륨 영속성 (포트 8082)
echo ============================================================
echo.

cd /d "%PROJ%"

echo [9-1] 볼륨 만들기
docker volume create my-volume
docker volume ls
echo.

echo [9-2] 예전 컨테이너 정리 후 볼륨 연결해서 실행
docker rm -f vol-test vol-test2 >nul 2>&1
docker run -d -p 8082:80 --name vol-test -v my-volume:/usr/share/nginx/html/data my-web-server
if errorlevel 1 goto :end
ping -n 3 127.0.0.1 >nul
echo.

echo [9-3] 볼륨 안에 메모 남기기
docker exec vol-test sh -c "echo hello-volume > /usr/share/nginx/html/data/memo.txt"
echo   삭제 전 메모 내용:
docker exec vol-test cat /usr/share/nginx/html/data/memo.txt
echo   웹으로도 확인:
curl.exe -s http://localhost:8082/data/memo.txt
echo.
start "" http://localhost:8082/data/memo.txt
echo   -^> 캡처하세요. 파일명 예: docs\images\volume-before.png
pause

echo [9-4] ★ 컨테이너를 통째로 삭제!
docker rm -f vol-test
echo   삭제 후 목록 ^(비어 있어야 정상^):
docker ps -a --filter name=vol-test
echo.

echo [9-5] 새 컨테이너를 만들어 같은 볼륨 연결
docker run -d -p 8082:80 --name vol-test2 -v my-volume:/usr/share/nginx/html/data my-web-server
ping -n 3 127.0.0.1 >nul
echo   삭제 후에도 메모가 남아있나?
docker exec vol-test2 cat /usr/share/nginx/html/data/memo.txt
curl.exe -s http://localhost:8082/data/memo.txt
echo.
echo [성공 확인] hello-volume 이 그대로 보이면 볼륨 영속성 증명 완료!
echo.
docker volume inspect my-volume
start "" http://localhost:8082/data/memo.txt
echo   -^> 캡처하세요. 파일명 예: docs\images\volume-after.png
:end

echo.
echo ============================================================
echo  STEP 9. 볼륨 영속성 (포트 8082) - 끝
echo ============================================================
if not defined NOPAUSE pause
endlocal
