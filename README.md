# 개발 워크스테이션 구축 미션

VS Code 터미널(CLI)만으로 **터미널 조작 → 권한 → Docker → 커스텀 이미지 → 포트 매핑 → 바인드 마운트 → 볼륨 → Git/GitHub** 전 과정을 수행하고, 명령과 출력을 그대로 기록한 저장소입니다.

> **한눈에 보기**
> - 만든 것 : 공식 `nginx` 를 바탕으로 **내가 고친 커스텀 이미지** `my-web-server:1.0`
> - 확인한 것 : 포트 **8080 / 8081** 접속 성공, 바인드 마운트 **8082** 실시간 반영, 볼륨 **8083** 삭제 후에도 데이터 유지
> - 증거 위치 : [`evidence/`](evidence/) 폴더 (명령 + 출력이 **한 쌍으로** 들어 있습니다)
> - 따라하기 : [`commands/`](commands/) 폴더의 텍스트 파일을 **복사해 붙여넣기만** 하면 됩니다

---

## 1) 실행 환경

| 항목 | 값 | 확인 명령 |
|---|---|---|
| OS | Windows 11 Pro (build 26200) | `(Get-CimInstance Win32_OperatingSystem).Caption` |
| 쉘 / 터미널 | **VS Code 통합 터미널** – Windows PowerShell 5.1.26100.9711 | `$PSVersionTable.PSVersion` |
| Docker | **29.9.2** (build a82e528) / Docker Desktop 4.97.0 | `docker --version` |
| Docker Compose | v5.6.1 | `docker compose version` |
| 컨테이너 엔진 | WSL2 backend · Linux 6.18.54.1-microsoft-standard-WSL2 | `docker info` |
| Git | **2.54.0.windows.1** | `git --version` |
| 에디터 | Visual Studio Code | `code --version` |
| 웹 서버 | nginx 1.31.8 (`nginx:latest` 기반) | `curl.exe -I http://localhost:8080/` |

전체 출력 → [`evidence/01-environment.md`](evidence/01-environment.md)

---

## 2) 수행 체크리스트

과제의 **기능 요구사항 11개** 기준입니다. 모두 이 PC에서 실제로 실행해 출력을 확인했습니다.

