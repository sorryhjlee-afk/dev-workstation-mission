# 증거 03. 권한 실습 (파일 1개 + 디렉토리 1개)

권한은 "누가 이 파일을 읽고(r) / 쓰고(w) / 실행할(x) 수 있는가" 를 정해 둔 것입니다.

- **Linux** : `chmod` 로 숫자 3자리를 씁니다. r=4, w=2, x=1 을 더하고 순서는 **소유자 / 그룹 / 나머지** 입니다.
- **Windows** : `icacls` 로 봅니다. F=모두 가능, M=수정, RX=읽기+실행, (I)=상위 폴더에서 물려받음

| 숫자 | 소유자 | 그룹 | 나머지 | 뜻 |
|---|---|---|---|---|
| `644` | 6 = 읽기+쓰기 | 4 = 읽기 | 4 = 읽기 | 실행(x)이 없어서 **실행 불가** |
| `755` | 7 = 읽기+쓰기+실행 | 5 = 읽기+실행 | 5 = 읽기+실행 | 누구나 읽고 실행 가능 |
| `700` | 7 = 전부 가능 | 0 = 불가 | 0 = 불가 | **주인만** 쓸 수 있음 |

리눅스 권한 실습은 **ubuntu 컨테이너 안에서** 했습니다. 윈도우에 리눅스를 따로 깔지 않아도
CLI 만으로 누구나 똑같이 재현할 수 있습니다. 실습 내용은 `labs/permission-lab.sh` 에 있습니다.

## 3-1. 호스트 쪽 권한 보기 (파일 1개 / 디렉토리 1개)

```text
$ ls -l Dockerfile
-rw-r--r-- 1 lovehjlee 197121 751 Nov  3 20:28 Dockerfile
```

```text
$ ls -ld config
drwxr-xr-x 1 lovehjlee 197121 0 Nov  3 22:19 config
```

Git Bash 의 `ls -l` 은 윈도우 권한을 리눅스 모양으로 흉내 내어 보여 줍니다.
윈도우의 진짜 권한(ACL)은 `icacls` 로 봅니다.

> `icacls` 의 마지막 한글 안내 줄은 윈도우 CP949 인코딩으로 나오기 때문에,
> 이 문서에 담을 때만 `| iconv -f CP949 -t UTF-8` 을 붙여 UTF-8 로 바꿈습니다.
> 터미널 화면에서 그냥 볼 때는 필요 없습니다.

```text
$ icacls Dockerfile
Dockerfile BUILTIN\Administrators:(I)(F)
           NT AUTHORITY\SYSTEM:(I)(F)
           NT AUTHORITY\Authenticated Users:(I)(M)
           BUILTIN\Users:(I)(RX)

1 파일을 처리했으며 0 파일은 처리하지 못했습니다.
```

```text
$ icacls config
config BUILTIN\Administrators:(I)(F)
       BUILTIN\Administrators:(I)(OI)(CI)(IO)(F)
       NT AUTHORITY\SYSTEM:(I)(F)
       NT AUTHORITY\SYSTEM:(I)(OI)(CI)(IO)(F)
       NT AUTHORITY\Authenticated Users:(I)(M)
       NT AUTHORITY\Authenticated Users:(I)(OI)(CI)(IO)(M)
       BUILTIN\Users:(I)(RX)
       BUILTIN\Users:(I)(OI)(CI)(IO)(GR,GE)

1 파일을 처리했으며 0 파일은 처리하지 못했습니다.
```


## 3-2. Linux 권한 변경 전 / 후 (ubuntu 컨테이너)

> `/labs` 처럼 `/` 로 시작하는 경로가 윈도우 경로로 바뀌지 않도록
> 터미널에서 `export MSYS_NO_PATHCONV=1` 을 먼저 실행했습니다.

```text
$ docker run --rm -v "$(pwd)/labs:/labs" ubuntu:24.04 bash /labs/permission-lab.sh
=== 준비 : 실습용 파일과 폴더 만들기 ===
total 12
drwxr-xr-x 2 root root 4096 Nov  3 14:00 mydir
-rw-r--r-- 1 root root    6 Nov  3 14:00 myfile.txt
-rw-r--r-- 1 root root   19 Nov  3 14:00 run-demo.sh

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

**읽는 법**

- (1) 에서 `run-demo.sh = 644 (-rw-r--r--)` → `x` 가 하나도 없습니다.
- (2) 그래서 실행하면 **Permission denied**, 종료 코드 **126** 이 납니다.
- (3) `chmod 755` 후 `-rwxr-xr-x` 로 바뀌며 `x` 가 생겼습니다. 디렉토리는 `700 (drwx------)`.
- (4) 같은 스크립트가 이제 정상 실행되어 `permission-ok` 가 출력됩니다.
- (5) 디렉토리를 `700` 으로 바꿨기 때문에 다른 사용자(tester)는 **Permission denied** 입니다.

