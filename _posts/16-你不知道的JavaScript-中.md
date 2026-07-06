---
title: 你不知道的JavaScript（中）
labels: JavaScript
---

# 1 类型
## 1.1 js有七种内置类型
1 undefined 2 boolean 3 number 4 string 5 object 6 null 7 symbol

- typeof undefined === "undefined"
- typeof true === "boolean"; // true
- typeof 42 === "number"; // true
- typeof "42" === "string"; // true
- typeof { life: 42 } === "object"; // true
- typeof Symbol() === "symbol"; // true

但是null稍微特殊
typeof null === "object"; // true
所以如果检测一个值是否为null，需要
var a = null;
(!a && typeof a === "object"); // true

## 1.2 JavaScript 中的变量是没有类型的，只有值才有。变量可以随时持有任何类型的值
换个角度来理解就是，JavaScript 不做”类型强制“。
在对变量执行 typeof 操作时，得到的结果并不是该变量的类型，而是该变量持有的值的类
型，因为 JavaScript 中的变量没有类型。

##1.3 undefined && undeclared
undefined 是值的一种。undeclared 则表示变量还没有被声明过。
遗憾的是，JavaScript 却将它们混为一谈，在我们试图访问 "undeclared" 变量时这样报
错：ReferenceError: a is not defined，并且 typeof 对 undefined 和 undeclared 变量都返回
"undefined"。
```
typeof undefined == "undefined"
typeof undeclared == "undefined"
```

# 2 值
简单值（即标量基本类型值，scalar primitive）总是通过值复制的方式来赋值 / 传递，包括
null、undefined、字符串、数字、布尔和 ES6 中的 symbol。
复合值（compound value）——对象（包括数组和封装对象，参见第 3 章）和函数，则总 是通过引用复制的方式来赋值 / 传递。
```
var a = 2;
var b = a; // b是a的值的一个副本
b++;
a; // 2
b; // 3
var c = [1,2,3];
var d = c; // d是[1,2,3]的一个引用
d.push( 4 );
c; // [1,2,3,4]
d; // [1,2,3,4]
```
在上述代码中，a，b分别指向 值 的两个复本。a，b的改变互不影响。
c，d分别指向 值 的两个引用，而引用都指向同样的一个对象 [1,2,3]，所以c，d的改变是对于所指对象的改变。
```
function foo(x) {
 x.push( 4 );
 x; // [1,2,3,4]
 // 然后
 x = [4,5,6];
 x.push( 7 );
 x; // [4,5,6,7]
}
var a = [1,2,3];
foo( a );
a; // 是[1,2,3,4]，不是[4,5,6,7]
```
其中，a将 [1,2,3]的引用的复本，传给了变量x。变量x 指向 对象[1,2,3]的引用的复本，可以修改其值。
随后，变量x指向 更改为[4,5,6]的引用，这一操作并不会影响a的引用。

# 3 原生函数
- String()
- Number()
- Boolean()
- Array()
- Object()
- Function()
- RegExp()
- Date()
- Error()
- Symbol()——ES6 中新加入的！

## 3.1
new String("abc") 创建的是字符串 "abc" 的封装对象，而非基本类型值 "abc"。
```
var a = new String( "abc" );
typeof a; // 是"object"，不是"String"
a instanceof String; // true
Object.prototype.toString.call( a ); // "[object String]"
```

## 3.2 内部属性 [[Class]]
这个属性无法直接访问，
一般通过 Object.prototype.toString(..) 来查看。例如：
```
Object.prototype.toString.call( [1,2,3] ); // "[object Array]"
Object.prototype.toString.call( /regex-literal/i ); // "[object RegExp]"
```

# 4 强制类型转换
## 4.1 值类型转换
将值从一种类型转换为另一种类型通常称为类型转换（type casting），这是显式的情况；隐式的情况称为强制类型转换（coercion）。
也可以这样来区分：类型转换发生在静态类型语言的编译阶段，而强制类型转换则发生在动态类型语言的运行时（runtime）。
然而在 JavaScript 中通常将它们统称为强制类型转换，我个人则倾向于用“隐式强制类型
转换”（implicit coercion）和“显式强制类型转换”（explicit coercion）来区分。
```
例如：
var a = 42;
var b = a + ""; // 隐式强制类型转换
var c = String( a ); // 显式强制类型转换
```
## 4.2 抽象值操作
1. toString
2. toNumber
其中 true 转换为 1，false 转换为 0。undefined 转换为 NaN，null 转换为 0。
对象（包括数组）会首先被转换为相应的基本类型值，如果返回的是非数字的基本类型值，则再遵循以上规则将其强制转换为数字。
为了将值转换为相应的基本类型值，抽象操作 ToPrimitive会首先检查该值是否有 valueOf() 方法。
如果有并且返回基本类型值，就使用该值进行强制类型转换。如果没有就使用 toString()的返回值（如果存在）来进行强制类型转换。
如果 valueOf() 和 toString() 均不返回基本类型值，会产生 TypeError 错误。
3. toBoolean
以下为假值：
• undefined
• null
• false
• +0、-0 和 NaN
• ""

