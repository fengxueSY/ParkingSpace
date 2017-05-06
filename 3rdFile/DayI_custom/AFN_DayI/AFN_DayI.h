//
//  AFN_DayI.h
//  CheWei
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFN_DayI : NSObject
/**
 *  请求JSON数据没有请求头
 */
+(AFHTTPSessionManager *)requestWithoutHeader_JSON;
/**
 *  请求JSON数据,有请求头
 */
+(AFHTTPSessionManager *)requestHeader_JSON:(NSString *)token;
/**
 *  请求XML数据没有请求头
 */
+(AFHTTPSessionManager *)requestWithoutHeader_XML;
/**
 * 请求xml数据有请求头
 */
+(AFHTTPSessionManager *)requestHeader_XML:(NSString *)token;

@end
