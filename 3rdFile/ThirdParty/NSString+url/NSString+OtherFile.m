//
//  NSString+OtherFile.m
//  CheWei
//
//  Created by shenyang on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSString+OtherFile.h"

@implementation NSString (OtherFile)
//后台给的毫秒，转化为yyyy-MM-dd hh：mm
+(NSString *)millisecondChangeTime:(NSString *)millisecond{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[millisecond doubleValue] / 1000];
    NSString * string = [formatter stringFromDate:date];
    return string;
}
//适配其他屏幕字体的大小
+(NSString *)fontForDifferentTextSize:(NSString *)size{
    float sizeText = [size floatValue];
    float textSize;
    if (WindowWidth >= 370) {
        textSize = sizeText;
    }else if (WindowWidth <= 320){
        textSize = sizeText - 2;
    }else{
        textSize = sizeText - 1;
    }
    return [NSString stringWithFormat:@"%.0f",textSize];
}
@end
