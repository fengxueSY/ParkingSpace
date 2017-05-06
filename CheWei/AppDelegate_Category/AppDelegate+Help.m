//
//  AppDelegate+Help.m
//  CheWei
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate+Help.h"

@implementation AppDelegate (Help)
-(void)helpAppSetting{
     [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:19], NSFontAttributeName, nil]];
     [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.6896 green:0.9673 blue:0.4869 alpha:1.0]];
    
    [SMSSDK registerApp:@"10eb0fb78af76" withSecret:@"dcbea906e9c9d3099d30342115a168f3"];
}
-(void)userMessage{
       self.info = Info_INIT;
       self.info.myURL = @"http://120.24.89.166:88/park";
       [NSU_DayI defaultsSave:@"1" withKey:CHANGE_ME];
//       self.info.myURL = @"https://p arkapi.ho2ho.com";
}
@end
