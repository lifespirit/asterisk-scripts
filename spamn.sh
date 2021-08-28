#!/bin/bash

botid=bot111222333
botkey=AAssddffgghhjjkkllqqwwweerrttyyuuiioozxc

number=`echo $1 | sed -e 's/+//g'`
to=`echo $2 | sed -e 's/+//g'`
request=`curl -s https://www.neberitrubku.ru/nomer-telefona/$number | grep "li class='active'" | tr -d "\r\n" | sed -e 's/ \+/ /g' -e 's/^ //g' -e 's/<\//\;<\//g' -e 's/<[^>]*>//g' -e 's/; \+/;/g' -e 's\;;\;\g'`
OLDIFS=$IFS
IFS=";"
fails=0
for i in $request
do
  if [[ `echo $i | grep "трицательная"` ]]
  then
    fails=$(($fails+`echo $i | cut -d"x" -f1`))
  fi
done
IFS=$OLDIFS
# If you use script with more then 1 number and want many chats uncomment that
#if [ $to == 71112223344 ]
#then
#  chatid="111222333"
#elif [ $to == 72223334455 ]
#then
#  chatid="222333444"
#elif [ $to == 73334445566 ]
#then
#  chatid="333444555"
#else
  chatid="444555666"
#fi
if [[ $fails > 0 ]]
then
  curl -s "https://api.telegram.org/$botid:$botkey/sendMessage?chat_id=$chatid&&parse_mode=html&text=Звонит номер <b>$number</b>.%0A<b>Определено как спам</b>.%0AОценки: $request.%0Ahttps://www.neberitrubku.ru/nomer-telefona/$number" 2>&1 1>/dev/null
  echo 1
else
  curl -s "https://api.telegram.org/$botid:$botkey/sendMessage?chat_id=$chatid&&parse_mode=html&text=Звонит номер <b>$number</b>.%0AОценки: $request.%0Ahttps://www.neberitrubku.ru/nomer-telefona/$number" 2>&1 1>/dev/null
  echo 0
fi
