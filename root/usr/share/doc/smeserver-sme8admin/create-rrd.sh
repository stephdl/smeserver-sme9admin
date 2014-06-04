#!/bin/sh

#script for the creation of rrds
#creation of the directory for the rrd files
if [ -d /var/lib/sme8admin ]
then
    mv /var/lib/sme8admin /var/lib/sme8admin.old
    echo -e "Backup of the existing rrds directory :\t[OK]"
fi

mkdir -p /var/lib/sme8admin/
echo -e "Creation of the rrds directory :\t[OK]"

#creation of the rrds
#we have a pdp each 300s=5mn
#time for computing a cdp   + number of pdp by cdp:nb cdp
#- On 1h, avg on 5mn  + 1:12
#- On 6h, avg on 5mn  + 1:72            
#- On 1j, avg on 5mn  + 1:288
#- On 1s, avg on 30mn + 6:336        
#- On 1m, avg on 2h   + 24:372         
#- On 1a, avg on 1j   + 288:365        

#sensors.rrd : informations concernant le materiel

# t1 : temperature du processeur en degres centigrades
# thd1 : temperature du disque dur principal
# thd2 : temperature du disque dur 2 si disponible
# t2 : temperature du boitier/carte mere
# fspd : vitesse du ventilateur processeur

rrdtool create /var/lib/sme8admin/sensors.rrd -s 300 \
    DS:t1:GAUGE:600:0:100 \
    DS:t2:GAUGE:600:0:100 \
    DS:thd1:GAUGE:600:0:100 \
    DS:thd2:GAUGE:600:0:100 \
    DS:fspd:GAUGE:600:0:10000 \
    RRA:AVERAGE:0.5:1:12 \
    RRA:AVERAGE:0.5:1:72 \
    RRA:AVERAGE:0.5:1:288 \
    RRA:AVERAGE:0.5:6:336 \
    RRA:AVERAGE:0.5:24:372 \
    RRA:AVERAGE:0.5:288:365 \
    RRA:MAX:0.5:1:12 \
    RRA:MAX:0.5:1:72 \
    RRA:MAX:0.5:1:288 \
    RRA:MAX:0.5:6:336 \
    RRA:MAX:0.5:24:372 \
    RRA:MAX:0.5:288:365 \
    RRA:MIN:0.5:1:12 \
    RRA:MIN:0.5:1:72 \
    RRA:MIN:0.5:1:288 \
    RRA:MIN:0.5:6:336 \
    RRA:MIN:0.5:24:372 \
    RRA:MIN:0.5:288:365 \

#hd.rrd : informations sur l'occupation du disque dur

# total : taille totale du disque en ko
# used : place utilisee
# free : place libre
# log : place prise par /var/log/
# files : place prise par /home/e-smith/files/
# squid : place prise par /var/spool/squid/
# mysql : place prise par /var/lib/mysql/
# blckread : nb de blocks lus par secondes
# blckwrite : nb de blocks ecrits par secondes
    
rrdtool create /var/lib/sme8admin/hd.rrd -s 300 \
    DS:total:GAUGE:600:0:U \
    DS:used:GAUGE:600:0:U \
    DS:free:GAUGE:600:0:U \
    DS:log:GAUGE:600:0:U \
    DS:files:GAUGE:600:0:U \
    DS:squid:GAUGE:600:0:U \
    DS:mysql:GAUGE:600:0:U \
    DS:blckread:GAUGE:600:0:U \
    DS:blckwrite:GAUGE:600:0:U \
    RRA:AVERAGE:0.5:1:12 \
    RRA:AVERAGE:0.5:1:72 \
    RRA:AVERAGE:0.5:1:288 \
    RRA:AVERAGE:0.5:6:336 \
    RRA:AVERAGE:0.5:24:372 \
    RRA:AVERAGE:0.5:288:365 \
    RRA:MAX:0.5:1:12 \
    RRA:MAX:0.5:1:72 \
    RRA:MAX:0.5:1:288 \
    RRA:MAX:0.5:6:336 \
    RRA:MAX:0.5:24:372 \
    RRA:MAX:0.5:288:365 \
    RRA:MIN:0.5:1:12 \
    RRA:MIN:0.5:1:72 \
    RRA:MIN:0.5:1:288 \
    RRA:MIN:0.5:6:336 \
    RRA:MIN:0.5:24:372 \
    RRA:MIN:0.5:288:365 \

