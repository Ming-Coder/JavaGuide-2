## 一些简单介绍 

- groupId：定义项目属于哪个组 

- artifactId：当前组内唯一ID 

- version：版本号 

- scope：依赖范围。
  - compole：编译依赖范围
  - test：测试依赖范围
  - provided：已提供依赖范围
  - runtime：运行时依赖范围
  - system ：系统依赖范围

- packing：打包方式：jar和war 

## Maven 命令使用

- mvn clean：清除

- mvn package：打包
- mvn install：
- mvn deploy：

**跳过测试**：mvn package -DskipTests

**跳过测试运行，临时跳过测试代码编译**：mvn package -Dmaven.test.skip=true

## Maven Profile

mvn clean package -Ptest