# 증거 05. Docker 기본 운영 명령

이미지 받기 / 목록 보기 / 컨테이너 실행·중지·목록 / 로그 / 리소스 확인.

```text
$ docker pull nginx:latest
latest: Pulling from library/nginx
Digest: sha256:5ab5b0b01097420873a3f3330f44248e34a3c2a3e8d5ee30658aeae8cb7435da
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
```

```text
$ docker images | head -n 6
IMAGE                   ID             DISK USAGE   CONTENT SIZE   EXTRA
hello-world:latest      c567b231f656       25.9kB         9.49kB        
my-web-server:1.0       04ab6ffd7b8b        241MB         63.9MB        
my-web-server:compose   aeccbd3d0cf0        241MB         63.9MB   U    
my-web-server:latest    999773f5e888        241MB         63.9MB        
nginx:latest            5ab5b0b01097        243MB         66.8MB   U    
```

```text
$ docker run -d --name ops-demo nginx:latest
6cf100bd81f92fc26938ad3e5d61dc90b56cae0bf0ac3af899b8df2514363332
```

```text
$ docker ps --filter name=ops-demo
CONTAINER ID   IMAGE          COMMAND                   CREATED        STATUS                  PORTS     NAMES
6cf100bd81f9   nginx:latest   "/docker-entrypoint.…"   1 second ago   Up Less than a second   80/tcp    ops-demo
```

```text
$ docker stop ops-demo
ops-demo
```

### 중지하면 `docker ps` 에는 안 보이고 `docker ps -a` 에만 보인다

