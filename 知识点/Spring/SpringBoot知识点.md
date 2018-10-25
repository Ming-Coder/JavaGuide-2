## 核心特性

### SpringBoot 三大特性

- 组件自动装配：Web MVC、Web Flux、JDBC等
- 嵌入式Web容器：Tomcat、Jetty 以及 Undertow
- 生成准备特性：指标、健康检测、外部化配置等。

### 组件的自动装配

- 激活：@EnableAutoConfiguration
- 配置：/META-INF/spring.factories
- 实现：XXXAutoConfiguration

## Servlet 应用

1、组合使用下面的 Servlet 注解达到传统的 Servlet。

@ServletComponentScan + 

- @WebServlet
- @WebFilter
- @WebListener

2、Spring Bean

​	@Bean +

 - Servlet
 - Listenter
 - Filter

3、 RegisterationBean

 - ServletRegisterationBean
 - ServletListenterRegisterationBean
 - FilterRegisterationBean

### 异步非阻塞

**异步 Servlet**

- javax.servlet.ServletRequest#startAsync
- javax.servlet.AsyncContext

**非阻塞 Servlet**

- javax.servlet.ServletInputStream#setReadListener
  - javax.servlet.ReadListener
- javax.servlet.ServletOutputStream#setWriteListener
  - javax.servlet.WriteListener 