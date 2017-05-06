//
//  NSU_DayI.m
//  CheWei
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSU_DayI.h"

@implementation NSU_DayI
+(void)defaultsSave:(id)value withKey:(NSString *)Mykey{
         NSUserDefaults * save = [NSUserDefaults standardUserDefaults];
        [save setObject:value forKey:Mykey];
        [save synchronize];
}
+(void)defaultsRemove:(NSString *)Mykey{
        NSUserDefaults * remove = [NSUserDefaults standardUserDefaults];
        [remove removeObjectForKey:Mykey];
        [remove synchronize];
}
+(id)defaultsRead:(NSString *)Mykey{
        NSUserDefaults * read = [NSUserDefaults standardUserDefaults];
        id value = [read objectForKey:Mykey];
        return value;
}
@end
