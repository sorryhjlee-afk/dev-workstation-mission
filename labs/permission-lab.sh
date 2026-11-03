#!/usr/bin/env bash
# 리눅스 파일 권한 실습 : 파일 1개(run-demo.sh) + 디렉토리 1개(mydir)
# 사용법 : docker run --rm -v "${PWD}/labs:/labs" ubuntu:24.04 bash /labs/permission-lab.sh
set -u

echo "=== 준비 : 실습용 파일과 폴더 만들기 ==="
mkdir -p /lab/mydir
echo hello > /lab/myfile.txt
printf 'echo permission-ok\n' > /lab/run-demo.sh
cd /lab
ls -l

echo
echo "=== (1) 변경 전 권한 ==="
stat -c '%n = %a (%A)' run-demo.sh mydir

echo
echo "=== (2) 실행 권한이 없는 스크립트를 실행하면? ==="
./run-demo.sh
echo "exit-code=$?"

echo
echo "=== (3) 권한 변경 : 파일 644 -> 755 , 디렉토리 755 -> 700 ==="
chmod 755 run-demo.sh
chmod 700 mydir
stat -c '%n = %a (%A)' run-demo.sh mydir

echo
echo "=== (4) 변경 후 : 같은 스크립트가 이제 실행된다 ==="
./run-demo.sh
echo "exit-code=$?"

echo
echo "=== (5) 디렉토리 700 의 의미 : 다른 사용자는 못 들어간다 ==="
useradd -m tester 2>/dev/null || true
su tester -c "ls /lab/mydir"
echo "exit-code=$?"
