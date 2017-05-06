//
//  MonitifyNickname.h
//  CheWei
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonitifyNickname : BaseViewController<UITextFieldDelegate>
@property(nonatomic,strong)UITextField * nickNameFiled;
@property(nonatomic,strong)NSString * fromType;/**<1,是修改昵称;2,是修改联系电话;3,是修改车牌(用户才有)*/
@end
