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
