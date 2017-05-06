//
//  UserInfo.m
//  CheWei
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
+(UserInfo *)shareUserInfo
{
    static UserInfo * userInfo = nil;
    @synchronized(self)
    {
        if (userInfo ==nil) {
            userInfo = [UserInfo new];
        }
    }
    return userInfo;
}
@end
