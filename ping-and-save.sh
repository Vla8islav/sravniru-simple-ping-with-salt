#!/bin/bash 

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LOG_DIR=$DIR/logs
mkdir $LOG_DIR
HOST=https://www.sravni.ru/

URL=(
banki/
bank/gazprombank/karty/
enciklopediya/
ipoteka/top/
kredity/onlajn-zayavka-na-kredit/
strakhovye-kompanii/
bank/gazprombank/karty/
bank/gazprombank/ipoteka/
strakhovaja-kompanija/alfastrahovanie/
bank/gazprombank/kredity/
kredity/refinansirovanie/
bank/gazprombank/kredity/
kredity/
)
GET_PARAM_NAME=test-sravni

for path in ${URL[@]}; do
    SALT=$(env LC_CTYPE=C LC_ALL=C tr -dc "a-z0-9" < /dev/urandom | head -c 5)
    TIME_STAMP=$(date +%s)
    URL="${HOST}${path}?${GET_PARAM_NAME}=${TIME_STAMP}-${SALT}"
    echo $URL
    FILENAME=$(echo $TIME_STAMP-$URL | sed "s/[^0-9a-zA-Z\-]/-/g").log

    curl -i $URL --write-out "\n%{url_effective}\n" | tee $LOG_DIR/$FILENAME 
    sleep 1
done