#if_loc.rrd : trafic sur l'interface reseau locale

# bin : nombre d'octets en entree
# bout : nombre d'octets en sortie
# pin : nombre de packets en entree
# pout : nombre de packets en sortie

rrdtool create /var/lib/sme8admin/if_loc.rrd -s 300 \
    DS:bin:GAUGE:600:0:U \
    DS:bout:GAUGE:600:0:U \
    DS:pin:GAUGE:600:0:U \
    DS:pout:GAUGE:600:0:U \
    RRA:AVERAGE:0.5:1:12 \
    RRA:AVERAGE:0.5:1:72 \
    RRA:AVERAGE:0.5:1:288 \
    RRA:AVERAGE:0.5:6:336 \
    RRA:AVERAGE:0.5:24:372 \
    RRA:AVERAGE:0.5:288:365 \
    RRA:MAX:0.5:1:12 \
    RRA:MAX:0.5:1:72 \
    RRA:MAX:0.5:1:288 \
    RRA:MAX:0.5:6:336 \
    RRA:MAX:0.5:24:372 \
    RRA:MAX:0.5:288:365 \
    RRA:MIN:0.5:1:12 \
    RRA:MIN:0.5:1:72 \
    RRA:MIN:0.5:1:288 \
    RRA:MIN:0.5:6:336 \
    RRA:MIN:0.5:24:372 \
    RRA:MIN:0.5:288:365 \
    
#if_ext.rrd : trafic sur l'interface reseau externe

rrdtool create /var/lib/sme8admin/if_ext.rrd -s 300 \
    DS:bin:GAUGE:600:0:U \
    DS:bout:GAUGE:600:0:U \
    DS:pin:GAUGE:600:0:U \
    DS:pout:GAUGE:600:0:U \
    RRA:AVERAGE:0.5:1:12 \
    RRA:AVERAGE:0.5:1:72 \
    RRA:AVERAGE:0.5:1:288 \
    RRA:AVERAGE:0.5:6:336 \
    RRA:AVERAGE:0.5:24:372 \
    RRA:AVERAGE:0.5:288:365 \
    RRA:MAX:0.5:1:12 \
    RRA:MAX:0.5:1:72 \
    RRA:MAX:0.5:1:288 \
    RRA:MAX:0.5:6:336 \
    RRA:MAX:0.5:24:372 \
    RRA:MAX:0.5:288:365 \
    RRA:MIN:0.5:1:12 \
    RRA:MIN:0.5:1:72 \
    RRA:MIN:0.5:1:288 \
    RRA:MIN:0.5:6:336 \
    RRA:MIN:0.5:24:372 \
    RRA:MIN:0.5:288:365 \

#net.rrd : informations sur le reseau

# samba : nombre de connexions samba actives
# dhcp : nombre de baux dhcp actifs
# mail_in : nombre de mails entrants
# mail_out : nombre de mails sortants
# spam : nombre de mails filtres par l'antispam
# virus : nombre de mails filtres par l'antivirus
# minlatency : ping minimum
# avglatency : ping moyen
# maxlatency : ping maximum
# loss : % de packets perdus sur un ping

