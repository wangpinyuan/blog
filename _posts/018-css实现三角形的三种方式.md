---
title: css实现三角形的三种方式
labels: CSS
---

## 1 border实现
<img width="1240" alt="image" src="https://github.com/wangpinyuan/blog/assets/20550379/b553f06f-a195-4578-8f43-ab8137615deb">

## 2 background: linear-gradient
属性简介
```
/* 渐变轴为45度，从蓝色渐变到红色 */
linear-gradient(45deg, blue, red);

/* 从右下到左上、从蓝色渐变到红色 */
linear-gradient(to left top, blue, red);

/* 从下到上，从蓝色开始渐变、到高度 40% 位置是绿色渐变开始、最后以红色结束 */
linear-gradient(0deg, blue, green 40%, red);`
```
<img width="1414" alt="image" src="https://github.com/wangpinyuan/blog/assets/20550379/3716beef-b5fe-4d32-bd80-997d9e2d778c">
<img width="1434" alt="image" src="https://github.com/wangpinyuan/blog/assets/20550379/4545e4f8-c94c-4156-bfa8-f17f57b802d3">

## 3 clip-path
属性详情：https://developer.mozilla.org/zh-CN/docs/Web/CSS/clip-path
<img width="1422" alt="image" src="https://github.com/wangpinyuan/blog/assets/20550379/0af0fbc2-db51-4441-9574-46d048449f1e">


