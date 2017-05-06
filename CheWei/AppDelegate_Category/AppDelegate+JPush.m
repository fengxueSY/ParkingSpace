//
//  AppDelegate+JPush.m
//  CheWei
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate+JPush.h"
static NSString * JPushKey = @"5fdf99f81e0eb561f470efbd";
static NSString * channel = @"Publish channel";
@implementation AppDelegate (JPush)
-(void)registerJPush:(NSDictionary *)launchOptions{
    if ([NSString iOS_systemVersion] >= 8) {
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    }else{
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions appKey:JPushKey channel:channel apsForProduction:NO];
//    [JPUSHService setDebugMode];
//    [JPUSHService setLogOFF];
}
#pragma mark -- 上传token 值
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
//    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark -- iOS6以下接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
#pragma mark -- 高于或者等于ios7接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"查看收到的信息2=%@",userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
}
#pragma mark -- 错误信息
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //Optional
//    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark -- 本地通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
        [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}
@end