rrdtool create /var/lib/sme8admin/net.rrd -s 300 \
    DS:samba:GAUGE:600:0:U \
    DS:dhcp:GAUGE:600:0:U \
    DS:mail_in:GAUGE:600:0:U \
    DS:mail_out:GAUGE:600:0:U \
    DS:spam:GAUGE:600:0:U \
    DS:virus:GAUGE:600:0:U \
    DS:minlatency:GAUGE:600:0:U \
    DS:avglatency:GAUGE:600:0:U \
    DS:maxlatency:GAUGE:600:0:U \
    DS:loss:GAUGE:600:0:U \
    RRA:AVERAGE:0.5:1:12 \
    RRA:AVERAGE:0.5:1:72 \
    RRA:AVERAGE:0.5:1:288 \
    RRA:AVERAGE:0.5:6:336 \
    RRA:AVERAGE:0.5:24:372 \
    RRA:AVERAGE:0.5:288:365 \
    RRA:MAX:0.5:1:12 \
    RRA:MAX:0.5:1:72 \
    RRA:MAX:0.5:1:288 \
    RRA:MAX:0.5:6:336 \
    RRA:MAX:0.5:24:372 \
    RRA:MAX:0.5:288:365 \
    RRA:MIN:0.5:1:12 \
    RRA:MIN:0.5:1:72 \
    RRA:MIN:0.5:1:288 \
    RRA:MIN:0.5:6:336 \
    RRA:MIN:0.5:24:372 \
    RRA:MIN:0.5:288:365 \

#cpu.rrd : utilisation des ressources processeur

# total : 1-idle
# idle : temps "libre" du processeur
# system : % occupe par les processus systemes
# user : % occupe par les processus utilisateurs
# nice : % occupe par les processus utilisateurs avec priorite nice
# plist : nombre de processus total
# runq : nombre de processus en attente
# load1 : charge du processeur dans la derniere minute
# load5 : charge du processeur dans les 5 dernieres minutes
# load15 : charge du processeur dans les 15 dernieres minutes
# uptime : temps depuis le dernier reboot

rrdtool create /var/lib/sme8admin/cpu.rrd -s 300 \
    DS:total:GAUGE:600:0:U \
    DS:idle:GAUGE:600:0:U \
    DS:system:GAUGE:600:0:U \
    DS:user:GAUGE:600:0:U \
    DS:nice:GAUGE:600:0:U \
    DS:plist:GAUGE:600:0:U \
    DS:runq:GAUGE:600:0:U \
    DS:load1:GAUGE:600:0:U \
    DS:load5:GAUGE:600:0:U \
    DS:load15:GAUGE:600:0:U \
    DS:uptime:GAUGE:600:0:U \
    RRA:AVERAGE:0.5:1:12 \
    RRA:AVERAGE:0.5:1:72 \
    RRA:AVERAGE:0.5:1:288 \
    RRA:AVERAGE:0.5:6:336 \
    RRA:AVERAGE:0.5:24:372 \
    RRA:AVERAGE:0.5:288:365 \
    RRA:MAX:0.5:1:12 \
    RRA:MAX:0.5:1:72 \
    RRA:MAX:0.5:1:288 \
    RRA:MAX:0.5:6:336 \
    RRA:MAX:0.5:24:372 \
    RRA:MAX:0.5:288:365 \
    RRA:MIN:0.5:1:12 \
    RRA:MIN:0.5:1:72 \
    RRA:MIN:0.5:1:288 \
    RRA:MIN:0.5:6:336 \
    RRA:MIN:0.5:24:372 \
    RRA:MIN:0.5:288:365 \

#mem.rrd : occupation de la memoire vive

# memtotal : memoire totale physique
# memused : memoire utilisee - (cachee + buffers)
# memfree : memoire libre + (cachee + buffers)
# memactualused : memoire utilisee
# memactualfree : memoire libre
# membuffers : buffers memoire du noyau
# memcached : memoire cachee pour les donnees
# swaptotal : memoire totale virtuelle
# swapused : occupation du swap
# swapfree : partie libre du swap

