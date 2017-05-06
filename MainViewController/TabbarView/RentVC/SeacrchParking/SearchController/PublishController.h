//
//  PublishController.h
//  CheWei
//
//  Created by shenyang on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "ZHPickView.h"

@interface PublishController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong) UITableView * publishTableView;
@property (nonatomic,strong) NSDictionary * publishDic;/**<查找常用车位时传递过来的信息*/
@property (nonatomic,strong) NSString * publishStr;/**<判断是点击那个按钮进入该界面，0--常用车位，1--添加常用车位，2--找其他车位*/


@property (nonatomic,strong) UIButton * commonlyButton;/**<设置为常用车位*/
@property (nonatomic,strong) UIButton * publishButton;/**<发布要查找的车位*/
@property (nonatomic,strong) UITextField * startTimeTextField;/**<开始租车位的时间*/
@property (nonatomic,strong) UITextField * endTimeTextField;/**<结束租车位的时间*/
@property (nonatomic,strong) NSString * cutomStr;/**<判断选择的时间是自定义还是当前，0代表当前，1代表自定义*/
@property (nonatomic,strong) UIButton * customNowTimeButton;/**<当前有效的按钮*/
@property (nonatomic,strong) UIButton * customTimeButton;/**<自定义有效时间的按钮*/
@property (nonatomic,strong) UITextField * cutomsTetxField;/**<自定义的有效时间*/
@property (nonatomic,strong) UILabel * parkTextLabel;/**<找车位的位置*/
@property (nonatomic,copy) NSString * setOftenParking;/**<发布找车位的需求的同时，把该车位设为常用车位，0设置，1不设置*/

/**
 *  添加常用找车位
 */
-(void)addOftenSearchPark;
/**
 *  发布车位参数
 */
-(void)publishSrarchPark;
/**
 *  发布找车位的需求的同时，把该车位设为常用车位
 */
-(void)setOftenParkingForButton;
/**
 *  删除某一常用车位
 */
-(void)deleteOftenSearchPark:(UIButton *)sender;
-(void)back;

@end
