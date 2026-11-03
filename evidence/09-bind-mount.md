# 증거 09. 바인드 마운트 (호스트 변경 전 / 후 비교)

**바인드 마운트**는 내 컴퓨터의 폴더를 컨테이너 안 폴더에 그대로 겹쳐 놓는 것입니다.
컨테이너는 그 폴더를 **실시간으로** 보기 때문에, 파일을 고치면 **다시 빌드하지 않아도** 바로 반영됩니다.

비교를 위해 같은 이미지로 만든 `web-8080` (COPY 로 구워 넣은 사본)을 그대로 두고,
`bind-8082` 에만 호스트 폴더를 연결했습니다.

```text
$ docker rm -f bind-8082 2>$null | Out-Null ; docker run -d -p 8082:80 --name bind-8082 -v "${PWD}\app:/usr/share/nginx/html" my-web-server:1.0
6f364706812df76fc57338972c7e83e594013093e85a3c729a32f8062e82395f
```

### ① 변경 전

```text
$ (curl.exe -s http://localhost:8082/) -split "`n" | Select-String -Pattern "<h1>","class=`"ver`"" | ForEach-Object { "8082 " + $_.ToString().Trim() }
8082 <h1>Hello Docker!</h1>
8082 <p class="ver">version 1.0</p>
```

### ② 호스트(내 컴퓨터)의 app\index.html 을 수정한다 — 빌드는 하지 않는다

```text
$ Select-String -Path app\index.html -Pattern "<h1>","class=`"ver`"" | ForEach-Object { $_.Line.Trim() }
<h1>안녕하세요, 도커!</h1>
<p class="ver">version 2.0 (수정됨)</p>
```

### ③ 변경 후 — 재빌드 없이 8082 만 바뀐다

```text
$ (curl.exe -s http://localhost:8082/) -split "`n" | Select-String -Pattern "<h1>","class=`"ver`"" | ForEach-Object { "8082 " + $_.ToString().Trim() }
8082 <h1>안녕하세요, 도커!</h1>
8082 <p class="ver">version 2.0 (수정됨)</p>
```

### ④ 같은 순간 8080 (COPY 로 구운 컨테이너) 은 그대로

```text
$ (curl.exe -s http://localhost:8080/) -split "`n" | Select-String -Pattern "<h1>","class=`"ver`"" | ForEach-Object { "8080 " + $_.ToString().Trim() }
8080 <h1>Hello Docker!</h1>
8080 <p class="ver">version 1.0</p>
```

→ 같은 이미지인데 결과가 다릅니다. 8082 는 **내 폴더를 실시간으로** 보고, 8080 은 **빌드할 때 복사해 둔 사본**을 봅니다.

### ⑤ 원래대로 되돌리기

```text
$ (curl.exe -s http://localhost:8082/) -split "`n" | Select-String -Pattern "<h1>","class=`"ver`"" | ForEach-Object { "8082 " + $_.ToString().Trim() }
8082 <h1>Hello Docker!</h1>
8082 <p class="ver">version 1.0</p>
```
