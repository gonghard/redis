#centos6.7下redis3.2.0集群
1.先下载好redis-3.2.0.tar.gz(下载地址http://redis.io/)
   
2.通过ftp工具将下载好redis-3.2.0.tar.gz放置/usr/local/redis目录下
    tar -zxvf redis-3.2.0.tar.gz 解压redis-3.2.0.tar.gz到当前目录

3.进入redis-3.2.0目录直接cd redis-3.2.0
  执行以下命令

  make 编译下载相关文件

  make install 将 /usr/local/redis/redis-3.2.0/src/相关redis的执行命令复制到/usr/local/bin目录下
  可以通过以下命令查看ll /usr/local/bin/
   ![](http://i.imgur.com/SjJx9rA.png)
4.在/usr/local/redis目录下创建cluster目录

   mkdir cluster

5.进入cluster创建以下目录
    7000  7002  7003  7004  7005  7006

6.然后将/usr/local/redis/redis-3.2.0/redis.conf依次复制到7000  7002  7003  7004  7005  7006这6个目录（会脚本的可以用脚本创建）

	  cp /usr/local/redis/redis-3.2.0/redis.conf /usr/local/redis/cluster/7000/
	  
	  cp /usr/local/redis/redis-3.2.0/redis.conf /usr/local/redis/cluster/7002/
	  
	  cp /usr/local/redis/redis-3.2.0/redis.conf /usr/local/redis/cluster/7003/
	
	  cp /usr/local/redis/redis-3.2.0/redis.conf /usr/local/redis/cluster/7004
	
	  cp /usr/local/redis/redis-3.2.0/redis.conf /usr/local/redis/cluster/7005/
	
	  cp /usr/local/redis/redis-3.2.0/redis.conf /usr/local/redis/cluster/7006/

7.然后依次修改7000  7002  7003  7004  7005  7006这6个目录下的redis.conf文件的内容
主要修改以下信息

    sed -i "s/6379/7000/g" /usr/local/redis/cluster/7000/redis.conf
    sed -i 's/daemonize no/daemonize yes/g' /usr/local/redis/cluster/7000/redis.conf
    sed -i 's/# cluster-enabled yes/cluster-enabled yes/g' /usr/local/redis/cluster/7000/redis.conf
    sed -i 's/# cluster-node-timeout 15000/cluster-node-timeout 15000/g' /usr/local/redis/cluster/7000/redis.conf
    sed -i "s/# cluster-config-file node.*/cluster-config-file nodes-redis.conf/g" /usr/local/redis/cluster/7000/redis.conf
    启动服务之前，最好是将bind属性设置成redis-server所在服务器的物理地址ip
    redis-server /usr/local/redis/cluster/7000/redis.conf
    只需将7000依次换成7002  7003  7004  7005  7006再执行5次即可
8.执行ps -ef|grep redis

	  root      88979      1  0 16:42 ?        00:00:04 /usr/local/redis/redis-3.2.0/src/redis-server 127.0.0.1:7002 [cluster]
	  root      89112      1  0 16:46 ?        00:00:04 /usr/local/redis/redis-3.2.0/src/redis-server 127.0.0.1:7000 [cluster]
	  root      89439  89119  0 17:49 pts/4    00:00:00 grep redis
	  root     218855      1  0 16:10 ?        00:00:06 /usr/local/redis/redis-3.2.0/src/redis-server 127.0.0.1:7003 [cluster]
	  root     218885      1  0 16:11 ?        00:00:06 /usr/local/redis/redis-3.2.0/src/redis-server 127.0.0.1:7004 [cluster]
	  root     219041      1  0 16:26 ?        00:00:06 /usr/local/redis/redis-3.2.0/src/redis-server 127.0.0.1:7005 [cluster]
	  root     219066      1  0 16:26 ?        00:00:06 /usr/local/redis/redis-3.2.0/src/redis-server 127.0.0.1:7006 [cluster]
看到以上信息说明都启动成功

9.redis cluster的配置是用的ruby脚本写得，那么就需要你最少安装了ruby (apt-get install ruby )和gem。更主要的是你还要用安装ruby所需要的redis模块。 

	 yum -y install zlib ruby rubygems
	 # 安装ruby的redis库
	 gem install redis

10.创建集群

   	/usr/local/redis/redis-3.2.0/src/redis-trib.rb create --replicas 1 127.0.0.1:7000 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 127.0.0.1:7006


11.我们可以检查集群了
![](http://i.imgur.com/Du52ulY.png)
集群成功

注意：创建集群时，其中的参数不能使用主机名,而需要使用IP地址。
注意：如果通过redis-trib.rb创建集群失败。在修复错误后，需要做如下操作，再重新创建，才能创建成功：删除所有物理节点的redis-****.conf中定义的cluster-config-file 所在的文件删除.再重新启动各个redis-server实例。

12.使用

注意：不能用redis-cli -p 7000

使用客户端可通过连接任意一个实例来连接集群

	要用redis-cli -c -p 7000 
	set gaq 'gaq'
	quit


	redis-cli -c -p 7002
	get gaq

13.停止集群

	redis-cli -p 7000 shutdown
	redis-cli -p 7002 shutdown
	......
14.再次启动会自动集群
