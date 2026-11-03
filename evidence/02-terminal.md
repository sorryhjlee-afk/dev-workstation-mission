# 증거 02. 터미널 조작 로그

요구 항목: 현재 위치 확인 / 목록 확인(숨김 파일 포함) / 이동 / 생성 / 복사 /
이동·이름 변경 / 삭제 / 파일 내용 확인 / 빈 파일 생성.
실습은 `.lab-terminal` 폴더를 새로 만들어 그 안에서만 진행하고 마지막에 지웁니다.

```text
$ Get-Location
Path                                
----                                
D:\22.코드아카데미\dev-workstation-mission
```

**절대 경로**는 `C:`처럼 드라이브부터 시작하는 전체 주소, **상대 경로**는 지금 위치를 기준으로 한 짧은 주소입니다.

```text
$ Get-ChildItem -Force | Select-Object Mode, Length, Name
Mode   Length Name         
----   ------ ----         
d--h--        .git         
d-----        app          
d-----        commands     
d-----        config       
d-----        evidence     
-a---- 63     .dockerignore
-a---- 123    .gitignore   
-a---- 751    Dockerfile   
-a---- 8647   README.md
```

```text
$ New-Item -ItemType Directory -Path .lab-terminal -Force | Select-Object FullName
FullName                                          
--------                                          
D:\22.코드아카데미\dev-workstation-mission\.lab-terminal
```

```text
$ Set-Location .\.lab-terminal ; Get-Location
Path                                              
----                                              
D:\22.코드아카데미\dev-workstation-mission\.lab-terminal
```

```text
$ New-Item -ItemType File -Name empty.txt | Select-Object Name, Length
Name      Length
----      ------
empty.txt      0
```

```text
$ Set-Content -Path hello.txt -Value "hello docker" -Encoding UTF8 ; Get-Content hello.txt
hello docker
```

```text
$ Copy-Item hello.txt copy.txt ; Get-ChildItem -Name
copy.txt
empty.txt
hello.txt
```

```text
$ Rename-Item copy.txt renamed.txt ; Get-ChildItem -Name
empty.txt
hello.txt
renamed.txt
```

```text
$ New-Item -ItemType Directory -Name sub | Out-Null ; Move-Item renamed.txt .\sub\ ; Get-ChildItem -Recurse -Name
sub
empty.txt
hello.txt
sub\renamed.txt
```

```text
$ Remove-Item .\sub\renamed.txt ; Get-ChildItem -Recurse -Name
sub
empty.txt
hello.txt
```

```text
$ Set-Location .. ; Get-Location
Path                                
----                                
D:\22.코드아카데미\dev-workstation-mission
```

```text
$ Remove-Item .lab-terminal -Recurse -Force ; Test-Path .lab-terminal
False
```
