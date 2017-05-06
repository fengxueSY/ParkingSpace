//
//  NSString+URL.h
//  CheWei
//
//  Created by shenyang on 16/4/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)
#pragma mark -- 放租车位
/**
 *列出某放租人的长放租车位
 */
+(NSString *)listOftenPark:(NSString *)owerID httpsUrl:(NSString *)httpsUrl;
/**
 *列出某放租人的所有车位
 */
+(NSString *)listAllRentPark:(NSString *)owerID httpsUrl:(NSString *)httpsUrl;
/**
 *查询用户查询自己的某车位具体信息
 */
+(NSString *)searchParkInformation:(NSString *)parkID httpsUrl:(NSString *)httpsUrl;
/**
 *创建新车位
 */
+(NSString *)setUpNewParkInformation:(NSString *)httpsUrl;
/**
 *更新某车位信息
 */
+(NSString *)refreshParkInformation:(NSString *)parkID httpsUrl:(NSString *)httpsUrl;
/**
 *设置或取消设置某车位为常用车位
 */
+(NSString *)commonlyUsedPark:(NSString *)parkID httpsUrl:(NSString *)httpsUrl;
/**
 *删除某车位
 */
+(NSString *)cleanPark:(NSString *)parkID httpsUrl:(NSString *)httpsUrl;
/**
 *发布车位
 */
+(NSString *)publishPark:(NSString *)parkID httpsUrl:(NSString *)httpsUrl;
/**
 *创建新的车位并发布
 */
+(NSString *)setUpAndPublishPark:(NSString *)httpsUrl;
/**
 *  获取车场的ID
 */
+(NSString *)obtainParkID:(NSString *)httpsUrl;
#pragma mark -- 找车位
/**
 *  查询常用租位地址
 */
+(NSString * )searchOftenPark:(NSString *)owerID httpsUrl:(NSString *)httpsUrl;
/**
 *  根据用户输入的地址关键词，查找出最相似的地址或停车场
 */
+(NSString *)searchParkFromKeyword:(NSString *)httpsUrl;
/**
 *  提交车位需求，以便查找匹配车位，如果有匹配的车位，返回，如果暂时没有，根据有效期限，系统中有匹配的车位时再通过消息通知。
 */
+(NSString *)searchParkBasisNeed:(NSString *)httpsUrl;
/**
 *  增加一个常用租位地址
 */
+(NSString *)addSearchParkAddress:(NSString *)httpsUrl;
/**
 *  取消一个有效期内的车位需求，取消后系统不再查找匹配的车位。
 */
+(NSString *)cleanOffectivePark:(NSString *)parkID httpsUrl:(NSString *)httpsUrl;
/**
 *  删除车位需求历史
 */
+(NSString *)deleteSearchPark:(NSString *)parkID httpsUrl:(NSString *)httpsUrl;
/**
 *  换下一个车位
 */
+(NSString *)changeNextPark:(NSString *)parkID httpsUrl:(NSString *)httpsUrl;
/**
 *  查询历史需求
 */
+(NSString *)searchParkInHistory:(NSString *)owerID httpsUrl:(NSString *)httpsUrl;
/**
 *  删除一个常用租位地址
 */
+(NSString *)deleteOneOftenPark:(NSString *)addressID httpsUrl:(NSString *)httpsUrl;
#pragma mark -- 订单
/**
 *  找到车位下订单
 */
+(NSString *)creatParkingTradeHttpsUrl:(NSString *)httpsUrl;
/**
 *  用余额支付交易订单
 */
+(NSString *)chooseBalancePay:(NSString *)balance httpsUrl:(NSString *)httpsUrl;
/**
 *  查询余额总额
 */
+(NSString *)searchUserBalance:(NSString *)httpsUrl;
/**
 *  对当前车位不满意，换下一个。如果当时就有匹配的车位，返回，如果暂时没有，根据有效期限，系统中有匹配的车位时再通过消息通知
 */
+(NSString *)nextParkingReqId:(NSString *)reqId httpsUrl:(NSString *)httpsUrl;
#pragma mark -- 车场操作
/**
 *  获取安全码，提供给前端生成二唯码。之后管理员扫码识别出操作需要的安全码和订单号信息
 */
+(NSString *)obtainSecure_KeyOwerID:(NSString *)owerId OrderID:(NSString *)orderId OpType:(NSString *)opType httpsUrl:(NSString *)httpsUrl;
/**
 *  管理员查看进行中的订单列表
 */
+(NSString *)addendantInspectOrderingOwerID:(NSString *)owerId Page:(NSString *)page httpsUrl:(NSString *)httpsUrl;
/**
 *  管理员查看单个进行中的的订单详情
 */
+(NSString *)addendantInspectOneOrderDetailsOwerID:(NSString *)owerId OrderID:(NSString *)orderId httpsUrl:(NSString *)httpsUrl;
/**
 *  进场、离场、交卡操作 扫描二唯码，二唯码的信息为
 */
+(NSString *)scanImageOrder_operationHttpsUrl:(NSString *)httpsUrl;
/**
 *  车场管理员查看操作自己相关的记录
 */
+(NSString *)addendantOperateRecordOwerID:(NSString *)owerId Page:(NSString *)page httpsUrl:(NSString *)httpsUrl;
@end
