# linkedin规范

原文链接：[linkedin规范](https://github.com/linkedin/swift-style-guide)

确保已阅读：[Apple's API Design Guidelines.](Apple's API Design Guidelines.)

该指南针对于Swift3.0、更新于2017-09-26

## 1. 代码格式

###### 1.1 针对tabs 使用4个空格。
###### 1.2 强制约定每行最多字符数为160，避免一行过长。（Xcode->Preferences->Text Editing->Page guide at column: 160）
###### 1.3 确保每个文件的结尾处有一空行。
###### 1.4 确保在任何地方都无额外多余的空格出现。（Xcode->Preferences->Text Editing->Automatically trim trailing whitespace + Including whitespace-only lines）
###### 1.5 不要在新的一行放置花括号，我们使用[1TBS style](https://en.m.wikipedia.org/wiki/Indentation_style#1TBS)。

```
class SomeClass {
    func someMethod() {
        if x == y {
            /* ... */
        } else if x == z {
            /* ... */
        } else {
            /* ... */
        }
    }

    /* ... */
}

```
###### 1.6 针对属性、常量、变量、字典的key、protocol、父类等进行类型书写时，不要在冒号前添加空格。在其后添加空格。
```
// 类型定义
let pirateViewController: PirateViewController

// dictionary syntax (注意是左对齐而非冒号对齐)
let ninjaDictionary: [String: AnyObject] = [
    "fightLikeDairyFarmer": false,
    "disgusting": true
]

// 函数声明
func myFunction<T, U: SomeProtocol>(firstArgument: U, secondArgument: T) where T.RelatedType == U {
    /* ... */
}
// calling a function
someFunction(someArgument: "Kitten")

// superclasses
class PirateViewController: UIViewController {
    /* ... */
}

// protocols
extension PirateViewController: UITableViewDataSource {
    /* ... */
}
```
###### 1.7 一般而言，逗号后面应该有空格。
```
let myArray = [1, 2, 3, 4, 5]
```
###### 1.8 二元运算符前后应均有一个空格。如`+`、`==`、`->`。
###### 1.9 在`(`之后和`)`之前不应有空格。
```
let myValue = 20 + (30 / 2) * 3
if 1 + 1 == 3 {
    fatalError("The universe is broken.")
}
func pancake(with syrup: Syrup) -> Pancake {
    /* ... */
}
```

###### 1.10 遵循Xcode推荐的缩进风格。（即当按下CTRL-I时，你的代码无变化）
> 当声明一个跨越多行的函数时，倾向于使用Xcode（从7.3版本开始）默认的语法。

```
// Xcode indentation for a function declaration that spans multiple lines
func myFunctionWithManyParameters(parameterOne: String,
                                  parameterTwo: String,
                                  parameterThree: String) {
    // Xcode indents to here for this kind of statement
    print("\(parameterOne) \(parameterTwo) \(parameterThree)")
}

// Xcode indentation for a multi-line `if` statement
if myFirstValue > (mySecondValue + myThirdValue)
    && myFourthValue == .someEnumValue {

    // Xcode indents to here for this kind of statement
    print("Hello, World!")
}
```

###### 1.11 调用具有许多参数的函数时，将每个参数置于单独的行中，并使用一个额外的缩进。

```
someFunctionWithManyArguments(
    firstArgument: "Hello, I am a string",
    secondArgument: resultFromSomeFunction(),
    thirdArgument: someOtherLocalProperty)
```
###### 1.12 当处理一个足够大的隐式数组或字典，并保证将其分解成多行时，将`[`和`]`视为方法中的大括号`{`来处理。if语句、方法中的闭包等，类似处理。

```
someFunctionWithABunchOfArguments(
    someStringArgument: "hello I am a string",
    someArrayArgument: [
        "dadada daaaa daaaa dadada daaaa daaaa dadada daaaa daaaa",
        "string one is crazy - what is it thinking?"
    ],
    someDictionaryArgument: [
        "dictionary key 1": "some value 1, but also some more text here",
        "dictionary key 2": "some value 2"
    ],
    someClosure: { parameter1 in
        print(parameter1)
    })
```

###### 1.13 优先使用本地常量或其他缓解技术，以尽可能避免多行谓词出现。

```
// PREFERRED
let firstCondition = x == firstReallyReallyLongPredicateFunction()
let secondCondition = y == secondReallyReallyLongPredicateFunction()
let thirdCondition = z == thirdReallyReallyLongPredicateFunction()
if firstCondition && secondCondition && thirdCondition {
    // do something
}

// 不推荐
if x == firstReallyReallyLongPredicateFunction()
    && y == secondReallyReallyLongPredicateFunction()
    && z == thirdReallyReallyLongPredicateFunction() {
    // do something
}
```

## 2. 命名

###### 2.1 在Swift中不需要Objective-C风格的前缀。（如命名`GuybrushThreepwood `而非`LIGuybrushThreepwood `）

###### 2.2 使用`PascalCase`拼写法，来命名类型名称。（如 struct、enum、class、typedef、associatedtype等）
> 帕斯卡拼写法:一种计算机编程中的变量命名方法。它主要的特点是将描述变量作用所有单词的首字母大写，然后直接连接起来，单词之间没有连接符。

###### 2.3 使用camelCase（初始小写字母）拼写法，命名`函数，方法，属性，常量，变量，参数名称，枚举类型`等。

###### 2.4 处理缩略词或首字母纯大写的缩略词时，均原样使用该缩略词即可。 但有个例外：若该词是在一个名字的开始，需要以小写字母开头 - 在这种情况下，使用全部小写的缩写词。

```
// "HTML" is at the start of a constant name, so we use lowercase "html"
let htmlBodyContent: String = "<p>Hello, World!</p>"
// Prefer using ID to Id
let profileID: Int = 1
// Prefer URLFinder to UrlFinder
class URLFinder {
    /* ... */
}

```

###### 2.5 所有常量都应该是静态的，独立的。单例除外。所有这些静态常量应按照规则3.1.16放在容器枚举类型中。
> 1. 该枚举类型容器的命名应是单数。（如`Constant`而非`Constants`）
> 2. 命名易解读，即通过命名很容易理解它是常量枚举。若不明显，可添加`Constant`后缀。
> 3. 应使用这些容器对具有相似或相同的前缀，后缀和/或用例的常量进行分组。

```
class MyClassName {
    // PREFERRED
    enum AccessibilityIdentifier {
        static let pirateButton = "pirate_button"
    }
    enum SillyMathConstant {
        static let indianaPi = 3
    }
    static let shared = MyClassName()

    // 不推荐
    static let kPirateButtonAccessibilityIdentifier = "pirate_button"
    enum SillyMath {
        static let indianaPi = 3
    }
    enum Singleton {
        static let shared = MyClassName()
    }
}
```

###### 2.6 对于泛型（generics）和关联（associated）类型，使用`PascalCase`描述泛型。
> 1. 如果这个词与它所符合的协议或它的子类冲突,可以将`Type`后缀附加到泛型、关联类型名称后面。

```
class SomeClass<Model> { /* ... */ }
protocol Modelable {
    associatedtype Model
}
protocol Sequence {
    associatedtype IteratorType: Iterator
}
```

###### 2.7 命名具有可描述性和无歧义性。

```
// PREFERRED
class RoundAnimatingButton: UIButton { /* ... */ }

// NOT PREFERRED
class CustomButton: UIButton { /* ... */ }

```

###### 2.8 不可简化，缩短单词，或单一字符来命名。

```
// PREFERRED
class RoundAnimatingButton: UIButton {
    let animationDuration: NSTimeInterval

    func startAnimating() {
        let firstSubview = subviews.first
    }

}

// 不推荐
class RoundAnimating: UIButton {
    let aniDur: NSTimeInterval

    func srtAnmating() {
        let v = subviews.first
    }
}
```

###### 2.9 如果不是很明显，则在常量或变量名称中包含类型信息。

```
class ConnectionTableViewCell: UITableViewCell {
    let personImageView: UIImageView

    let animationDuration: TimeInterval

    // it is ok not to include string in the ivar name here because it's obvious
    // that it's a string from the property name
    let firstName: String

    // though not preferred, it is OK to use `Controller` instead of `ViewController`
    let popupController: UIViewController
    let popupViewController: UIViewController

    // when working with a subclass of `UIViewController` such as a table view
    // controller, collection view controller, split view controller, etc.,
    // fully indicate the type in the name.
    let popupTableViewController: UITableViewController

    // when working with outlets, make sure to specify the outlet type in the
    // property name.
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!

}
```

###### 2.10 函数命名：函数名、参数名需具有可描述性，可理解其作用。

###### 2.11 协议命名,依据协议作用分以下情况：

> 1. 使用名词命名：描述什么做什么。如CollectionView。
> 2. 使用后缀`able`、`ible`或`ing`：描述具备什么样的能力。如Equatable。
> 3. 视具体使用场景：其它情况。如使用后缀`Protocol `等。

```
// here, the name is a noun that describes what the protocol does
protocol TableViewSectionProvider {
    func rowHeight(at row: Int) -> CGFloat
    var numberOfRows: Int { get }
    /* ... */
}

// here, the protocol is a capability, and we name it appropriately
protocol Loggable {
    func logCurrentState()
    /* ... */
}

// suppose we have an `InputTextView` class, but we also want a protocol
// to generalize some of the functionality - it might be appropriate to
// use the `Protocol` suffix here
protocol InputTextViewProtocol {
    func sendTrackingEvent()
    func inputText() -> String
    /* ... */
}
```

## 3. 代码规范

#### 3.1 通用

###### 3.1.1 任何场景下，只要允许，尽可能使用`let`，而非`var`。

###### 3.1.2 当从一个集合转换到另一个集合时，优先考虑`map`、`filter`、`reduce`等的组合。
> 1. 确保在使用这些方法时避免使用有副作用的闭包

```
// PREFERRED
let stringOfInts = [1, 2, 3].flatMap { String($0) }
// ["1", "2", "3"]

// 不推荐
var stringOfInts: [String] = []
for integer in [1, 2, 3] {
    stringOfInts.append(String(integer))
}

// PREFERRED
let evenNumbers = [4, 8, 15, 16, 23, 42].filter { $0 % 2 == 0 }
// [4, 8, 16, 42]

// 不推荐
var evenNumbers: [Int] = []
for integer in [4, 8, 15, 16, 23, 42] {
    if integer % 2 == 0 {
        evenNumbers.append(integer)
    }
}
```

####### 3.1.3 若果可以通过推断得出常量、变量的类型，那就不用显式声明类型方式。

###### 3.1.4 若函数返回值有多个，则使用元祖（Tuple）而非`inout`参数返回。

> 1. 若返回值不易解读，最好使用标记元祖来清晰表达返回值作用。
> 2. 若多次使用某个元祖，可以考虑使用别名`typealias `
> 3. 若返回元祖中含有>=3个元素，则考虑使用`struct`或`class`替代方案。

```
func pirateName() -> (firstName: String, lastName: String) {
    return ("Guybrush", "Threepwood")
}

let name = pirateName()
let firstName = name.firstName
let lastName = name.lastName
```

###### 3.1.5 使用delegate、protocol时，注意循环引用问题。一般而言，此类属性命名，需要声明为`weak`。
###### 3.1.6 在escaping闭包中直接调用self，注意循环引用问题。使用[capture list](https://developer.apple.com/library/ios/documentation/swift/conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-XID_163)解决。

```
myFunctionWithEscapingClosure() { [weak self] (error) -> Void in
    // you can do this

    self?.doSomething()

    // or you can do this

    guard let strongSelf = self else {
        return
    }

    strongSelf.doSomething()
}
```

###### 3.1.7 不要使用可标记的Breaks。

###### 3.1.8 不要在控制流谓词上添加括号。

```
// PREFERRED
if x == y {
    /* ... */
}

// 不推荐
if (x == y) {
    /* ... */
}
```

###### 3.1.9 在enum枚举中：避免写出enum完整方式，尽可能使用简写方式。

```
// PREFERRED
imageView.setImageWithURL(url, type: .person)

// 不推荐
imageView.setImageWithURL(url, type: AsyncImageView.Type.person)
```
###### 3.1.10 在类方法中：避免使用缩写方式，因为从类方法中推断上下文通常比较困难。

```
// PREFERRED
imageView.backgroundColor = UIColor.white

// NOT PREFERRED
imageView.backgroundColor = .white
```

###### 3.1.11 除非必要，不使用`self.`。

###### 3.1.12 书写方法，是否考虑其后续被重写。
> 1. 若后续重写，则不需要考量。
> 2. 若后续不重写，需使其标记为`final`。（有助于优化编译时间）
> 3. 注：在Library中和在主项目中使用`final`，意义不同。


###### 3.1.13 使用诸如`else`、`catch`等语法时，其后跟随block块。遵循`1TBS style`。

```
if someBoolean {
    // do something
} else {
    // do something else
}

do {
    let fileContents = try readFile("filename.txt")
} catch {
    print(error)
}
```

###### 3.1.14 