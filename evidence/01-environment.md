# 증거 01. 실행 환경

**VS Code 통합 터미널 - Git Bash(bash)** 에서 확인한 실행 환경입니다.
PowerShell 이 아니라 bash 를 쓴 것은 과제의 결과 예시(`Shell: bash`)와 맞추기 위해서입니다.

> 윈도우에서 bash 를 쓰는 방법 : VS Code 터미널 패널 오른쪽 위 `[v]` → **Git Bash**

```text
$ echo "$BASH_VERSION"
5.3.9(1)-release
```

```text
$ bash --version | head -n 1
GNU bash, version 5.3.9(1)-release (x86_64-pc-cygwin)
```

```text
$ uname -a
MINGW64_NT-10.0-26200 DESKTOP-1EET513 3.6.7-fb42d713.x86_64 2026-03-29 11:44 UTC x86_64 Msys
```

```text
$ cmd.exe //c ver | head -n 1
Microsoft Windows [Version 10.0.26200.9711]
```

```text
$ docker --version
Docker version 29.9.2, build a82e528
```

```text
$ docker compose version
Docker Compose version v5.6.1
```

```text
$ git --version
git version 2.54.0.windows.1
```

```text
$ code --version
1.143.1
e646868227c3e3a9e3f24277c8c7220be42c0be7
x64
```

| 항목 | 값 |
|---|---|
| OS | Windows 11 Pro (build 26200) |
| 쉘 | **bash** (Git Bash, MINGW64) — VS Code 통합 터미널 |
| 컨테이너 엔진 | Docker Desktop 4.97.0 / WSL2 backend |

