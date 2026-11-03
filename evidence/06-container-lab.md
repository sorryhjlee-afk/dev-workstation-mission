# 증거 06. 컨테이너 실행 실습 (hello-world / ubuntu / exec vs attach)

컨테이너를 직접 실행해 보고 내부에 들어가 명령을 내려 봅니다.

## 6-1. hello-world

```text
$ docker run --rm hello-world | head -n 8

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
```


## 6-2. ubuntu 컨테이너 내부에서 명령 실행

```text
$ docker run -dit --name lab-ubuntu ubuntu:24.04 bash
306d0bf2351b2591238cd36556ceb315f611305994be3a6487250f336c056883
```

```text
$ docker exec lab-ubuntu ls /
bin
boot
dev
etc
home
lib
lib64
media
mnt
opt
proc
root
run
sbin
srv
sys
tmp
usr
var
```

```text
$ docker exec lab-ubuntu bash -c 'echo hello-from-container; head -2 /etc/os-release'
hello-from-container
PRETTY_NAME="Ubuntu 24.04.5 LTS"
NAME="Ubuntu"
```

> 컨테이너 안으로 직접 들어가 보려면 `winpty docker exec -it lab-ubuntu bash` 를 칩니다.
> (Git Bash 에서는 `-it` 앞에 `winpty` 가 필요합니다. 맥/리눅스에서는 그냥 `docker exec -it`)
> 대화형이라 로그로 남기지 않고, 대신 같은 내용을 `ps -ef` 로 확인했습니다.

```text
$ docker exec lab-ubuntu ps -ef
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  1 14:00 pts/0    00:00:00 bash
root          21       0  0 14:00 ?        00:00:00 ps -ef
```

위 목록에서 **PID 1 이 bash** (컨테이너의 주 프로세스)이고, `ps -ef` 자체는 exec 로 새로 생긴 프로세스입니다.

## 6-3. exec 와 attach 의 차이

- `docker exec` : 컨테이너 안에 **새 프로세스를 하나 더** 만든다. 빠져나와도 컨테이너는 계속 산다.
- `docker attach` : 컨테이너의 **1번 프로세스(주 프로세스)** 화면에 그대로 붙는다.
  그 주 프로세스가 끝나면 컨테이너도 함께 멈춘다.

```text
$ docker run -d --name lab-attach ubuntu:24.04 sh -c 'sleep 3; echo main-process-finished'
851eff1232e5cb249b990243b1e32b1caf203d3ffdac235b80e7bbc5ef9e97da
```

```text
$ docker attach --no-stdin lab-attach
main-process-finished
```

attach 로 붙어 있는 동안 주 프로세스의 출력이 그대로 보이고, 주 프로세스가 끝나자 attach 도 함께 끝났습니다.

```text
$ docker ps -a --filter name=lab-attach --format "{{.Names}} / {{.Status}}"
lab-attach / Exited (0) Less than a second ago
```

```text
$ docker ps -a --filter name=lab-ubuntu --format "{{.Names}} / {{.Status}}"
lab-ubuntu / Up 5 seconds
```

→ attach 쪽은 주 프로세스가 끝나서 **Exited**, exec 만 쓴 쪽은 여전히 **Up** 입니다.

```text
$ docker rm -f lab-ubuntu lab-attach
lab-ubuntu
lab-attach
```


