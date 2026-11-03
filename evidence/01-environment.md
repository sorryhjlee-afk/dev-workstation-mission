# 증거 01. 실행 환경

VS Code 통합 터미널(PowerShell)에서 확인한 실행 환경입니다.

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
The term 'code' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
```


> $PSVersionTable 은 PowerShell 자체 변수라 출력이 표 형태입니다.

```text
$ $PSVersionTable.PSVersion.ToString()
5.1.26100.9711
```

```text
$ (Get-CimInstance Win32_OperatingSystem).Caption + " build " + (Get-CimInstance Win32_OperatingSystem).BuildNumber
Microsoft Windows 11 Pro build 26200
```
