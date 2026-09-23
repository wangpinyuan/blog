---
title: parseInt和Number
labels: JavaScript
---

```     
console.log(parseInt("0123")); // 123
console.log(Number("0123")); // 123

console.log(parseInt("1%")); // 1
console.log(Number("1%")); // NaN

console.log(parseInt(null)); // NaN
console.log(Number(null)); // 0

console.log(parseInt(undefined));// NaN
console.log(Number(undefined));// NaN

console.log(parseInt(""));// NaN
console.log(Number(""));// 0

console.log(parseInt(true));// NaN
console.log(Number(true));// 1

console.log(parseInt(false));// NaN
console.log(Number(false));// 0

console.log(parseInt());// NaN
console.log(Number());// 0
```
