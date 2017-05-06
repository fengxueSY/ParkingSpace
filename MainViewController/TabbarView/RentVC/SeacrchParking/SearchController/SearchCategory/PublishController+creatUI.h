//
//  PublishController+creatUI.h
//  CheWei
//
//  Created by shenyang on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PublishController.h"

@interface PublishController (creatUI)
/**
 *  创建基础的UI
 */
-(void)creatBaseUI:(NSString *)pubStr;
/**
 *  为最后一个cell创建view
 */
-(UIView *)creatViewForLastCell:(CGRect)rect;
@end
