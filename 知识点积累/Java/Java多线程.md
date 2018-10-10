## 线程如何实现

继承Thread或者实现Runable，重写run方法。start方法才是启动一个线程，而run则是启动main这个线程，即按照执行顺序进行。sleep是Thread的方法，waity是Object的方法。

## 线程池

ThreadPoolExecutor 的内部工作原理

- corePoolSize ：池中所保存的线程数，包括空闲线程。
- maximumPoolSize：池中允许的最大线程数。
- keepAliveTime： 当线程数大于核心时，此为终止前多余的空闲线程等待新任务的最长时间。
- unit：keepAliveTime 参数的时间单位。
- workQueue ：执行前用于保持任务的队列。此队列仅保持由 execute方法提交的 Runnable任务。
- threadFactory：执行程序创建新线程时使用的工厂。
- handler ：由于超出线程范围和队列容量而使执行

被阻塞时所使用的处理程序。ThreadPoolExecutor是Executors类的底层实现。

整个思路总结起来就是 5 句话：

- 如果当前池大小 poolSize 小于 corePoolSize ，则创建新线程执行任务。
- 如果当前池大小 poolSize 大于 corePoolSize ，且等待队列未满，则进入等待队列
- 如果当前池大小 poolSize 大于 corePoolSize 且小于 maximumPoolSize ，且等待队列已满，则创建新线程执行任务。
- 如果当前池大小 poolSize 大于 corePoolSize 且大于 maximumPoolSize ，且等待队列已满，则调用拒绝策略来处理该任务。
- 线程池里的每个线程执行完任务后不会立刻退出，而是会去检查下等待队列里是否还有线程任务需要执行，如果在 keepAliveTime 里等不到新的任务了，那么线程就会退出。

拒绝策略：

- CallerRunsPolicy：不使用线程池执行
- AbortPolicy：抛出异常，默认
- DiscardPolicy：直接丢弃任务
- DiscardOldestPolicy：丢弃队列中最旧的任务

## 线程下面有哪些工具

Concurrent包下面有一些线程工具类，lock、atomic等。

## 并行和并行？

并行：

- 并行性是指**同一时刻内**发生两个或多个事件。
- 并行是在**不同**实体上的多个事件

并行：

- 并发性是指**同一时间间隔内**发生两个或多个事件
- 并发是在**同一实体**上的多个事件

由此可见：并行是针对进程的，**并发是针对线程的**。

## synchronized和Reentrantlock异同？





