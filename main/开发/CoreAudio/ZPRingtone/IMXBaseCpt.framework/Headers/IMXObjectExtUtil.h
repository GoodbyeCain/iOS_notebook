//
//  IMXObjectExtUtil.h
//  IMXBaseModules
//
//  Created by zhoupanpan on 2017/8/8.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#ifndef IMXObjectExtUtil_h
#define IMXObjectExtUtil_h

#define IMX_INCASE_EMPTY_OBJ_EXT(str, replace) \
(([(str)length] == 0) ? (replace) : (str))

#define IMX_INCASE_EMPTYSTRING_OBJ_EXT(str) \
(([(str)length] == 0) ? (@"") : (str))

#import <IMXBaseCpt/NSString+IMXFormatCheck.h>
#import <IMXBaseCpt/NSString+IMXSafeCheck.h>
#import <IMXBaseCpt/NSArray+IMXSafeCheck.h>
#import <IMXBaseCpt/NSDictionary+IMXSafeCheck.h>
#import <IMXBaseCpt/EXTScope.h>
#import <IMXBaseCpt/metamacros.h>
#import <IMXBaseCpt/NSAttributedString+IMXHighlightKit.h>
#import <IMXBaseCpt/NSObject+IMXExtFork.h>
#endif /* IMXObjectExtUtil_h */
