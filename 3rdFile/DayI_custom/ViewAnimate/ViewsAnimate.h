//
//  ViewsAnimate.h
//  CheWei
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewsAnimate : UIView
/**
 *  雪花飘落效果,结合NSTimer来做
 *
 *  @param showView 飘落界面
 */
+(void)snowAnimate:(UIView *)showView;
@end
