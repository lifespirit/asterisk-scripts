#!/bin/bash

botid=bot111222333
botkey=AAssddffgghhjjkkllqqwwweerrttyyuuiioozxc

number=`echo $1 | sed -e 's/+//g' -e 's/8\([0-9]\{10\}\)/7\1/g'`
to=`echo $2 | sed -e 's/+//g'`
whitelist=`grep $number /etc/asterisk/whitelist.txt`
if [ $to == 70001112233 ]
then
  chatid="1111111111"
elif [ $to == 71112223344 ]
then
  chatid="2222222222"
else
  chatid="3333333333"
fi
if [[ -z "$whitelist" ]]
then
  request=`curl -s -L https://callfilter.app/search --data-raw "searchNumber=$number" | grep \<\/li\> | grep class | sed 's/.*>\(.*\)<\/li>/\1/g'`
  OLDIFS=$IFS
  IFS=$'\n'
  fails=0
  goods=0
  for i in $request
  do
    if [[ `echo $i | grep "трицательн"` ]]
    then
      fails=$(($fails+`echo $i | cut -d"x" -f1`))
    fi
    if [[ `echo $i | grep "оложительн"` ]]
    then
      goods=$(($goods+`echo $i | cut -d"x" -f1`))
    fi
  done
  IFS=$OLDIFS
  if [ $(( $fails - $goods )) -gt 0 ]
  then
    curl -s "https://api.telegram.org/$botid:$botkey/sendMessage?chat_id=$chatid&&parse_mode=html&text=Звонит%20номер%20<b>$number</b>%20.%0A<b>Определено%20как%20спам</b>.%0AОценки:%20`echo $request | sed 's/ /%20/g' | tr "\n" " " | sed 's/ /%0A/g'`.%0Ahttps://callfilter.app/$number" 2>&1 1>/dev/null
    echo 1
  else
    curl -s "https://api.telegram.org/$botid:$botkey/sendMessage?chat_id=$chatid&&parse_mode=html&text=Звонит%20номер%20<b>$number</b>%20.%0AОценки:%20`echo $request | sed 's/ /%20/g' | tr "\n" " " | sed 's/ /%0A/g'`.%0Ahttps://callfilter.app/$number" 2>&1 1>/dev/null
    echo 0
  fi
else
  curl -s "https://api.telegram.org/$botid:$botkey/sendMessage?chat_id=$chatid&&parse_mode=html&text=Звонит%20номер%20<b>$number</b>%20.%0AНомер%20в%20белом%20списке." 2>&1 1>/dev/null
  echo 0  
fi