rrdtool create /var/lib/sme8admin/mem.rrd -s 300 \
    DS:memtotal:GAUGE:600:0:U \
    DS:memused:GAUGE:600:0:U \
    DS:memfree:GAUGE:600:0:U \
    DS:memactualused:GAUGE:600:0:U \
    DS:memactualfree:GAUGE:600:0:U \
    DS:membuffers:GAUGE:600:0:U \
    DS:memcached:GAUGE:600:0:U \
    DS:swaptotal:GAUGE:600:0:U \
    DS:swapused:GAUGE:600:0:U \
    DS:swapfree:GAUGE:600:0:U \
    RRA:AVERAGE:0.5:1:12 \
    RRA:AVERAGE:0.5:1:72 \
    RRA:AVERAGE:0.5:1:288 \
    RRA:AVERAGE:0.5:6:336 \
    RRA:AVERAGE:0.5:24:372 \
    RRA:AVERAGE:0.5:288:365 \
    RRA:MAX:0.5:1:12 \
    RRA:MAX:0.5:1:72 \
    RRA:MAX:0.5:1:288 \
    RRA:MAX:0.5:6:336 \
    RRA:MAX:0.5:24:372 \
    RRA:MAX:0.5:288:365 \
    RRA:MIN:0.5:1:12 \
    RRA:MIN:0.5:1:72 \
    RRA:MIN:0.5:1:288 \
    RRA:MIN:0.5:6:336    \
    RRA:MIN:0.5:24:372 \
    RRA:MIN:0.5:288:365 \
                                                                                              
# httpd.rrd : stats serveur apache

# cpu : occupation cpu de httpd
# mem : occupation memoire 
# nbproc : nombre de processus

rrdtool create /var/lib/sme8admin/httpd.rrd -s 300 \
    DS:cpu:GAUGE:600:0:U \
    DS:mem:GAUGE:600:0:U \
    DS:nbproc:GAUGE:600:0:U \
    RRA:AVERAGE:0.5:1:12 \
    RRA:AVERAGE:0.5:1:72 \
    RRA:AVERAGE:0.5:1:288 \
    RRA:AVERAGE:0.5:6:336 \
    RRA:AVERAGE:0.5:24:372 \
    RRA:AVERAGE:0.5:288:365 \
    RRA:MAX:0.5:1:12 \
    RRA:MAX:0.5:1:72 \
    RRA:MAX:0.5:1:288 \
    RRA:MAX:0.5:6:336 \
    RRA:MAX:0.5:24:372 \
    RRA:MAX:0.5:288:365 \
    RRA:MIN:0.5:1:12 \
    RRA:MIN:0.5:1:72 \
    RRA:MIN:0.5:1:288 \
    RRA:MIN:0.5:6:336    \
    RRA:MIN:0.5:24:372 \
    RRA:MIN:0.5:288:365 \


# samba.rrd : stats serveur samba

rrdtool create /var/lib/sme8admin/samba.rrd -s 300 \
    DS:cpu:GAUGE:600:0:U \
    DS:mem:GAUGE:600:0:U \
    DS:nbproc:GAUGE:600:0:U \
    RRA:AVERAGE:0.5:1:12 \
    RRA:AVERAGE:0.5:1:72 \
    RRA:AVERAGE:0.5:1:288 \
    RRA:AVERAGE:0.5:6:336 \
    RRA:AVERAGE:0.5:24:372 \
    RRA:AVERAGE:0.5:288:365 \
    RRA:MAX:0.5:1:12 \
    RRA:MAX:0.5:1:72 \
    RRA:MAX:0.5:1:288 \
    RRA:MAX:0.5:6:336 \
    RRA:MAX:0.5:24:372 \
    RRA:MAX:0.5:288:365 \
    RRA:MIN:0.5:1:12 \
    RRA:MIN:0.5:1:72 \
    RRA:MIN:0.5:1:288 \
    RRA:MIN:0.5:6:336    \
    RRA:MIN:0.5:24:372 \
    RRA:MIN:0.5:288:365 \


