# macOS 命令行编程

链接：https://www.raywenderlich.com/163134/command-line-programs-macos-tutorial-2

1. CLI：命令行
2. Xcode使用的CL，即xcodebuild运行程序。


## 启动
1. File/New/Project 选择 macOS
2. Application/Command Line Tool
3. 执行入口即为main.swift文件

## 输出流

1. 标准输出流stdout：提供信息输出

	> print("\(message)")
2. 标准错误流stderr：提供状态和错误信息、重定向文件

	> fputs("Error:\(message)\n", stderr) 

## 内容

1. 创建新文件：macOS->Source->Swift File

## 参数

1. 参数分可选和字符串

	> 可选：如-h、--help

