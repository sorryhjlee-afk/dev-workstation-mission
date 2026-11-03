# 증거 11. Git 설정과 GitHub 연동

**Git** 은 내 컴퓨터에서 변경 기록을 저장하는 도구이고,
**GitHub** 는 그 기록을 인터넷에 올려 남들과 공유하는 서비스입니다.
(게임으로 치면 Git = 내 세이브 파일, GitHub = 세이브 파일을 올려 두는 클라우드)

```text
$ git --version
git version 2.54.0.windows.1
```

```text
$ git config --list --show-origin | Select-String -Pattern "user\.","init\.defaultbranch","remote\.origin\.url"
file:C:/Program Files/Git/etc/gitconfig	init.defaultbranch=master
file:.git/config	user.name=sorryhjlee-afk
file:.git/config	user.email=289445261+sorryhjlee-afk@users.noreply.github.com
file:.git/config	remote.origin.url=https://github.com/sorryhjlee-afk/dev-workstation-mission.git
```

> 토큰·비밀번호는 기록하지 않습니다. 이메일은 GitHub 가 제공하는 **noreply 주소**를 써서 실제 메일 주소가 드러나지 않게 했습니다.

```text
$ git status --short
M .dockerignore
 M .gitignore
 M Dockerfile
 D docs/images/bind-after.jpg
 D docs/images/bind-before.jpg
 D docs/images/port-8081.jpg
 D docs/images/volume-memo.png
 D docs/verification-log.md
 D "docs/\353\217\204\354\273\244\353\257\270\354\205\230_\353\224\260\353\235\274\355\225\230\352\270\260_\352\260\200\354\235\264\353\223\234.pdf"
 D scripts/run-all.bat
 D scripts/step01-terminal.bat
 D scripts/step02-permission.bat
 D scripts/step03-docker-check.bat
 D scripts/step04-make-project.bat
 D scripts/step05-dockerfile.bat
 D scripts/step06-build-run.bat
 D scripts/step07-operations.bat
 D scripts/step08-bind-mount.bat
 D scripts/step09-volume.bat
 D scripts/step10-git.bat
 D scripts/step11-github.bat
 D scripts/step12-cleanup.bat
 D templates/Dockerfile
 D templates/dockerignore.txt
 D templates/gitignore.txt
 D templates/index.html
?? config/
?? evidence/
?? labs/
```

```text
$ git log --oneline -5
fb557b2 feat: 개발 워크스테이션 구축 미션 (Docker 웹 서버)
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
