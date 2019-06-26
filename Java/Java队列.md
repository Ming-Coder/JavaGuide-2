## Java内置 队列总结

| 队列                  | 有界性         | 锁   | 数据结构 |
| --------------------- | -------------- | ---- | -------- |
| ArrayBlockingQueue    | 有界           | Y    | 数组     |
| LinkedBlockingQueue   | 可选，默认无界 | Y    | 链表     |
| ConcurrentLinkedQueue | 无界           | N    | 链表     |
| LinkedTransferQueue   | 无界           | N    | 链表     |
| PriorityBlockingQueue | 无界           | Y    | 二叉堆   |
| DelayQueue            | 无界           | Y    | 堆       |

- [ArrayBlockingQueue](https://jlj98.top/2018/07/29/Java-ArrayBlockingQueue/)
- [LinkedBlockingQueue](https://jlj98.top/2018/07/30/Java-LinkedBlockingDeque/)
- [ConcurrentLinkedQueue](https://jlj98.top/2018/07/27/Java-ConcurrentLinkedQueue/)
- LinkedTransferQueue
- [PriorityBlockingQueue](https://jlj98.top/2018/07/29/Java-PriorityBlockingQueue/)
- [DelayQueue](https://jlj98.top/2018/07/30/Java-DelayQueue/)