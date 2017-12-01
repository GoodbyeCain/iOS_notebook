//
//  ZPMacroDefine.h
//  DHSeller
//
//  Created by zhoupanpan on 2017/11/30.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#ifndef ZPMacroDefine_h
#define ZPMacroDefine_h

/**
 *
 注：尽量不要写通用的宏定义
 
 1. 关于屏幕宽度高度：若使用，请查阅`IMXBaseCpt中Libs-2nd-UIKitExt`部分
 2. 色值：`ZPColorDefineKit.h`文件
 3. 字体：IMXBaseCpt中IMXStyleKit和ZPFontMacroDefine.h文件
 *
 **/

//国际化临时方案
#define __(key) NSLocalizedString(key, key)

#endif /* ZPMacroDefine_h */
