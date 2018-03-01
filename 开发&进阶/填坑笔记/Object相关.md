# Object相关

## 目录

* [leak宏](#leak宏)

## <span id = "leak宏"> leak宏 </span>

```
#define MJPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
```