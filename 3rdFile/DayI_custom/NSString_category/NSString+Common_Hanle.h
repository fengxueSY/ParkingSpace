/*
 自定义一些常用的操作,或者系统参数
 */
@interface NSString (Common_Hanle)
/**
 *返回一个当前操作系统的版本号,iOS8或者其他
 */
+(float)iOS_systemVersion;
/**
 *根据文字的大小和确定高度 返回宽度
 */
+(float)handelWideContent:(NSString *)content AndFontsize:(NSUInteger)font AndMaxsize:(CGSize )size;
/**
 *根据文字的大小和确定的宽度 返回高度
 */
+(float)handelHighContent:(NSString *)content AndFontsize:(UIFont *)font AndMaxsize:(CGSize )size;
/**
 *判断字符串是否为浮点型
 */
+(BOOL)isPureFloat:(NSString*)string;
/**
 *判断字符串是否为整型
 */
+(BOOL)isPureInt:(NSString*)string;
/**
 *  保存FMDB的数据路径
 *
 *  @param sqliteName 数据库的名称
 */
+(NSString *)databaseWay:(NSString *)sqliteName;
/**
 *  判断字符串是否为null,而非nil
 */
+(BOOL)isNull:(NSString *)string;
/**
 *  本地需要上传图片到服务器,图片先存进沙盒,然后获取到的路径.
 */
+(NSString *)getPath:(UIImage*)image;
/**
 *  数组转字符串
 */
+(NSString *)arrayToString:(NSArray *)array;
/**
 *  字符串解析成数组(是之前数组转换过来的),还没有进行验证是否可行
 */
+(NSArray *)stringToArray:(NSString *)string;
@end
