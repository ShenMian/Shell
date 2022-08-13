# Shell

A simple shell framework.  

## Modules

| Module | Description         |
| ------ | ------------------- |
| io     | 彩色输出.            |
| oo     | 基于类的面向对象.    |
| system | 获取各类系统相关信息. |
| timer  | 计时器.             |
| color  | 定义多种颜色.        |

## Usage

```sh
source "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/path/to/import.sh"
import io system
```

## 面向对象

```sh
# 声明类
class Timer
  pub
    fn Timer  # 构造函数(可选)
    fn -Timer # 析构函数(可选)
    fn start
    fn getSeconds
    # ... 公有函数 ...
  pri
    # ... 私有函数 ...
  var start_time
  # ... 私有变量 ...

# 定义成员函数
function Timer::start {
  # 在成员函数中可以直接通过名称访问成员变量和成员函数
  start_time="$(date +%s.%2N)"
}

new Timer timer                     # 创建实例
timer.start                         # 调用成员函数
echo "Time: $(timer.getSeconds)sec" # 获取成员函数返回值
delete timer                        # 销毁实例
```
