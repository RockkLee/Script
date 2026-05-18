#!/usr/bin/env bash

# Usage: ./load_test.sh 100
#   $1 = number of requests (default: 50)

COUNT="${1:-200}"
PROCESSES="${2:-10}"

echo "Hitting $COUNT x $PROCESSES times..."

load_test() {
  echo "Hitting..."
  curl --location 'http://localhost:55007/custmgconsl/api/v1/provision/list' \
    --header 'accept: application/json, text/plain, */*' \
    --header 'accept-language: en-US,en;q=0.9,zh-TW;q=0.8,zh;q=0.7' \
    --header 'authorization: Bearer eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI4ZmM1MWQ5YS05NjliLTRiYzQtOTZiMC05NTcwZDYwN2FiNzkiLCJhdWQiOiIyZDNkMzg5Mi1iZjEyLTRmYWEtYWUwNy1hZWUxNjA4OTY2ODMiLCJvcGVuSWRQcm92aWRlciI6eyJvcGVuSWRVc2VySWQiOiJudWxsIiwibmFtZSI6IkV5ZXNtZWRpYSIsInJlZklkIjoibnVsbCJ9LCJleHAiOjE3Njc4Mzk2NjEsImlhdCI6MTc2NTI0NzY2MSwidXNlciI6eyJhY2NvdW50SWQiOiI0NGVmMWUzOC01MTdjLTQyNmMtOTUzMC1lZjE2MTRmODExNmQiLCJuYW1lIjoiU2FtTGVlMyIsIm1vYmlsZSI6Im51bGwiLCJpZCI6IjhmYzUxZDlhLTk2OWItNGJjNC05NmIwLTk1NzBkNjA3YWI3OSIsImF2YXRhciI6Imh0dHBzOi8vY2RuLmp1c3RrYS5haS9zaXQvdXNlckF2YXRhci9wYXJ0bmVyaWRfZGVmYXVsdC5wbmciLCJjb3VudHJ5TWNvZGUiOiJudWxsIiwiZW1haWwiOiJzYW04ODAxMDNAZ21haWwuY29tIiwiYWNjb3VudFVzZXJJZCI6bnVsbCwicmVnaXN0ZXJEYXRlIjoiMTcyOTA1OTYzNSJ9LCJpc3MiOiJzaXQtaWQuanVzdGthLmFpIn0.nDZ3jNXM9ktEv9wAZL_3fnY4aAM1AyLxFonJsqVYYigKFfxwNPy_cQUdEc6f0k_yEAfDla_Js9v020YhAh8FHrVomSGmSE_pPBkMk7Rdo9nz6pXmPQyhuxzB4Q0M4h0cwguUZZrmcINk-ILggeLIwVH81y0ShNkMHJ8D5XlxtGGzJfYKZJJHi8vybcyuUl4BiHqXQ_w2gDME-IxJDVn0aG_aQ2nGVROvJrVydiqOuAq3yBQ7vfG3wKA4yVIiA2W_NZaru6Ft3ujm2Ye3JKnw5VTNLhcRZryKr5vH3L5ZR4kargkOytTlQbulfBI7bJXipX-8cxTlECOVSpyjUF-8Mg' \
    --header 'content-type: application/json' \
    --header 'origin: https://sit-console.justka.ai' \
    --header 'priority: u=1, i' \
    --header 'referer: https://sit-console.justka.ai/' \
    --header 'sec-ch-ua: "Chromium";v="142", "Google Chrome";v="142", "Not_A Brand";v="99"' \
    --header 'sec-ch-ua-mobile: ?0' \
    --header 'sec-ch-ua-platform: "macOS"' \
    --header 'sec-fetch-dest: empty' \
    --header 'sec-fetch-mode: cors' \
    --header 'sec-fetch-site: same-site' \
    --header 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36' \
    --header 'Cookie: JSESSIONID=8133C98E9A5F5D0F55E1759CDDDE0CDD' \
    --data '{"accountId":null}'
  #   curl 'https://sit-api.justka.ai/1/justka/custmgconsl/provision/list' \
  #     -H 'accept: application/json, text/plain, */*' \
  #     -H 'accept-language: en-US,en;q=0.9,zh-TW;q=0.8,zh;q=0.7' \
  #     -H 'authorization: Bearer eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI4ZmM1MWQ5YS05NjliLTRiYzQtOTZiMC05NTcwZDYwN2FiNzkiLCJhdWQiOiIyZDNkMzg5Mi1iZjEyLTRmYWEtYWUwNy1hZWUxNjA4OTY2ODMiLCJvcGVuSWRQcm92aWRlciI6eyJvcGVuSWRVc2VySWQiOiJudWxsIiwibmFtZSI6IkV5ZXNtZWRpYSIsInJlZklkIjoibnVsbCJ9LCJleHAiOjE3Njc4Mzk2NjEsImlhdCI6MTc2NTI0NzY2MSwidXNlciI6eyJhY2NvdW50SWQiOiI0NGVmMWUzOC01MTdjLTQyNmMtOTUzMC1lZjE2MTRmODExNmQiLCJuYW1lIjoiU2FtTGVlMyIsIm1vYmlsZSI6Im51bGwiLCJpZCI6IjhmYzUxZDlhLTk2OWItNGJjNC05NmIwLTk1NzBkNjA3YWI3OSIsImF2YXRhciI6Imh0dHBzOi8vY2RuLmp1c3RrYS5haS9zaXQvdXNlckF2YXRhci9wYXJ0bmVyaWRfZGVmYXVsdC5wbmciLCJjb3VudHJ5TWNvZGUiOiJudWxsIiwiZW1haWwiOiJzYW04ODAxMDNAZ21haWwuY29tIiwiYWNjb3VudFVzZXJJZCI6bnVsbCwicmVnaXN0ZXJEYXRlIjoiMTcyOTA1OTYzNSJ9LCJpc3MiOiJzaXQtaWQuanVzdGthLmFpIn0.nDZ3jNXM9ktEv9wAZL_3fnY4aAM1AyLxFonJsqVYYigKFfxwNPy_cQUdEc6f0k_yEAfDla_Js9v020YhAh8FHrVomSGmSE_pPBkMk7Rdo9nz6pXmPQyhuxzB4Q0M4h0cwguUZZrmcINk-ILggeLIwVH81y0ShNkMHJ8D5XlxtGGzJfYKZJJHi8vybcyuUl4BiHqXQ_w2gDME-IxJDVn0aG_aQ2nGVROvJrVydiqOuAq3yBQ7vfG3wKA4yVIiA2W_NZaru6Ft3ujm2Ye3JKnw5VTNLhcRZryKr5vH3L5ZR4kargkOytTlQbulfBI7bJXipX-8cxTlECOVSpyjUF-8Mg' \
  #     -H 'content-type: application/json' \
  #     -H 'origin: https://sit-console.justka.ai' \
  #     -H 'priority: u=1, i' \
  #     -H 'referer: https://sit-console.justka.ai/' \
  #     -H 'sec-ch-ua: "Chromium";v="142", "Google Chrome";v="142", "Not_A Brand";v="99"' \
  #     -H 'sec-ch-ua-mobile: ?0' \
  #     -H 'sec-ch-ua-platform: "macOS"' \
  #     -H 'sec-fetch-dest: empty' \
  #     -H 'sec-fetch-mode: cors' \
  #     -H 'sec-fetch-site: same-site' \
  #     -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36' \
  #     --data-raw '{"accountId":null}'
  sleep 1
}

