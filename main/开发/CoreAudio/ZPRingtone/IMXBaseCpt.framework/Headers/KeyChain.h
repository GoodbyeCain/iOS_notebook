//
//  KeyChain.h
//  iPhone
//
//  Created by song on 15/3/13.
//  Copyright (c) 2015年 dhgate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChain : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;
@end
