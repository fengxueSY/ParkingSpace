//
//  RentParkModel.h
//  CheWei
//
//  Created by shenyang on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RentParkModel : NSObject
@property(nonatomic ,copy) NSString * spaceId;/**<常放租车位的id*/
@property(nonatomic ,copy) NSString * spaceType;/**<常放租车位的类型，0临时卡，1月卡*/
@property(nonatomic ,copy) NSString * parkingAddr;/**<常放租车位的车场地址*/
@property(nonatomic ,copy) NSString * specificLoc;/**<常放租车位的具体地址*/
@property(nonatomic ,copy) NSString * price;/**<常放租车位的价格*/
@property(nonatomic ,copy) NSString * priceType;/**<常放租车位的价格计算方式，0按次，1按小时*/
@end
