@echo off
chcp 949 >nul
setlocal
set "PATH=%PATH%;C:\Program Files\Docker\Docker\resources\bin"
set "PROJ=C:\study\my-web-server"
title STEP 11. GitHub 에 올리기
echo ============================================================
echo  STEP 11. GitHub 에 올리기
echo ============================================================
echo.

cd /d "%PROJ%"

echo 먼저 github.com 에서 빈 저장소를 만들어야 합니다.
echo.
echo   1^) github.com 로그인
echo   2^) 오른쪽 위 [+] - New repository
echo   3^) Repository name : my-web-server
echo   4^) Public 선택
echo   5^) "Add a README file" 체크 해제  ^(중요!^)
echo   6^) Create repository
echo.
set /p OPENGH=지금 github.com 을 열까요? (y/n)
if /i "%OPENGH%"=="y" start "" https://github.com/new
echo.
set /p GHID=내 GitHub 아이디를 입력하세요:
if "%GHID%"=="" goto :end

echo.
echo [11-1] 원격 저장소 연결
git remote remove origin >nul 2>&1
git remote add origin https://github.com/%GHID%/my-web-server.git
git remote -v
echo.

echo [11-2] 올리기 ^(처음이면 로그인 창이 뜹니다 - 브라우저로 로그인^)
git push -u origin main
if errorlevel 1 (
  echo.
  echo   [!] 올리기 실패. 자주 있는 원인:
  echo       - 저장소 이름이 다름 ^(github 에서 만든 이름과 같아야 함^)
  echo       - README 체크를 해서 충돌  -^> git pull --rebase origin main 후 다시 push
  echo       - 로그인 취소
  goto :end
)
echo.
echo [성공] 아래 주소를 선생님께 제출하세요:
echo   https://github.com/%GHID%/my-web-server
start "" https://github.com/%GHID%/my-web-server
:end

echo.
echo ============================================================
echo  STEP 11. GitHub 에 올리기 - 끝
echo ============================================================
if not defined NOPAUSE pause
endlocal
