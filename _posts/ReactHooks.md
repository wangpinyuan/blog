---
title: 浏览器组成部分及运行原理
labels: 工具类
---

## 一、Hook
- useState
- this.setState的替代
```
const [count, setCount] = useState(0);
```
- useEffect
- this.componentDidMount, this.componentDidUpdate, this.componentWillUnmount的替代
```
useEffect(() => {
  console.log('count');
});
在第一次渲染和每次更新后执行

useEffect(() => {
  console.log('count');
}, []);
在第一次渲染

useEffect(() => {
  console.log('count');
}, [count]);
在第一次渲染和count更新后执行
```
- useContext 
- 普通父子传值用 props，但如果要跨多层组件（爷→孙→曾孙）一层层传 props 会非常麻烦（prop drilling 问题）。
- useContext 让你在任意层级的组件里直接拿到全局数据，不用层层传递。
```
第 1 步：创建 Context
// ThemeContext.js
import { createContext } from 'react'
const ThemeContext = createContext('light')
export default ThemeContext

第 2 步：用 Provider 包裹组件，提供数据
// App.jsx
import ThemeContext from './ThemeContext'
function App() {
  const [theme, setTheme] = useState('dark')
  return (
    // value 就是要共享的数据，可以是任意类型
    <ThemeContext.Provider value={theme}>
      <Header />
      <Main />
      <Footer />
    </ThemeContext.Provider>
  )
}

第 3 步：在子孙组件中用 useContext 读取
// 任意深层子组件
import { useContext } from 'react'
import ThemeContext from './ThemeContext'
function Button() {
  const theme = useContext(ThemeContext) // 直接拿到值

  return <button className={theme}>按钮</button>
}
```
- useRef
- 获取 DOM 节点
```
import { useRef } from 'react'

function InputFocus() {
  const inputRef = useRef(null)

  const handleClick = () => {
    // 通过 .current 访问真实 DOM 节点
    inputRef.current.focus()
    inputRef.current.value = '自动填充'
  }

  return (
    <div>
      <input ref={inputRef} type="text" />
      <button onClick={handleClick}>聚焦输入框</button>
    </div>
  )
}
```
- useCallback
- 缓存函数，避免重复计算
```
const handleClick = useCallback(() => {
  console.log('点击了')
}, [])
```
- useMemo
- 缓存计算结果，避免重复计算
- 搭配 useCallback 使用
```
const result = useMemo(() => {
  return count * 2
}, [count])
```