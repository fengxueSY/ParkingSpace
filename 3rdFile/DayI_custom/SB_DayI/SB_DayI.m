//
//  SB_DayI.m
//  CheWei
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SB_DayI.h"
#import "SBJson.h"
@implementation SB_DayI

+(NSDictionary *)analysisMessage:(id)message{
    SBJsonParser * sb = [[SBJsonParser alloc]init];
    NSDictionary * dic = [sb objectWithData:message];
    return dic;
}
@end
