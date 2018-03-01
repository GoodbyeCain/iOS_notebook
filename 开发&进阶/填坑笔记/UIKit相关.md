# 填坑笔记

## 目录

* [UIAlertContrller](#UIAlertContrller)

## <span id = "UIAlertContrller"> UIAlertContrller </span>

1. 进行iPad开发时，使用UIAlertContrller的actionSheet属性时，注意与iPhone开发的区别。即需要添加sourceView、sourceRect。否则在ipad中运行时会crash。

	```
	let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
	//...
	if isPadDevice {
            alert.popoverPresentationController?.sourceView = baseCtrl?.view
            alert.popoverPresentationController?.sourceRect = CGRect.init(x: 10, y:UIScreen.main.bounds.height - 110 , width: 300, height: 400)
        }
   baseCtrl?.present(alert, animated: true, completion: nil)
	```