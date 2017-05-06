//
//  RentSearchController.h
//  CheWei
//
//  Created by shenyang on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import <ZBarSDK.h>

@interface RentSearchController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,AVCaptureMetadataOutputObjectsDelegate,ZBarReaderDelegate>
@property (nonatomic,strong) AVCaptureSession * captureSession;
@property (nonatomic,strong) UITableView * SearchTabelView;
@property (nonatomic,strong) UITableView * RentTabelView;
@property (nonatomic,strong) UIScrollView * baseScrollView;
@property (nonatomic,strong) UISegmentedControl * chooseSegementControl;/**<选择放车位或者租车位*/
@property (nonatomic,strong) UIButton * addRentButton;/**<增加车位*/



-(void)chooseType:(UISegmentedControl *)sender;
/**
 *  其他车位
 */
-(void)addButtonOther:(UIButton *)sender;
/**
 *  修改item
 */
-(void)changeRightItem:(NSString *)rightStr;
/**
 *  动画
 */
-(void)lineAnimate:(UIView *)lineView;
@end
