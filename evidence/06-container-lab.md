# 증거 06. 컨테이너 실행 실습 (hello-world / ubuntu / exec vs attach)

컨테이너를 직접 실행해 보고 내부에 들어가 명령을 내려 봅니다.

## 6-1. hello-world

```text
$ docker run --rm hello-world
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

## 6-2. ubuntu 컨테이너 내부에서 명령 실행

```text
$ docker rm -f lab-ubuntu 2>$null | Out-Null ; docker run -dit --name lab-ubuntu ubuntu:24.04 bash
4a9547333531138f0e4e724e21e6761a7c01a80988443d23d1f5ecf5516c2645
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
$ docker exec lab-ubuntu bash -c 'echo hello-from-container; cat /etc/os-release | head -2'
hello-from-container
PRETTY_NAME="Ubuntu 24.04.5 LTS"
NAME="Ubuntu"
```

## 6-3. exec 와 attach 의 차이

- `docker exec` : 컨테이너 안에 **새 프로세스를 하나 더** 만든다. 빠져나와도 컨테이너는 계속 산다.
- `docker attach` : 컨테이너의 **1번 프로세스(주 프로세스)** 화면에 그대로 붙는다.
  그 주 프로세스가 끝나면 컨테이너도 함께 멈춘다.

```text
$ docker exec lab-ubuntu ps -ef
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  1 11:31 pts/0    00:00:00 bash
root          23       0 50 11:31 ?        00:00:00 ps -ef
```

위 목록에서 **PID 1 이 bash** (컨테이너의 주 프로세스)이고, `ps -ef` 자체는 exec 로 새로 생긴 프로세스입니다.

```text
$ docker rm -f lab-attach 2>$null | Out-Null ; docker run -d --name lab-attach ubuntu:24.04 sh -c "sleep 3; echo main-process-finished"
d523febbd3af8dce64c7c8945ceb5d6cbf56efa4e88eed23c51d3bb13c400794
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

→ 주 프로세스가 끝났으므로 컨테이너는 **Exited** 상태입니다. (exec 였다면 컨테이너는 계속 Up)

```text
$ docker ps -a --filter name=lab-ubuntu --format "{{.Names}} / {{.Status}}"
lab-ubuntu / Up 4 seconds
```

```text
$ docker rm -f lab-ubuntu lab-attach
lab-ubuntu
lab-attach
```
