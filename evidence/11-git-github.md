# 증거 11. Git 설정과 GitHub 연동

**Git** 은 내 컴퓨터에서 변경 기록을 저장하는 도구이고,
**GitHub** 는 그 기록을 인터넷에 올려 남들과 공유하는 서비스입니다.
(게임으로 치면 Git = 내 세이브 파일, GitHub = 세이브 파일을 올려 두는 클라우드)

> 토큰·비밀번호는 기록하지 않습니다. 이메일은 GitHub 가 제공하는 **noreply 주소**를 써서 실제 메일 주소가 드러나지 않게 했습니다.

```text
$ git config --list | grep -E "user\.|init\.|remote\.origin\.url"
init.defaultbranch=master
user.name=sorryhjlee-afk
user.email=289445261+sorryhjlee-afk@users.noreply.github.com
remote.origin.url=https://github.com/sorryhjlee-afk/dev-workstation-mission.git
```

```text
$ git branch --show-current
main
```

```text
$ git remote -v
origin	https://github.com/sorryhjlee-afk/dev-workstation-mission.git (fetch)
origin	https://github.com/sorryhjlee-afk/dev-workstation-mission.git (push)
```

```text
$ git log --oneline | head -n 5
96020da feat: 보너스 과제 추가 (Docker Compose / 환경 변수 / SSH 키 절차)
3d6e782 refactor: 과제 기능 요구사항 11개 기준으로 전면 재구성
fb557b2 feat: 개발 워크스테이션 구축 미션 (Docker 웹 서버)
```

```text
$ git status --short | head -n 10
 M commands/00-README.txt
 M commands/01-environment.txt
 M commands/02-terminal.txt
 M commands/03-permission.txt
 M commands/04-docker-check.txt
 M commands/05-docker-ops.txt
 M commands/06-container-lab.txt
 M commands/07-custom-image.txt
 M commands/08-port-mapping.txt
 M commands/09-bind-mount.txt
```


