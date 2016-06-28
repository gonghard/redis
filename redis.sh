#! /bin/sh
if [ "$1" = "start" ];then
   echo "start"
    nohup redis-server /usr/local/redis/cluster-test/7000/redis.conf &
    sleep 10s
    nohup redis-server /usr/local/redis/cluster-test/7002/redis.conf &
    sleep 10s
    nohup redis-server /usr/local/redis/cluster-test/7003/redis.conf &
    sleep 10s
    nohup redis-server /usr/local/redis/cluster-test/7004/redis.conf &
    sleep 10s
    nohup redis-server /usr/local/redis/cluster-test/7005/redis.conf &
    sleep 10s
    nohup redis-server /usr/local/redis/cluster-test/7006/redis.conf &
elif [ "$1" = "shutdown" ];then
   echo "shutdown"
   redis-cli -p 7000 shutdown;
   redis-cli -p 7002 shutdown;
   redis-cli -p 7003 shutdown;
   redis-cli -p 7004 shutdown;
   redis-cli -p 7005 shutdown;
   redis-cli -p 7006 shutdown;
else
   echo " sart or shutdown"
   exit
fi
