redis.clients.jedis.exceptions.JedisConnectionException: Could not get a resource from the pool
	at redis.clients.util.Pool.getResource(Pool.java:50)
	at redis.clients.jedis.ShardedJedisPool.getResource(ShardedJedisPool.java:36)
	at com.sosino.cache.core.redis.JedisUtil.get(JedisUtil.java:1040)
	at com.sosino.test.TestRedis.getSettUnitBySettUnitIdTest(TestRedis.java:23)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.junit.runners.model.FrameworkMethod$1.runReflectiveCall(FrameworkMethod.java:47)
	at org.junit.internal.runners.model.ReflectiveCallable.run(ReflectiveCallable.java:12)
	at org.junit.runners.model.FrameworkMethod.invokeExplosively(FrameworkMethod.java:44)
	at org.junit.internal.runners.statements.InvokeMethod.evaluate(InvokeMethod.java:17)
	at org.springframework.test.context.junit4.statements.RunBeforeTestMethodCallbacks.evaluate(RunBeforeTestMethodCallbacks.java:73)
	at org.springframework.test.context.junit4.statements.RunAfterTestMethodCallbacks.evaluate(RunAfterTestMethodCallbacks.java:82)
	at org.springframework.test.context.junit4.statements.SpringRepeat.evaluate(SpringRepeat.java:73)
	at org.junit.runners.ParentRunner.runLeaf(ParentRunner.java:271)
	at org.springframework.test.context.junit4.SpringJUnit4ClassRunner.runChild(SpringJUnit4ClassRunner.java:224)
	at org.springframework.test.context.junit4.SpringJUnit4ClassRunner.runChild(SpringJUnit4ClassRunner.java:83)
	at org.junit.runners.ParentRunner$3.run(ParentRunner.java:238)
	at org.junit.runners.ParentRunner$1.schedule(ParentRunner.java:63)
	at org.junit.runners.ParentRunner.runChildren(ParentRunner.java:236)
	at org.junit.runners.ParentRunner.access$000(ParentRunner.java:53)
	at org.junit.runners.ParentRunner$2.evaluate(ParentRunner.java:229)
	at org.springframework.test.context.junit4.statements.RunBeforeTestClassCallbacks.evaluate(RunBeforeTestClassCallbacks.java:61)
	at org.springframework.test.context.junit4.statements.RunAfterTestClassCallbacks.evaluate(RunAfterTestClassCallbacks.java:68)
	at org.junit.runners.ParentRunner.run(ParentRunner.java:309)
	at org.springframework.test.context.junit4.SpringJUnit4ClassRunner.run(SpringJUnit4ClassRunner.java:163)
	at org.eclipse.jdt.internal.junit4.runner.JUnit4TestReference.run(JUnit4TestReference.java:86)
	at org.eclipse.jdt.internal.junit.runner.TestExecution.run(TestExecution.java:38)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:459)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:675)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.run(RemoteTestRunner.java:382)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.main(RemoteTestRunner.java:192)
Caused by: java.util.NoSuchElementException: Unable to validate object
	at org.apache.commons.pool2.impl.GenericObjectPool.borrowObject(GenericObjectPool.java:506)
	at org.apache.commons.pool2.impl.GenericObjectPool.borrowObject(GenericObjectPool.java:363)
	at redis.clients.util.Pool.getResource(Pool.java:48)
	... 32 common frames omitted

1.若报以上错误，由于其中有redis服务不能访问导致的,当其中有一个可以访问(testOnBorrow=true)也会报这个错误

2.解决办法

  2.1.用ps -ef|grep redis 检查是否启动成功

  2.2.查看防火墙端口号是否开启
  
  2.3.查看redis.conf配置文件bind 是否限制了ip访问