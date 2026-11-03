# 증거 07. 기존 Dockerfile 기반 커스텀 이미지 제작

**선택한 방식 : (A) 웹 서버 베이스 이미지 활용** — 공식 `nginx` 이미지를 바탕으로
정적 콘텐츠와 설정을 내 것으로 교체했습니다.

| 커스텀 포인트 | 목적 |
|---|---|
| `ENV APP_ENV=dev` | 개발용 환경이라는 표시를 환경 변수로 넣어 둔다 |
| `COPY config/default.conf` | nginx 설정을 교체해 응답 헤더 `X-Mission` 추가, `/data/` 목록 보기 허용 |
| `COPY app/` | 기본 안내 페이지를 내가 만든 한국어 페이지로 교체 |

```text
$ Get-Content Dockerfile -Encoding UTF8
# ===== 미션 1 : 기존 nginx 이미지를 바탕으로 만든 커스텀 웹 서버 =====

# 1) 바탕(베이스) 이미지 : 공식 nginx
FROM nginx:latest

# 2) 이미지 이름표
LABEL org.opencontainers.image.title="my-web-server"
LABEL org.opencontainers.image.description="Codyssey mission1 custom nginx web server"

# 3) 커스텀 포인트 1 : 환경 변수 추가
ENV APP_ENV=dev

# 4) 커스텀 포인트 2 : nginx 설정 파일 교체
COPY config/default.conf /etc/nginx/conf.d/default.conf

# 5) 커스텀 포인트 3 : 웹 페이지(정적 콘텐츠) 교체
COPY app/ /usr/share/nginx/html/

# 6) 컨테이너가 사용하는 내부 포트
EXPOSE 80

# 7) 컨테이너가 켜질 때 실행할 명령
CMD ["nginx", "-g", "daemon off;"]
```

```text
$ docker build -t my-web-server:1.0 .
#0 building with "desktop-linux" instance using docker driver
 

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 790B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/nginx:latest
#2 DONE 0.0s

#3 [internal] load .dockerignore
#3 transferring context: 103B done
#3 DONE 0.0s

#4 [1/3] FROM docker.io/library/nginx:latest@sha256:5ab5b0b01097420873a3f3330f44248e34a3c2a3e8d5ee30658aeae8cb7435da
#4 resolve docker.io/library/nginx:latest@sha256:5ab5b0b01097420873a3f3330f44248e34a3c2a3e8d5ee30658aeae8cb7435da 0.0s 
done
#4 CACHED

#5 [internal] load build context
#5 transferring context: 1.59kB done
#5 DONE 0.0s

#6 [2/3] COPY config/default.conf /etc/nginx/conf.d/default.conf
#6 DONE 0.0s

#7 [3/3] COPY app/ /usr/share/nginx/html/
#7 DONE 0.0s

#8 exporting to image
#8 exporting layers 0.1s done
#8 exporting manifest sha256:6c9aa15c3bcac3bfcf93e6e17ff6a1c0bb71011f14a11af7f2121365cabe242a done
#8 exporting config sha256:0217896c6ff86e13eafe5dfd671ccb0a49c1e7427f93fb239ac9a9f5c5e3078b done
#8 exporting attestation manifest sha256:51385caebe7f586139f0cd2fc27f9f347f71c7370634c9a97247e46b211297f7 done
#8 exporting manifest list sha256:683ee95c8d0504ad71a7ff3c2d0fabd11b60ad0bf22f92ae39723ca57a2f9597 done
#8 naming to docker.io/library/my-web-server:1.0 done
#8 unpacking to docker.io/library/my-web-server:1.0 0.0s done
#8 DONE 0.1s
```

```text
$ docker images my-web-server
IMAGE                  ID             DISK USAGE   CONTENT SIZE   EXTRA
my-web-server:1.0      683ee95c8d05        241MB         63.9MB        
my-web-server:latest   999773f5e888        241MB         63.9MB
```

### 커스텀 포인트가 실제로 들어갔는지 확인

```text
$ docker image inspect my-web-server:1.0 --format "Labels={{.Config.Labels}} / Env={{.Config.Env}} / ExposedPorts={{.Config.ExposedPorts}}"
Labels=map[maintainer:NGINX Docker Maintainers <docker-maint@nginx.com> org.opencontainers.image.description:Codyssey mission1 custom nginx web server org.opencontainers.image.title:my-web-server] / Env=[PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin NGINX_VERSION=1.31.8 NJS_VERSION=1.0.2 NJS_RELEASE=1~trixie ACME_VERSION=0.4.1 PKG_RELEASE=1~trixie DYNPKG_RELEASE=1~trixie APP_ENV=dev] / ExposedPorts=map[80/tcp:{}]
```
