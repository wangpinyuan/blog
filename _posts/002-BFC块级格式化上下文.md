---
title: BFC块级格式化上下文
labels: CSS
---

## 1 什么是BFC
BFC，Block fomatting context，块级格式化上下文。

Formatting context 是 W3C CSS2.1 规范中的一个概念。它是页面中的一块渲染区域，并且有一套渲染规则，它决定了其子元素将如何定位，以及和其他元素的关系和相互作用。最常见的 Formatting context 有 Block fomatting context (简称BFC)和 Inline formatting context (简称IFC)。

参与block formattinh context的元素有：
display 属性为 block, list-item, table 的元素

参与Inline formatting context的元素有：
display 属性为 inline, inline-block, inline-table 的元素

BFC的特点为：
1. 在形成盒模型中，内部元素的行为不会影响盒外部元素。
2. 计算盒模型高度时，浮动元素也参与计算。（也就是解决float导致的高度塌陷问题
3. BFC区域不会与Float Box重叠。（也就是可以用来实现自适应布局
4. 在BFC盒模型中，垂直margin会折叠，相邻margin会叠加

## 2 如何实现BFC
1. 浮动元素。比如 float：left
2. 绝对定位。比如 position:absolute/fixed
3. overflow除了visible之外的值。比如 overflow: hidden/auto
6. display为以下其中之一的值inline-blocks，table，table-cell，table-caption。（不怎么用

## 3 实现BFC的目的
1. 配合float box实现自适应布局
```
<div class="container">
      <div class="left"></div>
      <div class="content"></div>
</div>

.container {
  height: 500px;
}
.left {
  height: 200px;
  width: 200px;
  float: left;
  background-color: aqua;
}
.content {
  height: 100%;
  background-color: bisque;
}
```
<img width="375" alt="image" src="https://github.com/wangpinyuan/blog/assets/20550379/b56d696c-11c8-4427-999c-dd859a8d8fb0">

此时，左侧元素float，右侧元素围绕其包裹。
```
overflow: hidden;
float: left;
```
给右侧元素增加以上属性，即可消除包裹效果。
<img width="551" alt="image" src="https://github.com/wangpinyuan/blog/assets/20550379/884b61a7-d4f7-4325-b2fa-2b7ae05fc593">

2. 解决float导致的父元素高度塌陷
<img width="371" alt="image" src="https://github.com/wangpinyuan/blog/assets/20550379/ba5716b3-dd26-49c2-a4d6-4e03422a218f">
<img width="576" alt="image" src="https://github.com/wangpinyuan/blog/assets/20550379/d80fcc81-3434-40ab-a530-71c4ce90b700">

上图中两个子元素float: left；父元素在计算高度时，不会计算子元素高度，于是塌陷。
处理方法如上：

<img width="1427" alt="image" src="https://github.com/wangpinyuan/blog/assets/20550379/0fc4f544-8d16-449e-b5d3-d00c70250022">



