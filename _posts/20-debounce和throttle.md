---
title: debounce和throttle
labels: JavaScript
---

## 1 防抖
防抖适合的应用场景，比如搜索联想，电话号码验证等。只有在最后一次事件响应，再去请求资源。
```
function debounce(func, delay, immediately) {
  let timer = 0;
  return () => {
    const _this = this;
    const args = arguments;
    if (!timer && immediately) {
      func.apply(_this,args);
      return;
    }
    if (timer) {
      clearTimeout(timer);
    }
    timer = setTimeout(() => {
      func.apply(_this,args);
    }, delay);
  };
}
```
## 2 节流
节流适合的场景，比如滚动监听，自动保存等。在多次密集的事件触发中，平均分配资源请求。
```

function throttle(func, delay) {
  let timer = 0;
  return () => {
    const _this = this;
    const args = arguments;
    if (!timer) {
      timer = setTimeout(() => {
        func.apply(_this, args);
        timer = 0;
      }, delay);
    }
  };
}
```

