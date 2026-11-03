# 🐳 개발 워크스테이션 구축 미션 — Docker 웹 서버

터미널·권한부터 Dockerfile 빌드, 포트 매핑, 바인드 마운트, 볼륨 영속성, Git·GitHub 연동까지
직접 실행하고 그 결과를 기록한 저장소입니다.
**모든 명령은 실제로 실행해서 출력을 확인했습니다** — 문서의 출력은 꾸며 쓴 예시가 아닙니다.

> 처음 하는 사람은 [docs/도커미션_따라하기_가이드.pdf](docs/도커미션_따라하기_가이드.pdf) (41쪽)를 먼저 보세요.
> 명령을 직접 치기 어렵다면 [scripts/](scripts/) 의 **배치 파일을 더블클릭**하면 단계별로 따라갈 수 있습니다.

---

## 1. 실행 환경

| 항목 | 값 | 확인 명령 |
|---|---|---|
| OS | Windows 11 Pro, build 26200 | `winver` |
| 쉘 / 터미널 | Windows PowerShell 5.1, cmd.exe | `$PSVersionTable.PSVersion` |
| Docker | **29.9.2** (build a82e528), Docker Desktop 4.97.0 | `docker --version` |
| Docker Compose | **v5.6.1** | `docker compose version` |
| 엔진 백엔드 | WSL2 · Linux 6.18.54.1-microsoft-standard-WSL2 | `docker info` |
| 웹 서버 | nginx 1.31.8 (`nginx:latest`) | `docker logs my-site` |
| Git | **2.54.0.windows.1** | `git --version` |
| 에디터 | Visual Studio Code | — |

## 2. 폴더 구조

```
dev-workstation-mission/
├── app/
│   └── index.html                  # 웹 서버 소스코드
├── Dockerfile                      # 이미지 레시피
├── .dockerignore / .gitignore
├── templates/                      # 배치 파일이 복사해 쓰는 원본 (UTF-8)
├── scripts/                        # STEP 별 배치 파일 (더블클릭 실행)
│   ├── run-all.bat                 #  ← 메뉴에서 번호만 고르면 됨
│   ├── step01-terminal.bat ... step12-cleanup.bat
└── docs/
    ├── 도커미션_따라하기_가이드.pdf   # 41쪽 그림 설명서
    ├── verification-log.md         # 실제 실행 출력 전문
    └── images/                     # 접속 화면 증거
```

## 3. 수행 항목 체크리스트

| 확인 | 항목 | 증거 |
|---|---|---|
| [x] | 터미널 기본 조작 (`pwd`/`cd`/`mkdir`/`dir`/`type`) | [검증 로그 §2](docs/verification-log.md) · `scripts/step01-terminal.bat` |
| [x] | 권한 확인 (`whoami`/`icacls`/관리자 권한/실행 정책) | [검증 로그 §2](docs/verification-log.md) · `step02` |
| [x] | Docker 설치 점검 (`--version`/`info`/`hello-world`) | [검증 로그 §1](docs/verification-log.md) · `step03` |
| [x] | Dockerfile 작성·빌드 (`my-web-server`) | [Dockerfile](Dockerfile) · [로그 §3](docs/verification-log.md) · `step05`,`step06` |
| [x] | 포트 매핑 접속 (8081→80), HTTP 200 | [접속 화면](docs/images/port-8081.jpg) · [로그 §4](docs/verification-log.md) |
| [x] | 운영 명령 (`images`/`ps -a`/`logs`/`stats`/`inspect`/`exec`/`stop`/`start`) | [로그 §5](docs/verification-log.md) · `step07` |
| [x] | 바인드 마운트 반영 (변경 전/후 비교) | [전](docs/images/bind-before.jpg)/[후](docs/images/bind-after.jpg) · [로그 §6](docs/verification-log.md) |
| [x] | 볼륨 영속성 (컨테이너 삭제 전/후) | [로그 §7](docs/verification-log.md) · [웹 확인](docs/images/volume-memo.png) |
| [x] | 에러 재현 및 해결 (포트 충돌·이름 중복·404) | [로그 §8](docs/verification-log.md) · 아래 6절 |
| [x] | Git 설정·커밋·main 브랜치 | [로그 §9](docs/verification-log.md) · `step10` |
| [x] | GitHub / VSCode 연동 | `step11-github.bat` |

## 4. 실행 방법

### 방법 A — 배치 파일 (추천)

`scripts\run-all.bat` 을 더블클릭하고 번호를 고릅니다.

```
 1. STEP 1  터미널 기본 조작        7. STEP 7  운영 명령 로그 모으기
 2. STEP 2  권한 확인               8. STEP 8  바인드 마운트 (8083)
 3. STEP 3  도커 설치 점검          9. STEP 9  볼륨 영속성 (8082)
 4. STEP 4  프로젝트 만들기        10. STEP 10 Git 설정과 첫 커밋
 5. STEP 5  Dockerfile 확인        11. STEP 11 GitHub 에 올리기
 6. STEP 6  빌드-실행-접속 (8081)  12. STEP 12 뒷정리
```

