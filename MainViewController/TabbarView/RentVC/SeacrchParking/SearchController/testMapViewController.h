//
//  testMapViewController.h
//  CheWei
//
//  Created by shenyang on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
@protocol testMapViewControllerDeleagte <NSObject>
/**
 *  传回选择的地址
 */
-(void)publish_mapAddress:(NSDictionary *)addressDic;
@end


@interface testMapViewController : BaseViewController
@property (nonatomic,assign)id<testMapViewControllerDeleagte>delegate;
@end