## 4.3 显式强制类型转换
1. 字符串和数字之间的显式转换
    1. 运算符的一元形式
    ```
    var a = "123"
    var b = +a // 123  被转换为number
    ```  
    2.奇特的 ~ 运算符
    ```
    var a = "Hello World";
    a.indexOf('H') // 0
    ~a.indexOf('H') // -1
    Boolean(~indexOf('H')) // true
    如果存在值，则indexOf为0或其余正数，那么～为负数，Boolean转换为true

    a.indexOf('123') // -1
    ~a.indexOf('H') // 0
    Boolean(~indexOf('H')) // false
    如果不存在值，则indexOf为-1，那么～为0，Boolean转换为false
    ```
    3. ~~字位截除
    ```
    var a = 3.14
    ~a // -4
    ~~ a // 3

    Math.floor( -49.6 ); // -50
    ~~-49.6; // -49
    ```
2. 显式转换为布尔值
显式强制类型转换为布尔值最常用的方法是 !! 而不是 Boolean

## 4.4 隐式强制类型转换
1. 字符串和数字之间的隐式强制类型转换
```
var a = "42";
var b = "0";
var c = 42;
var d = 0;
a + b; // "420"
c + d; // 42

var a = [1,2];
var b = [3,4];
a + b; // 1,23,4

如果参与运算的对象是字符串，或者可以转换成字符串，则+进行字符串拼接操作。否则执行数字加法。
因此：a+b=“420”
当运算对象为对象时，调用ToPrimitive，调用valueOf 或者 toString，获取[[DefaultValue]]。
因此，数组[1,2]被转换为“1，2”“3，4”再进行字符串拼接。

var a = "3.14";
var b = a - 0;
b; // 3.14

- 是数字减法运算符，因此 a - 0 会将 a 强制类型转换为数字。
也可以使用 a * 1 和 a / 1，因为这两个运算符也只适用于数字，只不过这样的用法不太常见。
对象的 - 操作与 + 类似：
var a = [3];
var b = [1];
a - b; // 2
```
2. 隐式强制类型转换为布尔值
(1) if (..) 语句中的条件判断表达式。
(2) for ( .. ; .. ; .. ) 语句中的条件判断表达式（第二个）。
(3) while (..) 和 do..while(..) 循环中的条件判断表达式。
(4) ? : 中的条件判断表达式。
(5) 逻辑运算符 ||（逻辑或）和 &&（逻辑与）左边的操作数（作为条件判断表达式）。

## 4.5 || &&
|| 和 && 首先会对第一个操作数执行条件判断，如果其不是布尔值就先进行 ToBoolean 强制类型转换，然后再执行条件判断。
对于 || 来说，如果条件判断结果为 true 就返回第一个操作数的值，如果为
false 就返回第二个操作数的值。

&& 则相反，如果条件判断结果为 true 就返回第二个操作数的值，如果为 false 就返回第一个操作数的值。
可以用a && foo() 代替 if(a) { foo() }，简洁
```
var a = 42;
var b = null;
var c = "foo";
if (a && (b || c)) {
 console.log( "yep" );
}
在上述 if 中
1 b||c // “foo”
2 a && (b||c) // "foo"
3 if 隐式类型转换，将"foo"转为true
```

## 4.6 宽松相等和严格相等
== 允许在相等比较中进行强制类型转换，而 === 不允许。
== 和 === 都会检查操作数的类型。区别在于操作数类型不同时它们的处理方
式不同。

1. 数字和字符串比较 字符串ToNumber
```
x = '42'
y = 1
x== y
首先将 ‘42’ 转为 42，转为number，再比较
返回false
```
2. 布尔和其他类型比较 布尔值ToNumber
```
x = true
y = '42'
x == y
首先，true 转为 1，这样就是 1 == ‘42’
其次，‘42’ 转为 42，再比较
返回false
```
3. 对象和非对象之间的相等比较
(1) 如果 Type(x) 是字符串或数字，Type(y) 是对象，则返回 x == ToPrimitive(y) 的结果；
(2) 如果 Type(x) 是对象，Type(y) 是字符串或数字，则返回 ToPromitive(x) == y 的结果。
4. 对象和对象的比较
比较对象所指向的值，是否相等
5. <=
```
在js中，a <= b
被转换为 !(a>b)
```
