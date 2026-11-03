# ============================================================================
#  commands 폴더 사용법  (VS Code + bash 기준)
# ============================================================================
#  이 폴더의 텍스트 파일은 'VS Code 터미널(bash)에 복사해 붙여넣는 명령 모음' 입니다.
#  모든 명령은 윈도우 PowerShell 이 아니라 **bash** 에서 실행합니다.
#
#  [1. bash 터미널 여는 법]
#   1) VS Code 실행 - 파일 - 폴더 열기 - 이 저장소 폴더 선택
#   2) 메뉴 [터미널] - [새 터미널]   (단축키 : Ctrl + `)
#   3) 터미널 패널 오른쪽 위의 [v] (아래 화살표) 클릭 - 'Git Bash' 선택
#   4) 프롬프트가 이렇게 보이면 성공입니다.
#          사용자@DESKTOP MINGW64 /d/.../dev-workstation-mission
#          $
#      'PS C:\Users\...>' 로 보이면 PowerShell 입니다. 3번을 다시 하세요.
#
#  [1-1. 항상 bash 로 열리게 하기 (한 번만 설정)]
#   Ctrl + Shift + P - "Terminal: Select Default Profile" 검색 - Git Bash 선택
#
#  [1-2. Git Bash 가 목록에 없다면]
#   Git for Windows 가 설치되어 있지 않은 것입니다. https://git-scm.com 에서 설치 후
#   VS Code 를 껐다 켜면 목록에 나타납니다.
#
#  [2. 터미널을 새로 열 때마다 먼저 칠 한 줄 (윈도우만)]
#        export MSYS_NO_PATHCONV=1
#   Git Bash 는 /usr/share/nginx/html 같은 글자를 윈도우 경로로 바꿔 버립니다.
#   이 한 줄을 먼저 실행하면 docker 명령이 정상 동작합니다.
#   (맥/리눅스 bash 에서는 필요 없고, 실행해도 아무 문제 없습니다)
#
#  [3. 순서]
#   01-environment.txt    실행 환경 확인
#   02-terminal.txt       터미널 기본 조작
#   03-permission.txt     권한 실습 (파일 1개 + 디렉토리 1개)
#   04-docker-check.txt   Docker 설치/엔진 점검
#   05-docker-ops.txt     Docker 기본 운영 명령
#   06-container-lab.txt  컨테이너 실행 실습 (hello-world / ubuntu / exec vs attach)
#   07-custom-image.txt   Dockerfile 로 커스텀 이미지 만들기
#   08-port-mapping.txt   포트 매핑 2회 + 브라우저 접속
#   09-bind-mount.txt     바인드 마운트 (변경 전/후)
#   10-volume.txt         볼륨 영속성 (삭제 전/후)
#   11-git-github.txt     Git 설정과 GitHub 연동
#
#   -- 여기까지가 필수입니다. 아래는 보너스(선택) --
#   12-compose.txt        Docker Compose (여러 컨테이너를 한 번에)
#   13-ssh.txt            GitHub SSH 키 설정
#
#   99-cleanup.txt        뒷정리 (선택)
#
#  [4. 규칙]
#   * 위에서부터 순서대로 하세요. 건너뛰면 에러가 납니다.
#   * # 으로 시작하는 줄은 설명입니다. 같이 복사해도 실행되지 않습니다.
#   * 한 줄씩 붙여넣고 Enter. 결과를 눈으로 확인한 뒤 다음 줄로 넘어가세요.
#   * 명령과 출력은 그대로 복사해서 README.md 에 기록하면 그게 '증거' 가 됩니다.
#
#  [5. bash 와 PowerShell, 뭐가 다른가요?]
#   하는 일은 같지만 '쓰는 말' 이 다릅니다. 이 폴더는 전부 bash 말로 적혀 있습니다.
#      목록 보기   : bash  ls -la        /  PowerShell  Get-ChildItem
#      파일 보기   : bash  cat 파일      /  PowerShell  Get-Content
#      지금 위치   : bash  pwd           /  PowerShell  Get-Location
#      접속 테스트 : bash  curl          /  PowerShell  curl.exe
#      없는 곳 버리기 : bash  > /dev/null /  PowerShell  > $null
# ============================================================================
