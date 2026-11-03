# 증거 10. Docker 볼륨 영속성 (컨테이너 삭제 전 / 후)

컨테이너는 **지우면 그 안의 내용도 같이 사라집니다.** 그래서 지켜야 할 데이터는
컨테이너 바깥의 **볼륨(보관함)** 에 넣습니다. 볼륨은 컨테이너를 지워도 남습니다.

```text
$ docker rm -f vol-8083 vol-8083-new 2>$null | Out-Null ; docker volume rm my-data 2>$null | Out-Null ; docker volume create my-data
my-data
```

```text
$ docker volume ls --filter name=my-data
DRIVER    VOLUME NAME
local     my-data
```

```text
$ docker run -d -p 8083:80 --name vol-8083 -v my-data:/usr/share/nginx/html/data my-web-server:1.0
54a8fcbbb5f06efe045ed17c64f3a6b9ffcc8289958c32625b317f69d2c8eae6
```

### ① 볼륨 안에 파일을 하나 만든다

```text
$ docker exec vol-8083 sh -c "echo hello-volume > /usr/share/nginx/html/data/memo.txt"

```

```text
$ docker exec vol-8083 cat /usr/share/nginx/html/data/memo.txt
hello-volume
```

```text
$ curl.exe -s http://localhost:8083/data/memo.txt
hello-volume
```

### ② 컨테이너를 통째로 삭제한다

```text
$ docker rm -f vol-8083
vol-8083
```

```text
$ docker ps -a --filter name=vol-8083
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

→ 목록이 비었습니다. 컨테이너는 완전히 사라졌습니다.

### ③ 볼륨은 그대로 남아 있다

```text
$ docker volume ls --filter name=my-data
DRIVER    VOLUME NAME
local     my-data
```

### ④ 새 컨테이너에 같은 볼륨을 연결한다

```text
$ docker run -d -p 8083:80 --name vol-8083-new -v my-data:/usr/share/nginx/html/data my-web-server:1.0
b73988dc3927d5d298da0333999ed89f694a4d7f2e40166c456d928267614a02
```

```text
$ docker exec vol-8083-new cat /usr/share/nginx/html/data/memo.txt
hello-volume
```

```text
$ curl.exe -s http://localhost:8083/data/memo.txt
hello-volume
```

→ 컨테이너를 지웠는데도 `hello-volume` 이 그대로입니다. **볼륨 영속성 증명 완료.**

```text
$ docker volume inspect my-data
[
    {
        "CreatedAt": "2026-11-03T11:34:25Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/my-data/_data",
        "Name": "my-data",
        "Options": null,
        "Scope": "local"
    }
]
```
