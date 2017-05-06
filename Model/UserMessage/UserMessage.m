//
//  UserMessage.m
//  CheWei
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UserMessage.h"

@implementation UserMessage
+(void)saveUserMessage:(NSDictionary *)dic{
    UserInfo * info = Info_INIT;
    info.myGender = dic[@"gender"];
    info.myNickName = dic[@"nickname"];
    info.myPhoneNumber = dic[@"phoneNumber"];
    info.myRole = dic[@"role"];
    info.myTelephone = dic[@"telephone"];
    info.myUid = dic[@"uid"];
    info.myToken = dic[@"token"][@"token"];
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    [myDefault setObject:info.myGender forKey:GENDER];
    [myDefault setObject:info.myNickName forKey:NICKNAME];
    [myDefault setObject:info.myPhoneNumber forKey:PHONENUMBER];
    [myDefault setObject:info.myRole forKey:ROLE];
    [myDefault setObject:info.myTelephone forKey:TELEPHONR];
    [myDefault setObject:info.myUid forKey:UID];
    [myDefault setObject:info.myToken forKey:TOKEN];
    [myDefault synchronize];
}
+(void)readUserMessage{
    NSUserDefaults * myDefault = [NSUserDefaults standardUserDefaults];
    UserInfo * info = Info_INIT;
    info.myGender = [myDefault objectForKey:GENDER];
    info.myNickName = [myDefault objectForKey:NICKNAME];
    info.myPhoneNumber = [myDefault objectForKey:PHONENUMBER];
    info.myRole = [myDefault objectForKey:ROLE];
    info.myTelephone = [myDefault objectForKey:TELEPHONR];
    info.myUid = [myDefault objectForKey:UID];
    info.myToken = [myDefault objectForKey:TOKEN];
}
@end
