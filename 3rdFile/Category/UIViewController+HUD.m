/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = hint;
//    HUD.dimBackground = YES;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}
- (void)successShowAndHideHudInView:(UIView *)view hint:(NSString *)hint Delay:(NSTimeInterval)time{
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.detailsLabelText = hint;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HUD_YES.png"]];
    //    HUD.dimBackground = YES;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
    [HUD hide:YES afterDelay:time];
}
- (void)failShowAndHideHudInView:(UIView *)view hint:(NSString *)hint Delay:(NSTimeInterval)time{
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = hint;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HUD_NO.png"]];
    HUD.animationType = MBProgressHUDAnimationZoomOut;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
    [HUD hide:YES afterDelay:time];

}
- (void)showHint:(NSString *)hint {
    if ([hint isEqualToString:@"录音没有开始"]) {

    }
    
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}
- (void)showHeaderHint:(NSString *)hint {
    if ([hint isEqualToString:@"录音没有开始"]) {
    }
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:-100.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}
- (void)showHeaderHint:(NSString *)hint delayTime:(NSTimeInterval)time{
    if ([hint isEqualToString:@"录音没有开始"]) {
    }
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:-100.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:time];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

- (void)hideHud{
    [[self HUD] hide:YES];
}

@end
