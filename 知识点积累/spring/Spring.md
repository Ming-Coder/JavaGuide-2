## Spring

#### Spring的IOC和AOP

IOC：另一种说法是依赖注入DI，把一些互相依赖的对象的创建、协调工作交给Spring容器去处理，每个对象只需要关注自己的业务代码就好了。

AOP（Aspect Orient Programming），一般称为面向切面编程，作为面向对象的一种补充，用于处理系统中分布于各个模块的横切关注点，比如事务管理、日志、缓存等等。AOP实现的关键在于AOP框架自动创建的AOP代理，AOP代理主要分为静态代理和动态代理，静态代理的代表为AspectJ；而动态代理则以Spring AOP为代表。静态代理是编译期实现，动态代理是运行期实现，可想而知前者拥有更好的性能。本文主要介绍Spring AOP的两种代理实现机制，JDK动态代理和CGLIB动态代理。

静态代理是编译阶段生成AOP代理类，也就是说生成的字节码就织入了增强后的AOP对象；动态代理则不会修改字节码，而是在内存中临时生成一个AOP对象，这个AOP对象包含了目标对象的全部方法，并且在特定的切点做了增强处理，并回调原对象的方法。

SpringAOP中的动态代理主要有两种方式，JDK动态代理和CGLIB动态代理。JDK动态代理通过反射来接收被代理的类，并且要求被代理的类必须实现一个接口。JDK动态代理的核心是InvocationHandler接口和Proxy类。如果目标类没有实现接口，那么Spring AOP会选择使用CGLIB来动态代理目标类。CGLIB（Code Generation Library），是一个代码生成的类库，可以在运行时动态的生成某个类的子类，注意，CGLIB是通过继承的方式做的动态代理，因此如果某个类被标记为final，那么它是无法使用CGLIB做动态代理的，诸如private的方法也是不可以作为切面的。

### Spring mvc 的实现原理

- 用户发送请求至前端控制器DispatcherServlet
- DispatcherServlet收到请求调用HandlerMapping处理器映射器。
- 处理器映射器根据请求url找到具体的处理器，生成处理器对象及处理器拦截器(如果有则生成)一并返回给DispatcherServlet。
- DispatcherServlet通过HandlerAdapter处理器适配器调用处理器
- 执行处理器(Controller，也叫后端控制器)。
- Controller执行完成返回ModelAndView
- HandlerAdapter将controller执行结果ModelAndView返回给DispatcherServlet
- DispatcherServlet将ModelAndView传给ViewReslover视图解析器
- ViewReslover解析后返回具体View
- DispatcherServlet对View进行渲染视图（即将模型数据填充至视图中）。
- DispatcherServlet响应用户。

### SPRING的事务传播特性

- PROPAGATION_REQUIRED–支持当前事务，如果当前没有事务，就新建一个事务。这是最常见的选择。
- PROPAGATION_SUPPORTS–支持当前事务，如果当前没有事务，就以非事务方式执行。
- PROPAGATION_MANDATORY–支持当前事务，如果当前没有事务，就抛出异常。
- PROPAGATION_REQUIRES_NEW–新建事务，如果当前存在事务，把当前事务挂起。
- PROPAGATION_NOT_SUPPORTED–以非事务方式执行操作，如果当前存在事务，就把当前事务挂起。
- PROPAGATION_NEVER–以非事务方式执行，如果当前存在事务，则抛出异常。