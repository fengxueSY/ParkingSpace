//
//  RegisterView.h
//  CheWei
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : BaseViewController<UITextFieldDelegate>
@property(nonatomic,strong)UIButton * textButton;
@property(nonatomic)NSUInteger minCount;/**<默认倒数时间*/
@property(nonatomic,strong)UIButton * buttonRegister;
@property(nonatomic,assign)NSUInteger registerCode;/**<1,是注册;2,是忘记密码;*/
@property(nonatomic,assign)NSUInteger type;/**<注册用户的类型*/
@property(nonatomic,strong)UITextField * phoneField;
@property(nonatomic,strong)UITextField * textField;
@property(nonatomic,strong)UITextField * passwordField;

@property(nonatomic,strong)UITextField * nameField;
@property(nonatomic,strong)UIButton * girlButton;
@property(nonatomic,strong)UIButton * boyButton;
@property(nonatomic,strong)UITextField * phoneField0;/**<联系人的手机号*/

@end
