# 증거 02. 터미널 조작 로그 (bash)

요구 항목: 현재 위치 확인 / 목록 확인(숨김 파일 포함) / 이동 / 생성 / 복사 /
이동·이름 변경 / 삭제 / 파일 내용 확인 / 빈 파일 생성.

실습은 `.lab-terminal` 폴더를 새로 만들어 그 안에서만 진행하고 마지막에 지웁니다.
**절대 경로**는 맨 앞 `/` 부터 시작하는 전체 주소(bash 에서 윈도우 `D:` 는 `/d`),
**상대 경로**는 지금 위치를 기준으로 한 짧은 주소(`./`, `..`)입니다.

```text
$ pwd
/d/22.코드아카데미/dev-workstation-mission
```

```text
$ ls -la | head -n 15
total 60
drwxr-xr-x 1 lovehjlee 197121     0 Nov  3 22:59 .
drwxr-xr-x 1 lovehjlee 197121     0 Nov  3 20:01 ..
-rw-r--r-- 1 lovehjlee 197121    95 Nov  3 22:19 .dockerignore
-rw-r--r-- 1 lovehjlee 197121   736 Nov  3 22:25 .env
-rw-r--r-- 1 lovehjlee 197121   716 Nov  3 22:19 .env.example
drwxr-xr-x 1 lovehjlee 197121     0 Nov  3 22:59 .git
-rw-r--r-- 1 lovehjlee 197121   533 Nov  3 22:19 .gitattributes
-rw-r--r-- 1 lovehjlee 197121   197 Nov  3 22:19 .gitignore
-rw-r--r-- 1 lovehjlee 197121   751 Nov  3 20:28 Dockerfile
-rw-r--r-- 1 lovehjlee 197121 24974 Nov  3 22:35 README.md
drwxr-xr-x 1 lovehjlee 197121     0 Nov  3 22:59 app
drwxr-xr-x 1 lovehjlee 197121     0 Nov  3 22:33 commands
drwxr-xr-x 1 lovehjlee 197121     0 Nov  3 22:19 config
-rw-r--r-- 1 lovehjlee 197121  2625 Nov  3 22:19 docker-compose.yml
```

```text
$ mkdir -p .lab-terminal && cd .lab-terminal && pwd
/d/22.코드아카데미/dev-workstation-mission/.lab-terminal
```

```text
$ touch empty.txt && ls -l empty.txt
-rw-r--r-- 1 lovehjlee 197121 0 Nov  3 23:00 empty.txt
```

```text
$ echo "hello docker" > hello.txt && cat hello.txt
hello docker
```

```text
$ cp hello.txt copy.txt && ls
copy.txt
empty.txt
hello.txt
```

```text
$ mv copy.txt renamed.txt && ls
empty.txt
hello.txt
renamed.txt
```

```text
$ mkdir -p sub && mv renamed.txt ./sub/ && ls -R
.:
empty.txt
hello.txt
sub

./sub:
renamed.txt
```

```text
$ rm ./sub/renamed.txt && ls -R
.:
empty.txt
hello.txt
sub

./sub:
```

```text
$ rm -rf .lab-terminal && ls -a | grep lab-terminal ; echo "exit-code=$?  (1 이면 완전히 지워진 것)"
exit-code=1  (1 이면 완전히 지워진 것)
```

| bash | PowerShell 로 치면 | 하는 일 |
|---|---|---|
| `pwd` | `Get-Location` | 지금 위치 |
| `ls -la` | `Get-ChildItem -Force` | 숨김 포함 목록 |
| `mkdir -p` | `New-Item -ItemType Directory` | 폴더 만들기 |
| `touch` | `New-Item -ItemType File` | 빈 파일 만들기 |
| `cat` | `Get-Content` | 내용 보기 |
| `cp` / `mv` / `rm` | `Copy-Item` / `Move-Item` / `Remove-Item` | 복사 / 이동·이름변경 / 삭제 |

