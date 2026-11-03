# 증거 04. Docker 설치 및 기본 점검

Docker 가 설치되어 있고 엔진(데몬)이 실제로 동작하는지 확인합니다.

```text
$ docker --version
Docker version 29.9.2, build a82e528
```

```text
$ docker info --format "ServerVersion={{.ServerVersion}} / OS={{.OperatingSystem}} / CPUs={{.NCPU}}"
ServerVersion=29.9.2 / OS=Docker Desktop / CPUs=16
```

> `docker info` 전체 출력은 매우 길어서 bash 의 `head` 로 앞부분만 잘라 보았습니다.

```text
$ docker info | head -n 18
Client:
 Version:    29.9.2
 Context:    desktop-linux
 Debug Mode: false
 Plugins:
  agent: Docker AI Agent Runner (Docker Inc.)
    Version:  v1.152.0
    Path:     C:\Program Files\Docker\cli-plugins\docker-agent.exe
  ai: Docker AI Agent - Ask Gordon (Docker Inc.)
    Version:  v1.33.0
    Path:     C:\Program Files\Docker\cli-plugins\docker-ai.exe
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.38.1
    Path:     C:\Program Files\Docker\cli-plugins\docker-buildx.exe
  compose: Docker Compose (Docker Inc.)
    Version:  v5.6.1
    Path:     C:\Program Files\Docker\cli-plugins\docker-compose.exe
  debug: Get a shell into any image or container (Docker Inc.)
```


