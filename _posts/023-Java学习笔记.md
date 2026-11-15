## Java核心技术卷1

### 分类 Java

## 第三章 Java基本程序设计结构
### 数据类型（4种整型，2种浮点型，1种字符串，1种Boolean
整型：int、short、long、bit
浮点型：float、double
char：单个字符
boolean：布尔值，只有true和false两个值

### 变量与常量
变量
- 数字、字母、下划线、美元符号
- 不能以数字开头，不能使用保留字，不能使用特殊字符
final定义常量
- 常量的值不能改变
- 常量的值必须是编译时确定的
- 常量的值可以是字面值、也可以是表达式

### 枚举类型
- 定义了固定数量的常量
- 每个枚举值都是一个唯一的常量
- 可以使用enum关键字定义枚举类型
- 枚举类型的常量必须在定义时指定，不能在运行时指定

### 类型转换
- 自动类型转换：将较小的类型转换为较大的类型
- 显式类型转换：将较大的类型转换为较小的类型
- 显式类型转换：使用强制类型转换运算符（）将较大的类型转换为较小的类型

### 字符串
stringbuilder：用于构建字符串的类
- 可以使用append方法将字符串追加到字符串构建器中
- 可以使用insert方法将字符串转换为字符串构建器
- 可以使用toString方法将字符串构建器转换为字符串
- 可以使用delete方法删除字符串构建器中的字符

### 输入与输出
- 可以使用Scanner类从键盘读取数据
- Scanner nextLine()/next()/nextInt()/nextDouble()等方法读取键盘输入
- 可以使用System类的out对象将数据显示到屏幕上
- 可以使用printf方法格式化输出数据

### 数组
- 数组是一种数据类型，用于存储多个相同类型的变量
int[] array = new int[5]; // 定义一个5个元素的整型数组
int[] array = {1, 2, 3, 4, 5}; // 定义一个5个元素的整型数组，初始化为1、2、3、4、5
- 数组的元素可以使用索引来访问
for(int element : array){
    System.out.println(element);
}
Arrays.sort(array);
Arrays.copyOf(array, 3); // 复制数组的前3个元素到新数组中
Arrays.toString(array);
Arrays.equals(array, array2); // 比较数组是否相等
Arrays.fill(array, 100); // 将数组中所有元素都设置为100
Arrays.binarySearch(array, 3); // 返回3的索引，如果3不在数组中，则返回负数的补码

## 第四章 对象和类
### 静态static
- 静态字段是指在类中定义的字段，所有对象共享同一个值
- 静态方法是指在类中定义的方法，所有对象共享同一个实现，不能使用this关键字，只能使用类名调用，
- 静态方法可以访问静态字段，不能访问非静态字段
- 静态方法可以使用this关键字，但是不能使用super关键字
- 静态方法可以使用final关键字，但是不能使用static关键字
- 静态方法可以使用void关键字，但是不能使用return关键字

### 重载
- 重载是指在同一个类中，定义了多个方法，每个方法的名称相同，但是参数列表不同
- 可以使用不同的参数列表来调用不同的方法

## 第五章 继承
- super关键字：用于调用父类的构造方法或方法
- 多态是指在运行时，根据对象的实际类型来调用方法，而不是根据对象的声明类型来调用方法
- final修饰的方法不能被重写
- 抽象类是指在类中定义了抽象方法，但是没有实现抽象方法的类/抽象类不能被实例化

- ArrayList类：用于存储可变数量的元素，每个元素可以是任意类型的对象
- ArrayList类的元素可以使用索引来访问
- ArrayList类的元素可以使用add方法添加到列表中
- ArrayList类的元素可以使用remove方法从列表中删除
- ArrayList类的元素可以使用clear方法清空列表

- ### 重写
- 重写是指在子类中，定义了与父类中方法名称相同，但是参数列表不同的方法
- 子类可以使用super关键字调用父类的方法
- 子类可以使用this关键字调用当前对象的方法

### 抽象类和抽象方法
- 抽象类是指在类中定义了抽象方法，但是没有实现抽象方法的类/抽象类不能被实例化
- 子类必须实现抽象类中定义的抽象方法

### 接口
- 子类必须实现接口中定义的方法
- 默认方法，default 可以在接口中定义默认实现的方法，子类可以不实现
- 常量字段，如果子类也定义了相同的常量字段，当用接口调用时，会调用接口中的常量字段；用子类实例化时，会调用子类中的常量字段
- 静态方法，如果子类也定义了相同的静态方法，当用接口调用时，会调用接口中的静态方法；用子类实例化时，会调用子类中的静态方法

## 内部类
- 成员内部类
- 静态内部类
- 本地内部类
- 匿名内部类      

## 第六章 常用工具类
### 异常处理
- try-catch-finally语句
- throws关键字
  
## 第七章 包装类
- Integer
  - 转字符串：toString()
  - 字符串转整数：parseInt()
- String
- StringBuilder
- 集合

## 第八章 Java Web基础
XML
J2EE
Tomcat
Servlet
cookie
session
servertContext
xml配置文件，默认首页/全局变量/404/500页面
web应用war包发布，tomcat默认路径修改

## 第九章 Java 数据库开发
JDBC
- 加载驱动 Class.forName
- 创建链接 DriverManager
- 创建statement
- 执行sql语句
- 关闭连接，释放资源

Druid数据库连接池
c3p0数据库连接池
Common DBUtils工具类

## 第十章 Maven
maven
lambda表达式
stream流
- 创建流
  - Arrays.stream()
  - List.stream() // 基于集合创建流
  - Set.stream()
  - Stream.of()    // 基于数组创建流
  - Stream.generate() // 基于生成器创建流
  - Stream.iterate()  // 基于迭代器创建流
- 操作流
  - filter()
  - map()
  - flatMap()
  - sorted()
  - distinct()
  - collect()

## 第十一章 MyBatis
简化JDBC与数据库交互
mybatis-config.xml放置配置信息
SqlsessionFactory
MybatisUtils工具类
查询
- 创建实体类
- Mapper XML
- SQL语句
- 驼峰命名映射
- 新增mapper
- sqlSession执行SQL
mybatis日志
mybatis动态SQL
mybatis二级缓存
pagehelper分页插件
注解开发

## 第十二章 Spring
### 1. IoC
1.XML配置注入
- 基于构造方法实例化
- 基于静态工厂
- 基于工厂实例方法
bean scope
2.组件类型注解
3.java-config.xml
### 2.AOP
joinpoint方法：
getTarget()
getSignature()
getArgs()

### 3.spring JDBC
jdbc template
- 配置
- 查询
  - jdbcTemplate.query();
  - jdbcTemplate.queryForObject();
  - jdbcTemplate.queryForList();
  - jdbcTemplate.queryForMap(); 
  - jdbcTemplate.queryForBean();
- 更新 
  - jdbcTemplate.update();

编程式事物
jdbcTemplate通过 transactionManager实现事物提交/回滚

声明式事物
- 配置 transactionManager
- 注解 @Transactional
