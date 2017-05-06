//
//  UserMessage.h
//  CheWei
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserMessage : BaseModel
/**
 *  将用户信息本地保存
 */
+(void)saveUserMessage:(NSDictionary *)dic;
/**
 *  读取本地数据
 */
+(void)readUserMessage;

@end
