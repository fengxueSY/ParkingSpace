//
//  Rent_ParkViewController+createUI.h
//  CheWei
//
//  Created by shenyang on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Rent_ParkViewController.h"

@interface Rent_ParkViewController (createUI)
/**
 *创建基础的ui
 */
-(void)creatBaseUI:(CGFloat)tabH Str:(NSString *)reSt;
/**
 *创建选择类型的view
 */
-(UIView *)creatIndexOne:(CGRect)rect;
/**
 *出租价格的选择
 */
-(UILabel *)prace_park:(CGRect)rect;
/**
 *出租时间的选择
 */
-(UIView *)time_park:(CGRect)rect StartTime:(UILabel *)startLabel EndTime:(UILabel *)endLabel;
/**
 *出租车位的照片
 */
-(UIView *)photos_park:(CGRect)rect;
/**
 *出租车位的各项信息的填写
 */
-(UITextField *)writeInformation_park:(CGRect)rect;
@end
