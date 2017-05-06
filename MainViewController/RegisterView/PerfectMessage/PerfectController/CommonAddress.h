//
//  CommonAddress.h
//  CheWei
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonAddress : BaseViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView * addressTableView;
@property(nonatomic,strong)UIButton * skipButton;/**<*/
@property(nonatomic,strong)UIButton * confirmButton;/**<*/
@property(nonatomic,assign)NSUInteger code;/**<判断界面跳转*/
@property(nonatomic,strong)NSString * phoneNumber;
@property(nonatomic,strong)NSString * password;
@property(nonatomic,strong)NSString * textNumber;
@property(nonatomic,strong)NSString * typeUser;

@property(nonatomic,strong)UITextField * nameField;
@property(nonatomic,strong)UIButton * girlButton;
@property(nonatomic,strong)UIButton * boyButton;
@property(nonatomic,strong)UITextField * phoneField;
@end
