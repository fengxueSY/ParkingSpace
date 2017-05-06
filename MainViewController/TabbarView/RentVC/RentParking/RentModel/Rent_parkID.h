//
//  Rent_parkID.h
//  CheWei
//
//  Created by shenyang on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rent_parkID : NSObject
@property(nonatomic,copy) NSString * parkingAddr;/**<地址*/
@property(nonatomic,copy) NSString * lat;/**<纬度*/
@property(nonatomic,copy) NSString * lng;/**<经度*/
@property(nonatomic,copy) NSString * parkingId;/**<获取的车场的ID*/
@end
