//
//  InterfaceSummary.m
//  CheWei
//
//  Created by apple on 16/4/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "InterfaceSummary.h"

NSString* loginInterface(NSString * myurl){//登录
    return [NSString stringWithFormat:@"%@/api/user/login",myurl];
}
NSString* valicationInterface(NSString * myurl){//验证手机号
    return [NSString stringWithFormat:@"%@/api/phone/validation",myurl];
}
NSString* registerInterface(NSString* myurl){//注册
    return [NSString stringWithFormat:@"%@/api/user",myurl];
}
NSString* passwordBackInterface(NSString* myurl){//找回密码
    return [NSString stringWithFormat:@"%@/api/user/password/reset",myurl];
}
NSString* updatePasswordInterface(NSString * myurl){//修改密码
    return [NSString stringWithFormat:@"%@/api/user/password",myurl];
}
NSString* bindPhoneNumberInterface(NSString * myurl){//修改绑定手机号
    return [NSString stringWithFormat:@"%@/api/user/phone/reset",myurl];
}
NSString* updateNicknameInterface(NSString * myurl){
    return [NSString stringWithFormat:@"%@/api/user/nickname",myurl];
}
NSString* updateTelephoneInterface(NSString * myurl){
    return [NSString stringWithFormat:@"%@/api/user/telephone",myurl];
}
NSString* updatePlateInterface(NSString * myurl){
    return [NSString stringWithFormat:@"%@/api/user/plate",myurl];
}