running=0

for _ in $(seq 1 "$COUNT"); do
  load_test &   # run in background
  ((running++)) # (( ... )) → arithmetic command (do integer math)

  if ((running >= PROCESSES)); then
    wait -n # wait for one to finish (Bash 4.3+)
    ((running--))
  fi
done

wait # wait for all remaining

# for i in $(seq 1 "$COUNT"); do
#   echo "Hitting $COUNT times..."
#   # -s: silent
#   # -o /dev/null: discard body
#   # -w: print HTTP status and time
#   curl 'https://sit-api.justka.ai/1/justka/custmgconsl/provision/list' \
#     -H 'accept: application/json, text/plain, */*' \
#     -H 'accept-language: en-US,en;q=0.9,zh-TW;q=0.8,zh;q=0.7' \
#     -H 'authorization: Bearer eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI4ZmM1MWQ5YS05NjliLTRiYzQtOTZiMC05NTcwZDYwN2FiNzkiLCJhdWQiOiIyZDNkMzg5Mi1iZjEyLTRmYWEtYWUwNy1hZWUxNjA4OTY2ODMiLCJvcGVuSWRQcm92aWRlciI6eyJvcGVuSWRVc2VySWQiOiJudWxsIiwibmFtZSI6IkV5ZXNtZWRpYSIsInJlZklkIjoibnVsbCJ9LCJleHAiOjE3Njc4Mzk2NjEsImlhdCI6MTc2NTI0NzY2MSwidXNlciI6eyJhY2NvdW50SWQiOiI0NGVmMWUzOC01MTdjLTQyNmMtOTUzMC1lZjE2MTRmODExNmQiLCJuYW1lIjoiU2FtTGVlMyIsIm1vYmlsZSI6Im51bGwiLCJpZCI6IjhmYzUxZDlhLTk2OWItNGJjNC05NmIwLTk1NzBkNjA3YWI3OSIsImF2YXRhciI6Imh0dHBzOi8vY2RuLmp1c3RrYS5haS9zaXQvdXNlckF2YXRhci9wYXJ0bmVyaWRfZGVmYXVsdC5wbmciLCJjb3VudHJ5TWNvZGUiOiJudWxsIiwiZW1haWwiOiJzYW04ODAxMDNAZ21haWwuY29tIiwiYWNjb3VudFVzZXJJZCI6bnVsbCwicmVnaXN0ZXJEYXRlIjoiMTcyOTA1OTYzNSJ9LCJpc3MiOiJzaXQtaWQuanVzdGthLmFpIn0.nDZ3jNXM9ktEv9wAZL_3fnY4aAM1AyLxFonJsqVYYigKFfxwNPy_cQUdEc6f0k_yEAfDla_Js9v020YhAh8FHrVomSGmSE_pPBkMk7Rdo9nz6pXmPQyhuxzB4Q0M4h0cwguUZZrmcINk-ILggeLIwVH81y0ShNkMHJ8D5XlxtGGzJfYKZJJHi8vybcyuUl4BiHqXQ_w2gDME-IxJDVn0aG_aQ2nGVROvJrVydiqOuAq3yBQ7vfG3wKA4yVIiA2W_NZaru6Ft3ujm2Ye3JKnw5VTNLhcRZryKr5vH3L5ZR4kargkOytTlQbulfBI7bJXipX-8cxTlECOVSpyjUF-8Mg' \
#     -H 'content-type: application/json' \
#     -H 'origin: https://sit-console.justka.ai' \
#     -H 'priority: u=1, i' \
#     -H 'referer: https://sit-console.justka.ai/' \
#     -H 'sec-ch-ua: "Chromium";v="142", "Google Chrome";v="142", "Not_A Brand";v="99"' \
#     -H 'sec-ch-ua-mobile: ?0' \
#     -H 'sec-ch-ua-platform: "macOS"' \
#     -H 'sec-fetch-dest: empty' \
#     -H 'sec-fetch-mode: cors' \
#     -H 'sec-fetch-site: same-site' \
#     -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36' \
#     --data-raw '{"accountId":null}'
#   sleep 100
# done
