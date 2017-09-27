* Apple的2D渲染引擎。

## 创建、配置自定义View，base Layer

1. 创建一个NSView子类
2. 重写draw()方法，绘制

	> Graphics Contexts:系统在ctx上直接绘制图形，然后再展示在View上
	>
	> * 绘制：CGPathRef绘制矢量图形路径；将Path添加至ctx；ctx设置渲染属性，根据Path渲染图形。

---

2. live渲染View:在XIB中直观修改定制View的属性，而无需编译运行

	> * @IBDesignable:在class声明之前添加
	> * @IBInspectable:在属性之前添加。在XIB中直观修改属性。
	> * override func prepareForInterfaceBuilder():重载，并初始配置。
3. 以Paths绘制，填充剪切子串区域
4. 应用Cocoa Drawing

