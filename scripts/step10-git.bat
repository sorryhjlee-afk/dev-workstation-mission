@echo off
chcp 949 >nul
setlocal
set "PATH=%PATH%;C:\Program Files\Docker\Docker\resources\bin"
set "PROJ=C:\study\my-web-server"
title STEP 10. Git 설정과 첫 커밋
echo ============================================================
echo  STEP 10. Git 설정과 첫 커밋
echo ============================================================
echo.

cd /d "%PROJ%"

echo [10-1] 내 정보 등록 ^(한 번만 하면 됩니다^)
echo.
set /p GNAME=GitHub 사용자 이름을 입력하세요:
set /p GMAIL=GitHub 가입 이메일을 입력하세요:
if "%GNAME%"=="" goto :skipcfg
git config --global user.name "%GNAME%"
git config --global user.email "%GMAIL%"
git config --global init.defaultBranch main
echo   -^> 등록 완료
:skipcfg
echo.
echo [10-2] 현재 설정 확인
git config --global --list | findstr /C:"user." /C:"init."
echo.

echo [10-3] 저장소 만들기
if exist .git (
  echo   -^> 이미 git 저장소입니다.
) else (
  git init
)
echo.

echo [10-4] 상태 확인
git status --short
echo.

echo [10-5] 전부 담고 저장 ^(커밋^)
git add .
git commit -m "feat: 첫 웹 서버 컨테이너 과제 제출"
echo.

echo [10-6] 브랜치 이름을 main 으로
git branch -M main
git branch --show-current
echo.

echo [10-7] 기록 확인
git log --oneline
echo.
echo [성공 확인] 커밋 한 줄이 보이고 브랜치가 main 이면 OK!

echo.
echo ============================================================
echo  STEP 10. Git 설정과 첫 커밋 - 끝
echo ============================================================
if not defined NOPAUSE pause
endlocal