| # | 요구사항 | 완료 | 증거 | 따라하기 |
|---|---|---|---|---|
| 1 | 제출 저장소 및 기술 문서 | [x] | 이 README | — |
| 2 | 터미널 조작 로그 (위치/목록(숨김)/이동/생성/복사/이름변경/삭제/내용확인/빈 파일) | [x] | [02-terminal.md](evidence/02-terminal.md) | [02-terminal.txt](commands/02-terminal.txt) |
| 3 | 권한 실습 (파일 1개 + 디렉토리 1개, 변경 전/후) | [x] | [03-permission.md](evidence/03-permission.md) | [03-permission.txt](commands/03-permission.txt) |
| 4 | Docker 설치 및 기본 점검 (`--version`, `info`) | [x] | [04-docker-check.md](evidence/04-docker-check.md) | [04-docker-check.txt](commands/04-docker-check.txt) |
| 5 | Docker 기본 운영 명령 (`images`/`ps`/`ps -a`/`logs`/`stats`) | [x] | [05-docker-ops.md](evidence/05-docker-ops.md) | [05-docker-ops.txt](commands/05-docker-ops.txt) |
| 6 | 컨테이너 실행 실습 (hello-world, ubuntu 내부 `ls`/`echo`, exec vs attach) | [x] | [06-container-lab.md](evidence/06-container-lab.md) | [06-container-lab.txt](commands/06-container-lab.txt) |
| 7 | 기존 Dockerfile 기반 **커스텀 이미지** 제작 | [x] | [07-custom-image.md](evidence/07-custom-image.md) · [Dockerfile](Dockerfile) | [07-custom-image.txt](commands/07-custom-image.txt) |
| 8 | 포트 매핑 및 접속 증거 (서로 다른 포트 2개) | [x] | [08-port-mapping.md](evidence/08-port-mapping.md) · [화면](#8-포트-매핑-접속-증거) | [08-port-mapping.txt](commands/08-port-mapping.txt) |
| 9 | Docker 볼륨 영속성 검증 (삭제 전/후) | [x] | [10-volume.md](evidence/10-volume.md) | [10-volume.txt](commands/10-volume.txt) |
| 10 | Git 설정 및 GitHub 연동 (`git config --list`) | [x] | [11-git-github.md](evidence/11-git-github.md) | [11-git-github.txt](commands/11-git-github.txt) |
| 11 | 보안 및 개인정보 보호 (마스킹) | [x] | [아래 13절](#13-보안과-개인정보-보호) | — |
| ＋ | 바인드 마운트 반영 (호스트 변경 전/후) | [x] | [09-bind-mount.md](evidence/09-bind-mount.md) | [09-bind-mount.txt](commands/09-bind-mount.txt) |

---

## 3) 폴더 구조

```text
dev-workstation-mission/
├── app/
│   └── index.html              # 웹 서버 소스코드 (커스텀 콘텐츠)
├── config/
│   └── default.conf            # 교체한 nginx 설정 (커스텀 포인트)
├── labs/
│   └── permission-lab.sh       # 리눅스 권한 실습 스크립트
├── commands/                   # ★ VS Code 터미널에 복사해 붙여넣는 명령 모음
│   ├── 00-README.txt
│   └── 01-environment.txt ~ 99-cleanup.txt
├── evidence/                   # ★ 실제 실행한 명령 + 출력
│   ├── 01-environment.md ~ 11-git-github.md
│   └── images/                 # 주소창이 보이는 브라우저 캡처
├── Dockerfile
├── .dockerignore / .gitignore
└── README.md
```

---

## 4) 따라 하는 방법 (VS Code 기준)

```text
1. VS Code 실행 → 파일 → 폴더 열기 → 이 저장소 폴더 선택
2. 메뉴 [터미널] → [새 터미널]        (단축키 : Ctrl + ` )
3. commands/ 폴더의 파일을 01번부터 순서대로 열고
   안에 있는 명령을 한 줄씩 복사 → 터미널에 붙여넣기 → Enter
```

`#` 으로 시작하는 줄은 설명이라 같이 복사해도 실행되지 않습니다.
평가자가 처음부터 재현하려면 아래 네 줄이면 충분합니다.

```powershell
git clone https://github.com/sorryhjlee-afk/dev-workstation-mission.git
cd dev-workstation-mission
docker build -t my-web-server:1.0 .
docker run -d -p 8080:80 --name web-8080 my-web-server:1.0
```

> **경로에 대하여** — 이 문서의 명령은 모두 **저장소 폴더 안에서** 실행합니다.
> `${PWD}` 는 "지금 있는 폴더"를 뜻하므로 저장소를 어디에 내려받아도 그대로 동작합니다.
> 특정 PC 경로(`C:\...`)에 의존하는 명령은 사용하지 않았습니다.

---

## 5) 수행 로그 (발췌)

전체 로그는 [`evidence/`](evidence/) 에 있습니다. 아래는 핵심만 뽑은 것입니다.

### 5-1. 터미널 조작

```text
$ Get-Location
Path
----
D:\22.코드아카데미\dev-workstation-mission

$ New-Item -ItemType File -Name empty.txt
Name        Length
----        ------
empty.txt        0

$ Copy-Item hello.txt copy.txt ; Rename-Item copy.txt renamed.txt
$ Move-Item renamed.txt .\sub\ ; Get-ChildItem -Recurse -Name
sub
empty.txt
hello.txt
sub\renamed.txt
```

### 5-2. 권한 변경 전 / 후 (리눅스)

```text
=== (1) 변경 전 권한 ===
run-demo.sh = 644 (-rw-r--r--)
mydir = 755 (drwxr-xr-x)

=== (2) 실행 권한이 없는 스크립트를 실행하면? ===
/labs/permission-lab.sh: line 19: ./run-demo.sh: Permission denied
exit-code=126

=== (3) 권한 변경 : 파일 644 -> 755 , 디렉토리 755 -> 700 ===
run-demo.sh = 755 (-rwxr-xr-x)
mydir = 700 (drwx------)

=== (4) 변경 후 : 같은 스크립트가 이제 실행된다 ===
permission-ok
exit-code=0

=== (5) 디렉토리 700 의 의미 : 다른 사용자는 못 들어간다 ===
ls: cannot open directory '/lab/mydir': Permission denied
exit-code=2
```

### 5-3. 컨테이너 실행 / exec vs attach

```text
$ docker run --rm hello-world
Hello from Docker!
This message shows that your installation appears to be working correctly.

$ docker exec lab-ubuntu bash -c "echo hello-from-container; head -2 /etc/os-release"
hello-from-container
PRETTY_NAME="Ubuntu 24.04.5 LTS"
NAME="Ubuntu"

$ docker attach --no-stdin lab-attach
main-process-finished

$ docker ps -a --filter name=lab-attach --format "{{.Names}} / {{.Status}}"
lab-attach / Exited (0) 1 second ago        ← attach 는 주 프로세스가 끝나면 컨테이너도 멈춘다

$ docker ps -a --filter name=lab-ubuntu --format "{{.Names}} / {{.Status}}"
lab-ubuntu / Up 20 seconds                  ← exec 만 쓴 컨테이너는 계속 살아 있다
```

### 5-4. 빌드와 운영 명령

```text
$ docker build -t my-web-server:1.0 .
#6 [3/3] COPY app/ /usr/share/nginx/html/
#7 naming to docker.io/library/my-web-server:1.0 done

$ docker images my-web-server
IMAGE                 ID             DISK USAGE   CONTENT SIZE
my-web-server:1.0     ...                 241MB         63.9MB

$ docker stats --no-stream ops-demo
CONTAINER ID   NAME       CPU %   MEM USAGE / LIMIT     MEM %   PIDS
...            ops-demo   0.00%   13.9MiB / 15.18GiB    0.09%   17
```

---

## 6) Dockerfile 선택과 커스텀 포인트

**선택한 방식 : (A) 웹 서버 베이스 이미지 활용** — 공식 `nginx:latest` 를 바탕으로 삼고
정적 콘텐츠와 설정을 내 것으로 교체했습니다. (언어 런타임이 필요 없는 가장 단순한 구성)

```dockerfile
FROM nginx:latest                                    # 바탕 이미지
LABEL org.opencontainers.image.title="my-web-server" # 이름표
ENV APP_ENV=dev                                      # 커스텀 ①
COPY config/default.conf /etc/nginx/conf.d/default.conf   # 커스텀 ②
COPY app/ /usr/share/nginx/html/                     # 커스텀 ③
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

| 커스텀 포인트 | 목적 | 확인 방법 |
|---|---|---|
| ① `ENV APP_ENV=dev` | 개발용 환경이라는 표시를 환경 변수로 넣는다 | `docker exec web-8080 printenv APP_ENV` → `dev` |
| ② nginx 설정 교체 | 응답 헤더 `X-Mission` 추가, `/data/` 목록 보기 허용 | 응답 헤더에 `X-Mission: codyssey-m1` |
| ③ 정적 콘텐츠 교체 | 기본 안내 페이지를 내가 만든 한국어 페이지로 | 브라우저 화면 |

빌드·확인 출력 → [`evidence/07-custom-image.md`](evidence/07-custom-image.md)

```text
$ docker image inspect my-web-server:1.0 --format "Env={{.Config.Env}}"
Env=[PATH=... NGINX_VERSION=1.31.8 ... APP_ENV=dev]
```

---

## 7) 포트 매핑이 필요한 이유

컨테이너는 **자기만의 네트워크**를 가집니다. 컨테이너 안의 nginx 는 언제나 **80번**을 쓰는데,
내 컴퓨터의 80번은 하나뿐이라 여러 개를 동시에 띄울 수 없습니다.
그래서 **바깥쪽(호스트) 번호만 다르게** 주고 안쪽 80번으로 연결합니다.

```text
브라우저 → 내 컴퓨터 8080 ─┐
                           ├→ (같은 이미지로 만든 서로 다른 컨테이너) → 각자의 80번 → index.html
브라우저 → 내 컴퓨터 8081 ─┘
```

---

## 8) 포트 매핑 접속 증거

```text
$ docker ps
NAMES       STATUS         PORTS
web-8080    Up 2 seconds   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp
web-8081    Up 1 second    0.0.0.0:8081->80/tcp, [::]:8081->80/tcp

$ curl.exe -s -D - -o NUL http://localhost:8080/
HTTP/1.1 200 OK
Server: nginx/1.31.8
Content-Length: 995
X-Mission: codyssey-m1          ← 내가 교체한 nginx 설정이 적용된 증거

$ curl.exe -s -o NUL -w "http_code=%{http_code}" http://localhost:8080/no-such-page.html
http_code=404
```

**브라우저 접속 화면 (주소창 + 포트 + 응답 화면)**

| 호스트 포트 8080 | 호스트 포트 8081 |
|---|---|
| ![8080 접속](evidence/images/port-8080.png) | ![8081 접속](evidence/images/port-8081.png) |

전체 로그 → [`evidence/08-port-mapping.md`](evidence/08-port-mapping.md)

---

## 9) 바인드 마운트 (호스트 변경 전 / 후)

**바인드 마운트** = 내 컴퓨터 폴더를 컨테이너 안에 그대로 겹쳐 놓는 것.
컨테이너가 내 폴더를 **실시간으로** 보기 때문에 다시 빌드하지 않아도 반영됩니다.

```powershell
docker run -d -p 8082:80 --name bind-8082 -v "${PWD}\app:/usr/share/nginx/html" my-web-server:1.0
```

```text
① 변경 전   8082 <h1>Hello Docker!</h1>        version 1.0
② 호스트의 app\index.html 을 수정 (빌드는 하지 않음)
③ 변경 후   8082 <h1>안녕하세요, 도커!</h1>     version 2.0 (수정됨)
④ 같은 순간 8080 <h1>Hello Docker!</h1>        version 1.0   ← COPY 로 구운 쪽은 그대로
```

같은 이미지인데 결과가 다릅니다. **8082 는 내 폴더를 실시간으로 보고, 8080 은 빌드할 때 복사해 둔 사본을 봅니다.**
전체 로그 → [`evidence/09-bind-mount.md`](evidence/09-bind-mount.md)

---

## 10) 볼륨 영속성 (컨테이너 삭제 전 / 후)

컨테이너는 지우면 안의 내용도 사라집니다. 지켜야 할 자료는 **볼륨**에 넣습니다.

```text
$ docker volume create my-data
$ docker run -d -p 8083:80 --name vol-8083 -v my-data:/usr/share/nginx/html/data my-web-server:1.0
$ docker exec vol-8083 sh -c "echo hello-volume > /usr/share/nginx/html/data/memo.txt"
$ curl.exe -s http://localhost:8083/data/memo.txt
hello-volume

$ docker rm -f vol-8083                       ← ★ 컨테이너를 통째로 삭제
$ docker ps -a --filter name=vol-8083
CONTAINER ID   IMAGE   COMMAND   CREATED   STATUS   PORTS   NAMES
                                                            ← 비어 있음 (완전히 사라짐)

$ docker volume ls --filter name=my-data
DRIVER    VOLUME NAME
local     my-data                             ← 볼륨은 남아 있음

$ docker run -d -p 8083:80 --name vol-8083-new -v my-data:/usr/share/nginx/html/data my-web-server:1.0
$ docker exec vol-8083-new cat /usr/share/nginx/html/data/memo.txt
hello-volume                                  ← 데이터 유지 확인
```

| 삭제 후 새 컨테이너에서 본 화면 | 볼륨 폴더 목록 |
|---|---|
| ![볼륨 메모](evidence/images/volume-memo.png) | ![볼륨 목록](evidence/images/volume-list.png) |

전체 로그 → [`evidence/10-volume.md`](evidence/10-volume.md)

---

## 11) Git 설정 및 GitHub 연동

```text
$ git config --list
user.name=sorryhjlee-afk
user.email=289445261+sorryhjlee-afk@users.noreply.github.com
init.defaultbranch=main
remote.origin.url=https://github.com/sorryhjlee-afk/dev-workstation-mission.git

$ git branch --show-current
main
```

- 이메일은 GitHub 가 제공하는 **noreply 주소**를 사용해 실제 메일 주소가 공개되지 않습니다.
- VS Code 연동 : 왼쪽 아래 계정 아이콘 → **Sign in with GitHub** → 소스 제어 패널에서 커밋/동기화.
- 전체 로그 → [`evidence/11-git-github.md`](evidence/11-git-github.md)

---

## 12) 트러블슈팅

### ① Docker Desktop 은 깔렸는데 엔진이 안 뜬다
- **문제** : `Error response from daemon: Docker Desktop is unable to start`
- **원인 가설** : Docker 는 리눅스 엔진 위에서 도는데 **WSL2 가 설치되지 않음**
- **확인** : `wsl --version` → "Linux용 Windows 하위 시스템이 설치되어 있지 않습니다"
- **해결** : 관리자 PowerShell 에서 `wsl --install --no-distribution` → **재부팅** → `docker info` 로 `ServerVersion` 확인

### ② 호스트 포트 충돌
- **문제** : `Bind for 0.0.0.0:8080 failed: port is already allocated`
- **원인 가설** : 8080 번을 이미 다른 컨테이너가 점유
- **확인** : `docker ps` → PORTS 열에 `0.0.0.0:8080->80/tcp`
- **해결/대안** : 비어 있는 번호로 바꾸거나(`-p 8081:80`), 쓰던 컨테이너를 `docker stop` 으로 내린다

### ③ 컨테이너 이름 중복
- **문제** : `Conflict. The container name "/web-8080" is already in use`
- **원인 가설** : 정지 상태여도 이름은 계속 점유된다
- **확인** : `docker ps -a` 에 같은 이름이 남아 있음
- **해결** : `docker rm -f web-8080` 후 다시 실행

### ④ bash 에 따옴표가 섞인 명령을 넘기면 깨진다
- **문제** : `docker exec ... bash -c "... stat -c '%n %a' ..."` 실행 시 `unexpected EOF` / `syntax error near unexpected token '('`
- **원인 가설** : PowerShell → docker → bash 로 넘어가며 따옴표와 괄호가 두 번 해석된다
- **확인** : 같은 명령을 짧게 줄여 보니 괄호가 포함된 구간에서만 실패
- **해결** : 명령을 **`labs/permission-lab.sh` 파일로 분리**하고 `docker run --rm -v "${PWD}\labs:/labs" ubuntu:24.04 bash /labs/permission-lab.sh` 로 실행. 따옴표 중첩이 사라져 문제가 없어졌고, 다른 사람도 같은 스크립트로 재현할 수 있게 되었다.

### ⑤ 응답 헤더에서 커스텀 설정이 안 보인다
- **문제** : `curl ... | Select-Object -First 8` 결과에 `X-Mission` 헤더가 없음
- **원인 가설** : 설정이 적용되지 않았거나, 출력이 잘렸거나 둘 중 하나
- **확인** : `curl.exe -I` 로 전체 헤더를 보니 `X-Mission` 은 **9번째 줄**, `docker exec web-8080 cat /etc/nginx/conf.d/default.conf` 로 설정도 정상 적용 확인
- **해결** : 앞 8줄만 자르던 것을 없애고 전체 헤더를 기록하도록 수정 (설정은 처음부터 정상이었음)

### ⑥ 재부팅하면 컨테이너가 모두 꺼져 있다
- **문제** : 재부팅 후 `docker ps -a` 가 전부 `Exited (255)`
- **원인 가설** : `--restart` 정책을 주지 않아 자동 시작 대상이 아님
- **확인** : `docker ps -a` 로 상태 확인
- **해결** : `docker start web-8080 web-8081 ...`. 항상 켜 두려면 실행할 때 `--restart unless-stopped` 를 붙인다

---

## 13) 보안과 개인정보 보호

- 비밀번호 · 토큰 · 개인키는 **명령어·문서·스크린샷 어디에도 포함하지 않았습니다.**
- Git 이메일은 GitHub 제공 **noreply 주소**를 사용했습니다.
- 브라우저 캡처는 **빈 임시 프로필(게스트 창)** 로 열어서 찍었습니다. 북마크·확장·로그인 정보가 화면에 없습니다.
- `.gitignore` 로 `.env`, `*.key`, `*.pem`, `secret*` 을 차단했습니다.

---

## 14) 과제 목표 자가 점검

| 설명할 수 있어야 하는 것 | 내 설명 |
|---|---|
| 절대 경로 / 상대 경로 | 절대는 `D:\프로젝트\app` 처럼 드라이브부터 쓰는 전체 주소, 상대는 `.\app` 처럼 지금 자리 기준의 짧은 주소. `..` 는 한 칸 위 폴더 |
| 권한 r/w/x 와 755, 644 | r=4, w=2, x=1 을 더해 **소유자/그룹/나머지** 순으로 적는다. 644 는 실행(x)이 없어 스크립트가 안 돌고(126), 755 로 바꾸면 돈다 |
| 커스텀 이미지 | 공식 이미지를 `FROM` 으로 가져와 `ENV`·설정 파일·정적 콘텐츠를 `COPY` 로 덮어써서 내 이미지를 만든다 |
| 포트 매핑이 필요한 이유 | 컨테이너는 자기만의 네트워크를 쓰므로, `-p 바깥:안쪽` 으로 통로를 만들어야 브라우저가 들어갈 수 있다. 안쪽 80번은 같아도 바깥 번호를 달리하면 여러 개를 동시에 띄울 수 있다 |
| Docker 볼륨 | 컨테이너 바깥에 있는 보관함. 컨테이너를 지워도 남아서, 지켜야 할 데이터를 담는다 |
| Git 과 GitHub 차이 | Git = 내 컴퓨터에서 버전을 관리하는 **프로그램**, GitHub = 그 기록을 올려 공유·협업하는 **웹 서비스** |

---

## 15) 뒷정리

```powershell
docker rm -f web-8080 web-8081 bind-8082 vol-8083-new
docker volume rm my-data
docker image rm my-web-server:1.0
```

[`commands/99-cleanup.txt`](commands/99-cleanup.txt) 와 같은 내용입니다.
