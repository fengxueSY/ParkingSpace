//
//  CreatUI.m
//  CheWei
//
//  Created by shenyang on 16/4/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CreatUI.h"

@implementation CreatUI
+(UIButton *)creatButtonWithTitle:(NSString *)title TitleColor:(UIColor *)titleColoe Frame:(CGRect)frame SetMasks:(BOOL)masks SetCorner:(CGFloat)corner BackgroudColor:(UIColor *)backgroudColor BackgroudImage:(UIImage *)backgroudImage{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColoe) {
        [button setTitleColor:titleColoe forState:UIControlStateNormal];
    }
    if (backgroudColor) {
        button.backgroundColor = backgroudColor;
    }
    if (backgroudImage) {
        [button setBackgroundImage:backgroudImage forState:UIControlStateNormal];
    }
    if (masks) {
        if (masks == YES) {
            [button.layer setMasksToBounds:masks];
            [button.layer setCornerRadius:corner];
        }
    }
    return button;
}
+(UILabel *)creatLabelWithFrame:(CGRect)frame Text:(NSString *)text TextFont:(CGFloat)font BackgroudColor:(UIColor *)backgroudColor TextColor:(UIColor *)textColor{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    if (text) {
        label.text = text;
    }
    if (backgroudColor) {
        label.backgroundColor = backgroudColor;
    }
    if (font) {
        label.font = [UIFont systemFontOfSize:font];
    }
    if (textColor) {
        label.textColor = textColor;
    }
    return label;
}
@end
