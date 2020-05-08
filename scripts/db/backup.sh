(
MD5="no backup yet"
MONTH="no month yet"
while [ 1 ]
do
  #wait for one minute between each backup loop
  sleep 60
  pg_dumpall -U postgres -w > "/dumps/data.tmp"
  newMD5=$(cat /dumps/data.tmp | md5sum)
  if [ "$newMD5" != "$MD5" ]; then
    DATE=$(date +"%Y-%m-%d-%H-%M-%S")
    rm -f /dumps/*.sql
    mv /dumps/data.tmp "/dumps/data.$DATE.sql"
    MD5=$newMD5
  else
    rm -f /dumps/data.tmp
  fi
  
  #keep one monthly backup
  DATE_MONTH=$(date -d "$D" '+%m')
  if [ "$DATE_MONTH" != "$MONTH" ]; then
    mkdir -p /dumps/monthly
    cp /dumps/*.sql /dumps/monthly/
    MONTH=$DATE_MONTH
  fi
  
done
) &

PID=$!
trap 'echo "Will terminate backup process"; kill -s SIGTERM $PID; exit 15' TERM

