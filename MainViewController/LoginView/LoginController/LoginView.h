//
//  LoginView.h
//  CheWei
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : BaseViewController<UITextFieldDelegate>
@property(nonatomic,strong)UIButton * LoginButton;
@property(nonatomic,strong)UIButton * RegisterButton;
@property(nonatomic,strong)UIButton * sureButton;
@property(nonatomic,strong)UIView * phoneView;
@property(nonatomic,strong)UITextField * phoneFiled;
@property(nonatomic,strong)UIView * passwordView;
@property(nonatomic,strong)UITextField * passwordFiled;
-(void)sureAction;
@end