```text
$ docker ps --filter name=ops-demo
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

```text
$ docker ps -a --filter name=ops-demo
CONTAINER ID   IMAGE          COMMAND                   CREATED         STATUS                              PORTS     NAMES
6cf100bd81f9   nginx:latest   "/docker-entrypoint.…"   2 seconds ago   Exited (0) Less than a second ago             ops-demo
```

```text
$ docker start ops-demo
ops-demo
```

```text
$ docker logs ops-demo | head -n 8
2026/11/03 14:00:47 [notice] 1#1: using the "epoll" event method
2026/11/03 14:00:47 [notice] 1#1: nginx/1.31.8
2026/11/03 14:00:47 [notice] 1#1: built by gcc 14.2.0 (Debian 14.2.0-19) 
2026/11/03 14:00:47 [notice] 1#1: OS: Linux 6.18.54.1-microsoft-standard-WSL2
2026/11/03 14:00:47 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2026/11/03 14:00:47 [notice] 1#1: start worker processes
2026/11/03 14:00:47 [notice] 1#1: start worker process 29
2026/11/03 14:00:47 [notice] 1#1: start worker process 30
2026/11/03 14:00:47 [notice] 1#1: start worker process 31
2026/11/03 14:00:47 [notice] 1#1: start worker process 32
2026/11/03 14:00:47 [notice] 1#1: start worker process 33
2026/11/03 14:00:47 [notice] 1#1: start worker process 34
2026/11/03 14:00:47 [notice] 1#1: start worker process 35
2026/11/03 14:00:47 [notice] 1#1: start worker process 36
2026/11/03 14:00:47 [notice] 1#1: start worker process 37
2026/11/03 14:00:47 [notice] 1#1: start worker process 38
2026/11/03 14:00:47 [notice] 1#1: start worker process 39
2026/11/03 14:00:47 [notice] 1#1: start worker process 40
2026/11/03 14:00:47 [notice] 1#1: start worker process 41
2026/11/03 14:00:47 [notice] 1#1: start worker process 42
2026/11/03 14:00:47 [notice] 1#1: start worker process 43
2026/11/03 14:00:47 [notice] 1#1: start worker process 44
2026/11/03 14:00:48 [notice] 1#1: signal 3 (SIGQUIT) received, shutting down
2026/11/03 14:00:48 [notice] 30#30: gracefully shutting down
2026/11/03 14:00:48 [notice] 29#29: gracefully shutting down
2026/11/03 14:00:48 [notice] 31#31: gracefully shutting down
2026/11/03 14:00:48 [notice] 32#32: gracefully shutting down
2026/11/03 14:00:48 [notice] 30#30: exiting
2026/11/03 14:00:48 [notice] 29#29: exiting
2026/11/03 14:00:48 [notice] 33#33: gracefully shutting down
2026/11/03 14:00:48 [notice] 34#34: gracefully shutting down
2026/11/03 14:00:48 [notice] 32#32: exiting
2026/11/03 14:00:48 [notice] 31#31: exiting
2026/11/03 14:00:48 [notice] 35#35: gracefully shutting down
2026/11/03 14:00:48 [notice] 33#33: exiting
2026/11/03 14:00:48 [notice] 34#34: exiting
2026/11/03 14:00:48 [notice] 36#36: gracefully shutting down
2026/11/03 14:00:48 [notice] 35#35: exiting
2026/11/03 14:00:48 [notice] 38#38: gracefully shutting down
2026/11/03 14:00:48 [notice] 36#36: exiting
2026/11/03 14:00:48 [notice] 30#30: exit
2026/11/03 14:00:48 [notice] 37#37: gracefully shutting down
2026/11/03 14:00:48 [notice] 38#38: exiting
2026/11/03 14:00:48 [notice] 39#39: gracefully shutting down
2026/11/03 14:00:48 [notice] 37#37: exiting
2026/11/03 14:00:48 [notice] 29#29: exit
2026/11/03 14:00:48 [notice] 39#39: exiting
2026/11/03 14:00:48 [notice] 31#31: exit
2026/11/03 14:00:48 [notice] 38#38: exit
2026/11/03 14:00:48 [notice] 34#34: exit
2026/11/03 14:00:48 [notice] 33#33: exit
2026/11/03 14:00:48 [notice] 36#36: exit
2026/11/03 14:00:48 [notice] 35#35: exit
2026/11/03 14:00:48 [notice] 32#32: exit
2026/11/03 14:00:48 [notice] 39#39: exit
2026/11/03 14:00:48 [notice] 37#37: exit
2026/11/03 14:00:48 [notice] 40#40: gracefully shutting down
2026/11/03 14:00:48 [notice] 40#40: exiting
2026/11/03 14:00:48 [notice] 40#40: exit
2026/11/03 14:00:48 [notice] 41#41: gracefully shutting down
2026/11/03 14:00:48 [notice] 41#41: exiting
2026/11/03 14:00:48 [notice] 41#41: exit
2026/11/03 14:00:48 [notice] 43#43: gracefully shutting down
2026/11/03 14:00:48 [notice] 43#43: exiting
2026/11/03 14:00:48 [notice] 43#43: exit
2026/11/03 14:00:48 [notice] 42#42: gracefully shutting down
2026/11/03 14:00:48 [notice] 42#42: exiting
2026/11/03 14:00:48 [notice] 42#42: exit
2026/11/03 14:00:48 [notice] 44#44: gracefully shutting down
2026/11/03 14:00:48 [notice] 44#44: exiting
2026/11/03 14:00:48 [notice] 44#44: exit
2026/11/03 14:00:48 [notice] 1#1: signal 17 (SIGCHLD) received from 38
2026/11/03 14:00:48 [notice] 1#1: worker process 38 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: worker process 41 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: worker process 42 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: signal 29 (SIGIO) received
2026/11/03 14:00:48 [notice] 1#1: signal 17 (SIGCHLD) received from 36
2026/11/03 14:00:48 [notice] 1#1: worker process 30 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: worker process 32 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: worker process 34 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: worker process 35 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: worker process 36 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: signal 29 (SIGIO) received
2026/11/03 14:00:48 [notice] 1#1: signal 17 (SIGCHLD) received from 40
2026/11/03 14:00:48 [notice] 1#1: worker process 39 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: worker process 40 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: worker process 43 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: worker process 44 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: signal 29 (SIGIO) received
2026/11/03 14:00:48 [notice] 1#1: signal 17 (SIGCHLD) received from 39
2026/11/03 14:00:48 [notice] 1#1: signal 17 (SIGCHLD) received from 31
2026/11/03 14:00:48 [notice] 1#1: worker process 31 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: signal 29 (SIGIO) received
2026/11/03 14:00:48 [notice] 1#1: signal 17 (SIGCHLD) received from 29
2026/11/03 14:00:48 [notice] 1#1: worker process 29 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: worker process 37 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: signal 29 (SIGIO) received
2026/11/03 14:00:48 [notice] 1#1: signal 17 (SIGCHLD) received from 33
2026/11/03 14:00:48 [notice] 1#1: worker process 33 exited with code 0
2026/11/03 14:00:48 [notice] 1#1: exit
2026/11/03 14:00:49 [notice] 1#1: using the "epoll" event method
2026/11/03 14:00:49 [notice] 1#1: nginx/1.31.8
2026/11/03 14:00:49 [notice] 1#1: built by gcc 14.2.0 (Debian 14.2.0-19) 
2026/11/03 14:00:49 [notice] 1#1: OS: Linux 6.18.54.1-microsoft-standard-WSL2
2026/11/03 14:00:49 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2026/11/03 14:00:49 [notice] 1#1: start worker processes
2026/11/03 14:00:49 [notice] 1#1: start worker process 22
2026/11/03 14:00:49 [notice] 1#1: start worker process 23
2026/11/03 14:00:49 [notice] 1#1: start worker process 24
2026/11/03 14:00:49 [notice] 1#1: start worker process 25
2026/11/03 14:00:49 [notice] 1#1: start worker process 26
2026/11/03 14:00:49 [notice] 1#1: start worker process 27
2026/11/03 14:00:49 [notice] 1#1: start worker process 28
2026/11/03 14:00:49 [notice] 1#1: start worker process 29
2026/11/03 14:00:49 [notice] 1#1: start worker process 30
2026/11/03 14:00:49 [notice] 1#1: start worker process 31
2026/11/03 14:00:49 [notice] 1#1: start worker process 32
2026/11/03 14:00:49 [notice] 1#1: start worker process 33
2026/11/03 14:00:49 [notice] 1#1: start worker process 34
2026/11/03 14:00:49 [notice] 1#1: start worker process 35
2026/11/03 14:00:49 [notice] 1#1: start worker process 36
2026/11/03 14:00:49 [notice] 1#1: start worker process 37
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
```

```text
$ docker stats --no-stream ops-demo
CONTAINER ID   NAME       CPU %     MEM USAGE / LIMIT     MEM %     NET I/O      BLOCK I/O   PIDS
6cf100bd81f9   ops-demo   0.00%     15.27MiB / 15.18GiB   0.10%     690B / 84B   0B / 0B     17
```

```text
$ docker rm -f ops-demo
ops-demo
```


