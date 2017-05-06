//
//  NSString+OtherFile.h
//  CheWei
//
//  Created by shenyang on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OtherFile)
/**
 *  后台给的毫秒，转化为yyyy-MM-dd hh：mm
 */
+(NSString *)millisecondChangeTime:(NSString *)millisecond;
/**
 *  适配其他屏幕字体的大小
 */
+(NSString *)fontForDifferentTextSize:(NSString *)size;
@end
