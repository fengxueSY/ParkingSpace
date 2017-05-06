//
//  SearchParkModel.h
//  CheWei
//
//  Created by shenyang on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchParkModel : NSObject
@property(nonatomic ,copy) NSString * addressId;/**<常找车位的id*/
@property(nonatomic ,copy) NSString * created;/**<常找车位发布的时间*/
@property(nonatomic ,copy) NSString * lng;
@property(nonatomic ,copy) NSString * lat;
@property(nonatomic ,copy) NSString * parkingAddr;/**<常找车位的地址*/
@property(nonatomic ,copy) NSString * parkingId;/**<常找车位的地址*/
@end
