//
//  Rent_ParkViewController.h
//  CheWei
//
//  Created by shenyang on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "ZHPickView.h"

@interface Rent_ParkViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ZHPickViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>{
    
}
@property (nonatomic,strong) ZHPickView * pickView;
@property (nonatomic,strong) NSString * actionStr;/**<0代表放租，1代表添加常用车位，2代表添加其他车位*/
@property (nonatomic,strong) NSDictionary * spaceDic;/**<放租传递过来的常用车位的信息*/
@property (nonatomic,strong) NSString * packType;/**<0代表月保卡车位，1代表临保车位*/
@property (nonatomic,strong) UITextField * contactName;/**<联系人的名字*/
@property (nonatomic,strong) UITextField * contactPhone;/**<联系人的电话*/
@property (nonatomic,strong) UILabel * parkAdress;/**<车库的详细地址*/
@property (nonatomic,strong) UITextField * parkInformation;/**<车位信息*/
@property (nonatomic,strong) NSString * rentTime;/**<出租时间*/
@property (nonatomic,strong) UITextField * rentPrice;/**<出租价格*/
@property (nonatomic,strong) UIImageView * packTypeImageView0;/**<选中月保卡时的显示view*/
@property (nonatomic,strong) UIImageView * packTypeImageView1;/**<选中临时卡时显示的view*/
@property (nonatomic,strong) UITableView * messageTableView;
@property (nonatomic,strong) UIButton * publishBu;/**<是否设置为常用租放车位*/
@property (nonatomic,strong) UIImageView * imageView1;
@property (nonatomic,strong) UIImageView * imageView2;
@property (nonatomic,strong) UIImageView * imageView3;
@property (nonatomic,strong) NSString * imageStr;/**<判断是哪一张图片*/

/**
 *发布车位的按钮
 */
-(void)publishPark;
/**
 *保存车位的按钮
 */
-(void)savePark;
/**
 *选择付费的方式
 */
//-(void)labelPraceTap;
@end
