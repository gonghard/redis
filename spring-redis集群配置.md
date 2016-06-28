1.引入jar(本人maven构建)

	<dependency>
		<groupId>org.springframework.data</groupId>
		<artifactId>spring-data-redis</artifactId>
		<version>1.6.2.RELEASE</version>
	</dependency>
	<dependency>
		<groupId>redis.clients</groupId>
		<artifactId>jedis</artifactId>
		<version>2.7.3</version>
	</dependency>       
2.spring-redis.xml
	
	  <bean id="jedisPoolConfig" class="redis.clients.jedis.JedisPoolConfig">
			<property name="maxTotal" value="2048" />
			<property name="maxIdle" value="200" />
			<property name="numTestsPerEvictionRun" value="1024" />
			<property name="timeBetweenEvictionRunsMillis" value="30000" />
			<property name="minEvictableIdleTimeMillis" value="-1" />
			<property name="softMinEvictableIdleTimeMillis" value="10000" />
			<property name="maxWaitMillis" value="1500" />
			<property name="testOnBorrow" value="true" />
			<property name="testWhileIdle" value="true" />
			<property name="testOnReturn" value="false" />
			<property name="jmxEnabled" value="true" />
			<property name="jmxNamePrefix" value="chbigdata" />
			<property name="blockWhenExhausted" value="false" />
		</bean>
		<bean id="shardedJedisPool" class="redis.clients.jedis.ShardedJedisPool">
			<constructor-arg index="0" ref="jedisPoolConfig" />
			<constructor-arg index="1">
				<list>
					<bean name="slaver" class="redis.clients.jedis.JedisShardInfo">
						<constructor-arg index="0" value="192.168.0.133" />
						<constructor-arg index="1" value="7004" type="int" />
					</bean>
					<bean name="master" class="redis.clients.jedis.JedisShardInfo">
						<constructor-arg index="0" value="192.168.0.133" />
						<constructor-arg index="1" value="7000" type="int" />
					</bean>
				</list>
			</constructor-arg>
		</bean>
    