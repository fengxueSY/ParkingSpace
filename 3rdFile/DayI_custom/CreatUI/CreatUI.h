//
//  CreatUI.h
//  CheWei
//
//  Created by shenyang on 16/4/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreatUI : NSObject
+(UIButton *)creatButtonWithTitle:(NSString *)title TitleColor:(UIColor *)titleColoe Frame:(CGRect)frame SetMasks:(BOOL)masks SetCorner:(CGFloat)corner BackgroudColor:(UIColor *)backgroudColor BackgroudImage:(UIImage *)backgroudImage;
+(UILabel *)creatLabelWithFrame:(CGRect)frame Text:(NSString *)text TextFont:(CGFloat)font BackgroudColor:(UIColor *)backgroudColor TextColor:(UIColor *)textColor;
@end
