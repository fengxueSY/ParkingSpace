//
//  Search_history.h
//  CheWei
//
//  Created by shenyang on 16/4/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Search_history : NSObject
@property (nonatomic,copy) NSString * created;/**<创建时间*/
@property (nonatomic,copy) NSString * isFrequent;/**<是否常用地址，0 false，1 true*/
@property (nonatomic,copy) NSString * isNearby;/**<是否包括附近,0 false,1 true*/
@property (nonatomic,copy) NSString * lat;/**<地址对应的纬度*/
@property (nonatomic,copy) NSString * lng;/**<地址对应的经度*/
@property (nonatomic,copy) NSString * parkEnd;/**<出租结束时间*/
@property (nonatomic,copy) NSString * parkStart;/**<出租开始时间*/
@property (nonatomic,copy) NSString * parkingAddr;/**<地址（可能对应一个车场*/
@property (nonatomic,copy) NSString * parkingId;/**<车场id，如果该地址对应一个车场时，才有*/
@property (nonatomic,copy) NSString * reqId;/**<发布的车位需求的id*/
@property (nonatomic,copy) NSString * status;/**<状态：0 有效,1取消,2过期*/
@property (nonatomic,copy) NSString * uid;/**<ID*/
@property (nonatomic,copy) NSString * willExpire;/**<将在x分钟内有效,0表示只在当前有效*/
@end
