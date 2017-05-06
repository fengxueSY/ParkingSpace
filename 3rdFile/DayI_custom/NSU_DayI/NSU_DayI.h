//
//  NSU_DayI.h
//  CheWei
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSU_DayI : NSObject
/**
 *  本地保存一个数据,方便单个数据操作
 */
+(void)defaultsSave:(id)value withKey:(NSString *)Mykey;
/**
 *  移除本地一个数据,
 */
+(void)defaultsRemove:(NSString *)Mykey;
/**
 *  读取一个数据
 */
+(id)defaultsRead:(NSString *)Mykey;
@end
