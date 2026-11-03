# 증거 09. 바인드 마운트 (호스트 변경 전 / 후 비교)

**바인드 마운트**는 내 컴퓨터의 폴더를 컨테이너 안 폴더에 그대로 겹쳐 놓는 것입니다.
컨테이너는 그 폴더를 **실시간으로** 보기 때문에, 파일을 고치면 **다시 빌드하지 않아도** 바로 반영됩니다.

비교를 위해 같은 이미지로 만든 `web-8080` (COPY 로 구워 넣은 사본)을 그대로 두고,
`bind-8082` 에만 호스트 폴더를 연결했습니다.

> bash 에서는 현재 폴더를 `$(pwd)` 로 씁니다. (PowerShell 의 `${PWD}` 에 해당)
> 어느 PC 에 내려받아도 그대로 동작하도록 절대 경로를 직접 쓰지 않았습니다.

```text
$ docker run -d -p 8082:80 --name bind-8082 -v "$(pwd)/app:/usr/share/nginx/html" my-web-server:1.0
f1b480ff4bc45ed286aba96bf6bd41db812fea12cd76d457143e0a4aaf5d1a96
```

### ① 변경 전

```text
$ curl -s http://localhost:8082/ | grep -E "<h1>|ver"
    .ver { font-size: 16px; opacity: 0.8; margin-top: 20px; }
    <h1>Hello Docker!</h1>
    <p class="ver">version 1.0</p>
```

### ② 호스트(내 컴퓨터)의 app/index.html 을 수정한다 — 빌드는 하지 않는다

VS Code 에서 직접 고쳐도 되고, 터미널에서 `sed` 로 고쳐도 됩니다.

```text
$ sed -i 's|<h1>Hello Docker!</h1>|<h1>안녕하세요, 도커!</h1>|' app/index.html
```

```text
$ sed -i 's|version 1.0|version 2.0 (수정됨)|' app/index.html
```

```text
$ grep -E "<h1>|ver" app/index.html
    .ver { font-size: 16px; opacity: 0.8; margin-top: 20px; }
    <h1>안녕하세요, 도커!</h1>
    <p class="ver">version 2.0 (수정됨)</p>
```

### ③ 변경 후 — 재빌드 없이 8082 만 바뀐다

```text
$ curl -s http://localhost:8082/ | grep -E "<h1>|ver"
    .ver { font-size: 16px; opacity: 0.8; margin-top: 20px; }
    <h1>안녕하세요, 도커!</h1>
    <p class="ver">version 2.0 (수정됨)</p>
```

### ④ 같은 순간 8080 (COPY 로 구운 컨테이너) 은 그대로

```text
$ curl -s http://localhost:8080/ | grep -E "<h1>|ver"
    .ver { font-size: 16px; opacity: 0.8; margin-top: 20px; }
    <h1>Hello Docker!</h1>
    <p class="ver">version 1.0</p>
```

→ 같은 이미지인데 결과가 다릅니다. 8082 는 **내 폴더를 실시간으로** 보고, 8080 은 **빌드할 때 복사해 둔 사본**을 봅니다.

### ⑤ 원래대로 되돌리기

```text
$ sed -i 's|<h1>안녕하세요, 도커!</h1>|<h1>Hello Docker!</h1>|' app/index.html
```

```text
$ sed -i 's|version 2.0 (수정됨)|version 1.0|' app/index.html
```

```text
$ curl -s http://localhost:8082/ | grep -E "<h1>|ver"
    .ver { font-size: 16px; opacity: 0.8; margin-top: 20px; }
    <h1>Hello Docker!</h1>
    <p class="ver">version 1.0</p>
```


