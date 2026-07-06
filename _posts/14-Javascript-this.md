---
title: Javascript this
labels: JavaScript
---


# this
- ## demo
```
var people = {
    Name: "a",
    getName : function(){
        console.log(this.Name);
    }
};
var bar = people.getName;

bar();
```
```
var people = {
    Name: "a",
    getName : function(){
        console.log(this.Name);
    }
};
people.getName();
```

- ## 1 默认绑定
```
var name = 'b';
var a = {
    name: 'a',
    getName: function() {
        console.log(this.name);
    }
}
var obj = a.getName;
obj(); // ?

```
- ## 2 隐性绑定
```
var name = 'b';
var a = {
    name: 'a',
    getName: function() {
        console.log(this.name);
    }
}
var obj = a.getName();
obj; // ?

```
- ## 3 强制绑定
- ### call apply bind 区别
- call从第二个参数开始所有的参数都是 原函数的参数。
- apply只接受两个参数，且第二个参数必须是数组，这个数组代表原函数的参数列表。
- bind只有一个函数，且不会立刻执行，只是将一个值绑定到函数的this上,并将绑定好的函数返回。
```
var name = 'b';
var a = {
    name: 'a',
    getName: function() {
        console.log(this.name);
    }
}
a.getName.call(this);
```
```
var name = 'b';
var a = {
    name: 'a',
    getName: function() {
        console.log(this.name);
    }
}
var func = a.getName.bind(this);
func();
```
- ## 4 New绑定
- ### 创建一个新对象。
- ### 把这个新对象的__proto__属性指向原函数的prototype属性。(即继承原函数的原型)
- ### 将这个新对象绑定到 此函数的this上 。
- ### 如果这个函数没有返回其他对象，返回新对象。

```
var name = 'b';
function func() {
    this.name = 'a';
    console.log(this.name);
}
var obj = new func();
obj; // ?
```
- ## 5 箭头函数
- ### 在定义时绑定this
- ### this无法修改
```
var name = 'b';
var people = {
    name: "a",
    getName : function() {
        return () => {
            console.log(this.name);
        }
    }
};
var bar = people.getName();

bar();
```

- ## demo
```
function foo(arg){
    this.a = arg;
    return this
};

var a = foo(1);
var b = foo(2);

console.log(a.a);    // ?
console.log(b.a);    // ?
```
```
var x = 1;
var obj = {
    x: 2,
    f: function(){ console.log(this.x); }
};
var bar = obj.f;
var obj2 = {
    x: 3,
    f: obj.f
}
obj.f();
bar();
obj2.f();
```
```
function obj() {
    getName = function () { console.log (1); };
    return this;
}
obj.getName = function () { console.log(2);};
obj.prototype.getName = function () { console.log(3);};
var getName = function () { console.log(4);};
function getName () { console.log(5);}
 
obj.getName ();                // ?
getName ();                    // ?
obj().getName ();              // ?
getName ();                    // ?
new obj.getName ();            // ?
new obj().getName ();          // ?
new new obj().getName ();      // ?
```
