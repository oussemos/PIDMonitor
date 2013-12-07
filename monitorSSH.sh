#!/bin/sh
PID_FILE='/var/run/sshd.pid'
PID=`cat $PID_FILE`
 
#On test si le PID existe
PROCESS=`ps --pid $PID`
 
if[ $? == 1 -o ! -f $PID_FILE ]; then
    echo "OUPSS le processus n'existe plus"
    RET=`/etc/init.d/sshd start 2&gt;&amp;1` #On relance le processus
 
    #on s'envoie un petit mail avec le retour de la commande
    #de relance du processus
    echo "SSHD is down.\n $RET" | mail sysadmin@domain.tld -s "SSHD Error"
else
    echo "Tous va bien :)"
fi