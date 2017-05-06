//
//  RentSearchController+creatUI.h
//  CheWei
//
//  Created by shenyang on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RentSearchController.h"

@interface RentSearchController (creatUI)
/**
 *  基础的UI，普通用户
 */
-(void)creatBaseUI;
/**
 *  管理员UI
 */
-(void)creatBaseUIAddendant;
/**
 *  二维码扫描界面的优化
 */
- (void)setOverlayPickerView:(ZBarReaderViewController *)reader;
@end
