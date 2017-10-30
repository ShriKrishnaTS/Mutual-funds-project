#!/bin/sh
HOST='ftpservice.acesphere.com'
USERNAME='rupeevest'
PASSWD='Rup$02F16'
#SOURCEDIR='/mutualfund/$CURRDATE'
SOURCEDIR='/mutualfund/31082016'
TARGETDIR='../data'
ARCDIR='../arc'
CWD=`pwd`
CURRDATE=`date +%d%m%Y`
cd $TARGETDIR
for filename in `ls`
do
        fname=`echo $filename`
        fname+=`echo $CURRDATE`
        mv $filename ../arc/$fname
done

cd $CWD

ftp -in -v $HOST << EOF
user $USERNAME $PASSWD
cd /mutualfund/16082016
lcd ../data
mget *.*
bye
EOF
cd $CWD
# wget http://rupeevest.langoorqa.net/benchmark_history/read_bm_indices
