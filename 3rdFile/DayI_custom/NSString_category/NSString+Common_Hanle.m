//
//  NSString+Common_Hanle.m
//  CheWei
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSString+Common_Hanle.h"

@implementation NSString (Common_Hanle)
+(float)iOS_systemVersion{
    float VersionNow = [[[UIDevice currentDevice] systemVersion] floatValue];
    return VersionNow;
}
+(float)handelWideContent:(NSString *)content AndFontsize:(NSUInteger)font AndMaxsize:(CGSize)size{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary * attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize h = [content boundingRectWithSize:size options:    NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    return h.width;
}
+(float)handelHighContent:(NSString *)content AndFontsize:(UIFont *)font AndMaxsize:(CGSize )size{
    CGSize temp = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    return temp.height;
}
//判断是否是整型
+(BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}
//判断是否是浮点型
+(BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}
+(NSString *)databaseWay:(NSString *)sqliteName{
    NSArray * filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentPath = [filePath objectAtIndex:0];
    //    NSLog(@"当前用户的fmdb = %@",filePath);
    NSString * myString = [NSString stringWithFormat:@"%@_chewei.sqlite",sqliteName];
    NSString * dbFilePath = [documentPath stringByAppendingPathComponent:myString];
    return dbFilePath;
    
}
+(BOOL)isNull:(NSString *)string{
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    else{
        return NO;
    }
}
+(NSString*)getPath:(UIImage*)image{
    NSData * data;
    data = UIImageJPEGRepresentation(image, 0.3);//图片压缩
    //设置时间格式,用时间来对写进沙盒的头像进行命名
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString * dateString = [formatter stringFromDate:[NSDate date]];
    NSString * strSuji = [[NSString alloc]initWithFormat:@"/Library/Caches/%@.jpg",dateString];
    NSString * path = [NSHomeDirectory() stringByAppendingString:strSuji];
    NSFileManager * file = [NSFileManager defaultManager];
    [file createFileAtPath:path contents:data attributes:nil];
    NSString * fileHeadImage = [NSHomeDirectory() stringByAppendingString:strSuji];
    return fileHeadImage;
}
+(NSString *)arrayToString:(NSArray *)array{
    NSString * arrString = [[NSString alloc]init];
    NSError * err = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&err];
    arrString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  
    return arrString;
}
+(NSArray *)stringToArray:(NSString *)string{
    NSError * err = nil;
    NSData * data1 = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray * array = [NSJSONSerialization JSONObjectWithData:data1 options:kNilOptions error:&err];
    return array;
}
@end