# afpd.rrd : stats serveur apple file protocol

rrdtool create /var/lib/sme8admin/afp.rrd -s 300 \
    DS:cpu:GAUGE:600:0:U \
    DS:mem:GAUGE:600:0:U \
    DS:nbproc:GAUGE:600:0:U \
    RRA:AVERAGE:0.5:1:12 \
    RRA:AVERAGE:0.5:1:72 \
    RRA:AVERAGE:0.5:1:288 \
    RRA:AVERAGE:0.5:6:336 \
    RRA:AVERAGE:0.5:24:372 \
    RRA:AVERAGE:0.5:288:365 \
    RRA:MAX:0.5:1:12 \
    RRA:MAX:0.5:1:72 \
    RRA:MAX:0.5:1:288 \
    RRA:MAX:0.5:6:336 \
    RRA:MAX:0.5:24:372 \
    RRA:MAX:0.5:288:365 \
    RRA:MIN:0.5:1:12 \
    RRA:MIN:0.5:1:72 \
    RRA:MIN:0.5:1:288 \
    RRA:MIN:0.5:6:336    \
    RRA:MIN:0.5:24:372 \
    RRA:MIN:0.5:288:365 \


# squid.rrd : stats proxy squid

rrdtool create /var/lib/sme8admin/squid.rrd -s 300 \
    DS:cpu:GAUGE:600:0:U \
    DS:mem:GAUGE:600:0:U \
    DS:nbproc:GAUGE:600:0:U \
    RRA:AVERAGE:0.5:1:12 \
    RRA:AVERAGE:0.5:1:72 \
    RRA:AVERAGE:0.5:1:288 \
    RRA:AVERAGE:0.5:6:336 \
    RRA:AVERAGE:0.5:24:372 \
    RRA:AVERAGE:0.5:288:365 \
    RRA:MAX:0.5:1:12 \
    RRA:MAX:0.5:1:72 \
    RRA:MAX:0.5:1:288 \
    RRA:MAX:0.5:6:336 \
    RRA:MAX:0.5:24:372 \
    RRA:MAX:0.5:288:365 \
    RRA:MIN:0.5:1:12 \
    RRA:MIN:0.5:1:72 \
    RRA:MIN:0.5:1:288 \
    RRA:MIN:0.5:6:336    \
    RRA:MIN:0.5:24:372 \
    RRA:MIN:0.5:288:365 \

# sessions.rrd : stats sessions 

# nombre de sessions a un instant par service

rrdtool create /var/lib/sme8admin/sessions.rrd -s 300 \
    DS:ssh:GAUGE:600:0:U \
    DS:ftp:GAUGE:600:0:U \
    DS:vpn:GAUGE:600:0:U \
    DS:netbios:GAUGE:600:0:U \
    DS:afp:GAUGE:600:0:U \
    RRA:AVERAGE:0.5:1:12 \
    RRA:AVERAGE:0.5:1:72 \
    RRA:AVERAGE:0.5:1:288 \
    RRA:AVERAGE:0.5:6:336 \
    RRA:AVERAGE:0.5:24:372 \
    RRA:AVERAGE:0.5:288:365 \
    RRA:MAX:0.5:1:12 \
    RRA:MAX:0.5:1:72 \
    RRA:MAX:0.5:1:288 \
    RRA:MAX:0.5:6:336 \
    RRA:MAX:0.5:24:372 \
    RRA:MAX:0.5:288:365 \
    RRA:MIN:0.5:1:12 \
    RRA:MIN:0.5:1:72 \
    RRA:MIN:0.5:1:288 \
    RRA:MIN:0.5:6:336    \
    RRA:MIN:0.5:24:372 \
    RRA:MIN:0.5:288:365 \

echo -e "Creation of rrds files :\t\t[OK]"
