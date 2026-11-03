# 증거 13. 보너스 - GitHub SSH 키 설정

HTTPS 로 올릴 때는 매번 로그인 정보를 확인합니다.
**SSH 키(열쇠)** 를 등록해 두면 자동으로 확인되어 더 편하고 안전합니다.

모든 명령은 **VS Code 의 bash(Git Bash) 터미널** 기준입니다. 맥/리눅스 bash 에서도 똑같습니다.

열쇠는 두 개가 한 쌍입니다.

| 파일 | 이름 | 다루는 법 |
|---|---|---|
| `~/.ssh/id_ed25519` | **개인키** (내 열쇠) | 내 PC 밖으로 절대 내보내지 않습니다. 문서·캡처에도 넣지 않습니다. |
| `~/.ssh/id_ed25519.pub` | **공개키** (자물쇠) | 이것만 깃허브에 등록합니다. 공개돼도 괜찮습니다. |

> **이 저장소의 제출 상태** — 지금 저장소는 **HTTPS + GitHub CLI** 로 올렸습니다.
> SSH 키 등록은 *개인키를 새로 만들고 깃허브 계정 설정을 바꾸는 작업*이라
> **계정 주인이 직접** 수행해야 합니다. 아래 ①②는 실제로 실행한 결과이고,
> ③부터는 계정 주인이 그대로 따라 하면 되는 절차와 **마스킹한 예시 출력**입니다.

---

## ① SSH 가 깔려 있는지 확인 (실제 실행)

```text
$ ssh -V
OpenSSH_10.3p1, OpenSSL 3.5.6 7 Apr 2026
```

Git for Windows 에 OpenSSH 가 함께 들어 있어 따로 설치하지 않았습니다.
(윈도우 자체에도 OpenSSH 가 있고, 맥/리눅스에는 기본으로 들어 있습니다)

## ② 이미 만들어 둔 열쇠가 있는지 확인 (실제 실행)

```text
$ ls -la ~/.ssh
ls: cannot access '/c/Users/<사용자>/.ssh': No such file or directory
```

"없다" 는 뜻이므로 아직 열쇠를 만들지 않은 상태입니다.

## ③ 열쇠 만들기

```text
$ ssh-keygen -t ed25519 -C "내깃허브아이디@users.noreply.github.com"
Generating public/private ed25519 key pair.
Enter file in which to save the key (~/.ssh/id_ed25519):   <- 그냥 Enter
Enter passphrase (empty for no passphrase):                <- Enter 또는 암호
Enter same passphrase again:                               <- 같은 값
Your identification has been saved in ~/.ssh/id_ed25519
Your public key has been saved in ~/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:**************************************  내깃허브아이디@users.noreply.github.com
The key's randomart image is:
+--[ED25519 256]--+
|      (생략)      |
+----[SHA256]-----+
```

- `-t ed25519` : 요즘 권장하는 열쇠 방식입니다. (예전 방식 rsa 보다 짧고 안전합니다)
- `-C "..."` : 이 열쇠가 누구 것인지 적어 두는 메모입니다.
  깃허브 **noreply 이메일**을 쓰면 실제 메일 주소가 드러나지 않습니다.
- **지문(fingerprint)** 은 열쇠를 구분하는 번호라서 이 문서에서는 `*` 로 가렸습니다.

> 위 명령 자체가 제대로 동작하는지는 **임시 폴더에 연습용 열쇠를 한 번 만들어 확인**하고
> 곧바로 지웠습니다. 확인한 결과 형식은 다음과 같습니다(값은 가림).
>
> ```text
> $ ssh-keygen -lf <임시폴더>/demo_key.pub | sed -E 's/SHA256:[A-Za-z0-9+/=]+/SHA256:************/'
> 256 SHA256:************ codyssey-mission (ED25519)
>
> 공개키 한 줄의 생김새 : ssh-ed25519 <68글자 본문> <메모>
> ```

## ④ 공개키만 복사해서 깃허브에 등록

```text
$ cat ~/.ssh/id_ed25519.pub
ssh-ed25519 AAAA************************************************ 내깃허브아이디@users.noreply.github.com

$ cat ~/.ssh/id_ed25519.pub | clip        # 윈도우
$ cat ~/.ssh/id_ed25519.pub | pbcopy      # 맥
```

등록 위치 : **github.com → 프로필 → Settings → SSH and GPG keys → New SSH key**
Title 에 `my-windows-pc` 처럼 알아볼 이름을 적고, Key 칸에 붙여넣은 뒤 **Add SSH key**.

명령으로 등록하려면 gh 에 권한을 한 번 더 줘야 합니다. 실제로 확인해 보니
지금 로그인된 gh 에는 그 권한이 없었습니다(= 계정 설정을 함부로 바꿀 수 없는 상태).

```text
$ gh ssh-key list
warning:  HTTP 404: Not Found (https://api.github.com/user/keys?per_page=100)
This API operation needs the "admin:public_key" scope. To request it, run:
  gh auth refresh -h github.com -s admin:public_key
```

## ⑤ 연결 확인

```text
$ ssh -T git@github.com
The authenticity of host 'github.com (...)' can't be established.
ED25519 key fingerprint is SHA256:****************************.
Are you sure you want to continue connecting (yes/no)? yes
Hi 내깃허브아이디! You have successfully authenticated, but GitHub does not provide shell access.
```

`does not provide shell access` 는 **에러가 아니라 정상 메시지**입니다.
깃허브는 파일을 주고받는 용도로만 SSH 를 열어 두기 때문입니다.

## ⑥ 저장소 주소를 HTTPS → SSH 로 바꾸기

```text
$ git remote -v
origin  https://github.com/내깃허브아이디/dev-workstation-mission.git (fetch)
origin  https://github.com/내깃허브아이디/dev-workstation-mission.git (push)

$ git remote set-url origin git@github.com:내깃허브아이디/dev-workstation-mission.git

$ git remote -v
origin  git@github.com:내깃허브아이디/dev-workstation-mission.git (fetch)
origin  git@github.com:내깃허브아이디/dev-workstation-mission.git (push)

$ git push
Everything up-to-date
```

### 열쇠가 등록됐는데도 안 될 때 (bash)

```text
$ eval "$(ssh-agent -s)"
Agent pid 1234

$ ssh-add ~/.ssh/id_ed25519
Identity added: /c/Users/<사용자>/.ssh/id_ed25519
```

---

## 안전하게 쓰기 위한 약속

- 개인키(`id_ed25519`)는 **복사·전송·캡처 금지**. 문서에도 넣지 않습니다.
- 등록·공유하는 것은 **`.pub` 공개키 한 줄**뿐입니다.
- 열쇠를 잃어버렸거나 남에게 보였다면, 깃허브에서 **그 키를 삭제**하고 새로 만듭니다.
- 공용 PC 에서는 SSH 키를 만들지 않습니다. (HTTPS + 일회성 로그인이 안전합니다)
- 이 문서의 지문·키 본문은 모두 `*` 로 가렸습니다.

따라하기 파일 → [`commands/13-ssh.txt`](../commands/13-ssh.txt)
