# 1) 바탕이 되는 이미지: 공식 nginx 웹 서버
FROM nginx:latest

# 2) 이 이미지를 만든 사람 정보
LABEL maintainer="student@example.com"
LABEL description="My first web server built with Dockerfile"

# 3) 내 웹 페이지를 nginx 기본 폴더로 복사
COPY app/ /usr/share/nginx/html/

# 4) 컨테이너가 사용하는 포트를 알려줌 (문서 역할)
EXPOSE 80

# 5) 컨테이너가 켜질 때 실행할 명령
CMD ["nginx", "-g", "daemon off;"]
