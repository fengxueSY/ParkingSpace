//
//  rent_list.h
//  CheWei
//
//  Created by shenyang on 16/4/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface rent_list : NSObject
@property (nonatomic,strong) NSString * contactName;/**<姓名*/
@property (nonatomic,strong) NSString * contactPhone;/**<电话*/
@property (nonatomic,strong) NSString * isFrequent;/**<是否常用车位，0不是，1是*/
@property (nonatomic,strong) NSString * parkingAddr;/**<车场地址*/
@property (nonatomic,strong) NSString * price;/**<价格*/
@property (nonatomic,strong) NSString * priceType;/**<计价方式，0按次，1按小时*/
@property (nonatomic,strong) NSString * spaceId;/**<车位ID*/
@property (nonatomic,strong) NSString * spaceType;/**<车位类型，0临时卡，1月卡*/
@property (nonatomic,strong) NSString * specificLoc;/**<车位具体地址*/
@end
