//
//  UserInfo.h
//  CheWei
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
/**
 *  单例实例
 */
+(UserInfo *)shareUserInfo;
@property(nonatomic,strong)NSString * myURL;/**<区分测试,正式服务器*/
@property(nonatomic,strong)NSString * myRole;/**<0,是普通用户;1,是管理员*/
@property(nonatomic,strong)NSString * myGender;/**<0是男;1,是女*/
@property(nonatomic,strong)NSString * myNickName;
@property(nonatomic,strong)NSString * myPhoneNumber;/**<注册的手机号*/
@property(nonatomic,strong)NSString * myTelephone;/**<联系人手机号,可以和注册手机号一样*/
@property(nonatomic,strong)NSString * myToken;
@property(nonatomic,strong)NSString * myUid;
@end
