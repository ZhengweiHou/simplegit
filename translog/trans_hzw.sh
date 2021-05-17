#logfile='/home/houzw/document/我的坚果云/simplegit/trans.log'
basedir=`readlink -f $0`
basedir=${basedir%/*}
logfile="${basedir}/trans.log"

if [ ! -f ${logfile} ]
then
    echo -n '' >> ${logfile}
fi

if [ $1 == "show" ]
then
    readlink -f ${logfile}
    cat ${logfile}
    exit 0
fi

grep -q "$@ " ${logfile}
if [ $? -eq 0 ] 
then
    sed "/$@/ s/$/x/" $logfile -i
else
    printf "%-15s  "  "$@  " >> ${logfile}
    transc=`trans -b $@`
    printf "%-15s  \n"  "$transc" >> ${logfile}
    #trans -b $@ |tee -a ${logfile}
    #echo "========================" >> ${logfile}
    echo "file:${logfile}"
fi
trans $@
