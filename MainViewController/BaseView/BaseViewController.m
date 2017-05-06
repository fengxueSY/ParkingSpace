//
//  BaseViewController.m
//  CheWei
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (){
    OssService * service;
    OssService * imageService;
    ImageService * imageOperation;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([NSString iOS_systemVersion] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.translucent = YES;//是否透明

    }
        _baseInfo = Info_INIT;
    
    //阿里云存放图片《由后台提供》
    NSString * const endPoint = @"oss-cn-shenzhen.aliyuncs.com";
    NSString * const imageEndPoint = @"http://img-cn-shenzhen.aliyuncs.com";
    //上传的回调地址《由后台提供》
    NSString * const callbackAddress = @"http://120.24.89.166:8080/hoho/api/oss/callback";
    
    service = [[OssService alloc] initWithViewwithEndPoint:endPoint];
    [service setCallbackAddress:callbackAddress];
    imageService = [[OssService alloc] initWithViewwithEndPoint:imageEndPoint];
    imageOperation = [[ImageService alloc] initImageService:imageService];
}
-(void)updateTheImage:(NSArray *)Images Type:(NSString *)type{
    
//    [service asyncPutImage:ImageName localFilePath:filePath];
}
-(void)saveAndDisplayImage:(NSString *)ImageName{
    [service asyncGetImage:ImageName];
}
-(void)saveAndDisplayImage:(NSData *)objectData downloadObjectKey:(NSString *)objectKey{
    _aLiyunImage = [UIImage imageWithData:objectData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
