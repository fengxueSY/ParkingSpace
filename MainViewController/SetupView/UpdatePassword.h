//
//  UpdatePassword.h
//  CheWei
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePassword : BaseViewController<UITextFieldDelegate>
@property(nonatomic,strong)UITextField * passwordOld;
@property(nonatomic,strong)UITextField * passwordNew;
@end
