1. https://github.com/lyeah/EventBus/tree/master/EventBus
2. https://github.com/AKACoder/ABCEventBus
3. https://github.com/benjamincombes/EventBus
4. https://github.com/kouky/EventBus
5. https://github.com/ShezHsky/EventBus
7. https://github.com/chausson/XEBEventBus
8. https://github.com/favret/Magic-Swift-Bus
9. https://github.com/l9y/SwiftEvent
11. https://github.com/cesarferreira/SwiftEventBus
1. https://github.com/aixinyunchou/OCEventBus
2. https://github.com/goodow/GDChannel


---

1. GCD: https://github.com/ming1016/study/wiki/%E7%BB%86%E8%AF%B4GCD%EF%BC%88Grand-Central-Dispatch%EF%BC%89%E5%A6%82%E4%BD%95%E7%94%A8
1. 线程安全问题：https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Multithreading/ThreadSafetySummary/ThreadSafetySummary.html
2. http://www.cocoachina.com/ios/20160225/15422.html



## 消息组件EventBus

#### 属性：
1. eventbus单例模式
2. 定制队列。
3. 监听对象：协议、名称
2. 缓存：


#### 方法：

###### Publish发布：
1. post：名称、发送对象，userInfo等
2. 主线程post
3. 均调用系统级别方案：NotificationCenter

###### Subscribe订阅：

1. on：target、name、sender、queue。block回调
2. 主线程on方案


###### 取消监听

1. unregister：target




----
1. 延时执行事件
2. 条件读取事件
3. 事件执行的优先级:三个优先队列有优先顺序，但每个队列中随机。
4. subscriber和publish都有线程设置的时候，后者优先级比较大。
5. 订阅对象释放后，在某个时间点，maptable中对应key的条目也会释放。但无法实时感知maptable中释放元素的时间。




----
## IMXEventBus

以订阅/发布的模式实现跨组件通信，也即通信模块。

#### 功能：

1. 通信功能：类似于NSNotification功能。
2. 生命周期管理：注册的订阅者可自动释放，也可手动管理其释放时机。
3. 订阅者优先级处理：发布事件时，通过优先级执行订阅者的行为。
4. 订阅者主线程/非主线程控制、异步执行。
5. 过滤去重功能、延时触发、条件触发（todo：）




#### 文件构成：
1. IMXEventBus：核心文件，实现订阅、发布、取消订阅等功能方法。
2. IMXEvent：订阅者集合及行为
3. IMXEventSubscriber：订阅者Model
4. userInfo：传输数据Model

#### 问题：

1. 资源Events锁的问题：添加之后同一时间只能处理一个订阅、发布、取消订阅等事件。(使用单一异步串行队列执行作为替代方案)
2. 订阅者分发中心NSMapTable：Target释放后，释放对应条目。但无法实时监听到，故每次发布事件时均需巡检一次。


---

5. 订阅者行为异步执行：异步执行的并行队列嵌套在串行队列中串行执行，并以信号量控制多线程个数。
6. 子类化对象中与父类存在有同名事件处理问题。



* 同一线程下，优先级起作用。
* 当post发送出去，但无对应sub响应的处理。
* 取消发送事件
* 只发送优先级高的。（例）
----


* ThreadMode：post执行模式：main，backgroud等。
* Subscription：针对subscriber的封装
* SubscriberFinder：
* subscriberMethod：生成sbus方法
* Subscriber：订阅Model
* Poster：model
* PendingPostQueue：队列
* PendingPost：追加的postModel
* NoSubscriberEvent：当post发送出去，但无对应sub响应的处理Model
* MainThreadSupport：是否主线程处理。
* Log工具
* HandlerPoster：poster子类
* EventBusBuilder：构建EventBus配置等信息
* EventBus：post，subscriber注册等
* 