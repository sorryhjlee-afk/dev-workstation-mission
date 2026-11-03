# 증거 04. Docker 설치 및 기본 점검

Docker 가 설치되어 있고 엔진(데몬)이 실제로 동작하는지 확인합니다.

```text
$ docker --version
Docker version 29.9.2, build a82e528
```

```text
$ docker info --format "ServerVersion={{.ServerVersion}} / OS={{.OperatingSystem}} / Kernel={{.KernelVersion}} / CPUs={{.NCPU}} / Memory={{.MemTotal}}"
ServerVersion=29.9.2 / OS=Docker Desktop / Kernel=6.18.54.1-microsoft-standard-WSL2 / CPUs=16 / Memory=16303161344
```

> `docker info` 전체 출력은 매우 길어서 핵심만 뽑았습니다. 전체를 보려면 그냥 `docker info` 를 치면 됩니다.

```text
$ docker info --format "{{json .}}" | ConvertFrom-Json | Select-Object ServerVersion, Containers, ContainersRunning, Images, Driver | Format-List
ServerVersion     : 29.9.2
Containers        : 0
ContainersRunning : 0
Images            : 4
Driver            : overlayfs
```
