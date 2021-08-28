# asterisk-scripts
Scripts for asterisk shell module

telegrammp3 - send voicemail to telegram chat.

voicemail.conf format need look like this:

```[general]
format=wav
serveremail=asterisk@voice.local
attach=yes
emaildateformat=%A, %d %B %Y at %H:%M:%S
emailbody=XTGMESSAGE_ ${VM_CALLERID} _ ${VM_DATE}
mailcmd=/usr/local/sbin/telegrammp3
sendvoicemail=no

[zonemessages]
eastern=America/New_York|'vm-received' Q 'digits/at' Imp
central=America/Chicago|'vm-received' Q 'digits/at' Imp
central24=America/Chicago|'vm-received' q 'digits/at' H N 'hours'
military=Zulu|'vm-received' q 'digits/at' H N 'hours' 'phonetic/z_p'
european=Europe/Copenhagen|'vm-received' a d b 'digits/at' HM

[voicemail]
1 => $voicemail_password,homegroup,$tg_client_id,delete=yes
```

spamn.sh - drop spam calls. Return 1 if spam or 0 if isn't spam

For more information look:

https://crabs.pro/?go=all/boremsya-so-spamom-s-pomoschyu-asterisk/ 
