## Netty

Netty是一个高性能网络编程框架。

核心组件：

- Channel
- 回调
- Future
- 事件和ChannelHandler

###Channel

Channel是 Java nio的一个基本构造。

它代表一个到实体(如一个硬件设备、一个文件、一个网络套接字或者一个能够执行一个或者多个不同的ⅣO操作的程序组件)的开放连接,如读操作和写操作。目前,可以把 Channe1看作是传入(人站)或者传出(出站)数据的载体。因此,它可以被打开或者被关闭,连接或者断开连接。 

### 回调

一个回调其实就是一个方法,一个指向已经被提供给另外一个方法的方法的引|用。这使得后者可以在适当的时候调用前者。回调在广泛的编程场景中都有应用,而且也是在操作完成后通知相关方最常见的方式之一。

Nety在内部使用了回调来处理事件;当一个回调被触发时,相关的事件可以被一个 interfaceChanne1 Handler的实现处理。代码清单1-2展示了一个例子:当一个新的连接已经被建立时,Channe handler的 channe1 Active()回调方法将会被调用,并将打印出一条信息。

### Future

Future提供了另一种在操作完成时通知应用程序的方式。这个对象可以看作是一个异步操作的结果的占位符;它将在未来的某个时刻完成,并提供对其结果的访问。

### 事件和ChannelHandler

Nety使用不同的事件来通知我们状态的改变或者是操作的状态。这使得我们能够基于已经发生的事件来触发适当的动作。这些动作可能是:

- 记录日志
- 数据转换
- 流控制
- 应用程序逻辑

### 把他们放在一起

Nety的异步编程模型是建立在 Future和回调的概念之上的,而将事件派发到 ChannelHandler的方法则发生在更深的层次上。结合在一起,这些元素就提供了一个处理环境,使你的应用程序逻辑可以独立于任何网络操作相关的顾虑而独立地演变。这也是Nety的设计方式的一个关键目标。

### netty组件和设计

#### Channel、EventLoop、ChannelFuture

##### Channel接口

Channel的一些基本结构类：

- Embeddedchannel
- Localserverchannel
- NioDatagramChannel
- NioSctpChannel
- Niosocket channel

##### EventLoop接口

- 一个 EventLoopGroup包含一个或者多个 EventLoop;
- 一个 EventLoop在它的生命周期内只和一个 Thread绑定;
- 所有由 Eventloop处理的IO事件都将在它专有的 Thread上被处理;
- 一个 Channe1在它的生命周期内只注册于一个 EventLoop;
- 一个 EventLoop可能会被分配给一个或多个 Channel。

##### ChannelFuture接口

正如我们已经解释过的那样, Netty中所有的I/O操作都是异步的。因为一个操作可能不会立即返回,所以我们需要一种用于在之后的某个时间点确定其结果的方法。为此,Nety提供了Channe1 Future接口,其 addlistener()方法注册了一个 Channe1 Futurelistener,以便在某个操作完成时(无论是否成功)得到通知。