각 배치 파일은 **무엇을 왜 하는지 설명을 출력한 뒤 명령을 실행**하고, 성공 조건을 알려줍니다.
여러 번 실행해도 괜찮도록 기존 컨테이너를 먼저 정리합니다.

### 방법 B — 직접 입력

```powershell
git clone https://github.com/<내아이디>/dev-workstation-mission.git
cd dev-workstation-mission
docker build -t my-web-server .
docker run -d -p 8081:80 --name my-site my-web-server
curl.exe -s -o NUL -w "%{http_code}" http://localhost:8081/   # 200
# 브라우저에서 http://localhost:8081
```

## 5. 포트 사용 계획

| 포트 | 컨테이너 | 목적 |
|---|---|---|
| 8080 | `my-final-web` | 공식 nginx 그대로 실행 (비교용) |
| 8081 | `my-site` | **Dockerfile 로 만든 내 웹 서버 (제출 증거)** |
| 8082 | `vol-test2` | 볼륨 영속성 실습 |
| 8083 | `live-site` | 바인드 마운트 실습 |

한 포트에는 하나만 바인딩할 수 있으므로, 실습용은 비어 있는 번호를 씁니다.

## 6. 트러블슈팅

### ① WSL 미설치로 도커 엔진이 뜨지 않음
- **문제**: Docker Desktop 설치 성공 후에도 `Error response from daemon: Docker Desktop is unable to start`
- **원인 가설**: Docker는 리눅스 엔진 위에서 동작하는데 WSL2가 설치되지 않음
- **확인**: `wsl --version` → "Linux용 Windows 하위 시스템이 설치되어 있지 않습니다"
- **해결**: 관리자 PowerShell에서 `wsl --install --no-distribution` → 재부팅 → `docker info` 로 `Server Version: 29.9.2` 확인

### ② 호스트 포트 충돌
- **문제**: `Bind for 0.0.0.0:8080 failed: port is already allocated`
- **원인 가설**: 8080을 `my-final-web` 이 이미 점유
- **확인**: `docker ps` → PORTS 열에 `0.0.0.0:8080->80/tcp`
- **해결**: 8081로 변경해 재실행 → HTTP 200. (대안: `docker stop my-final-web` 후 8080 재사용)

### ③ 컨테이너 이름 중복
- **문제**: `Conflict. The container name "/my-site" is already in use`
- **원인 가설**: 정지 상태여도 이름은 계속 점유됨
- **확인**: `docker ps -a` 에서 동일 이름 발견
- **해결**: `docker rm -f my-site` 후 재실행. 배치 파일에는 이 정리 단계를 미리 넣어 두었습니다.

### ④ PowerShell 스크립트가 한글을 깨뜨림
- **문제**: 스크립트로 `index.html` 을 수정하자 웹페이지가 `?댐꿨?샗꽭??` 로 표시됨
- **원인 가설**: Windows PowerShell 5.1이 **BOM 없는 UTF-8 스크립트를 ANSI(CP949)로 해석**
- **확인**: 같은 이미지로 만든 8081(정상)과 8083(깨짐)을 비교 → 파일 내용 자체가 깨진 것을 확인
- **해결**: 파일 입출력 시 인코딩을 명시. 배치 파일은 한글 파일을 `echo` 로 만들지 않고 `templates/` 에서 **복사**하도록 설계해 이 문제를 원천 차단했습니다.

### ⑤ 콘솔에서 UTF-8 파일이 깨져 보임
- **문제**: 배치 파일에서 `type Dockerfile` 실행 시 한글 주석이 깨짐
- **원인 가설**: 파일은 UTF-8인데 콘솔 코드페이지는 CP949
- **확인**: PowerShell로 같은 파일을 읽으면 정상 출력
- **해결**: `powershell -NoProfile -Command "Get-Content -Encoding UTF8 ..."` 로 출력. `docker --format` 문자열에도 한글을 넣지 않도록 수정했습니다.

### ⑥ 재부팅하면 컨테이너가 꺼져 있음
- **문제**: 재부팅 후 모든 컨테이너가 `Exited (255)`
- **원인 가설**: `--restart` 정책을 주지 않아 자동 시작 대상이 아님
- **확인**: `docker ps -a` 로 상태 확인
- **해결**: `docker start my-final-web my-site vol-test2 live-site`. 항상 켜두려면 `--restart unless-stopped` 옵션을 주고 실행합니다.

## 7. 배운 점

- **이미지 ≠ 컨테이너**: 이미지는 레시피, 컨테이너는 그 레시피로 만든 실제 요리.
- **COPY vs 바인드 마운트**: 같은 이미지라도 8081(COPY)은 빌드 시점 사본, 8083(바인드)은 호스트 실시간 반영.
- **컨테이너는 지우면 끝, 볼륨은 남는다**: 지켜야 할 데이터는 반드시 볼륨에.
- **에러 메시지는 끝 줄부터 읽는다**: 길어 보여도 핵심은 `port is already allocated` 한 줄.

## 8. 뒷정리

```powershell
docker rm -f live-site vol-test2
docker volume rm my-volume
docker image rm my-web-server
```

`scripts\step12-cleanup.bat` 를 실행해도 됩니다. 제출 증거인 `my-site`(8081)는 남겨 둡니다.
