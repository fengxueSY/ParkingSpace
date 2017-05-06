//
//  BindPhoneNumber.h
//  CheWei
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindPhoneNumber : BaseViewController<UITextFieldDelegate>
@property(nonatomic,strong)UITextField * phoneNumberNew;
@property(nonatomic,strong)UITextField * passwordFiled;
@property(nonatomic,strong)UITextField * textFiled;
@property(nonatomic,strong)UIButton * textButton;
@end
