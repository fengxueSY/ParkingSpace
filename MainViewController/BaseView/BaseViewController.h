//
//  BaseViewController.h
//  CheWei
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 apple. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "UserInfo.h"
#define WindowWidth [UIScreen mainScreen].bounds.size.width
#define WindowHeight [UIScreen mainScreen].bounds.size.height
#define version1 [NSString iOS_systemVersion]
@interface BaseViewController : UIViewController
@property(nonatomic,strong)UserInfo * baseInfo;

@property (nonatomic,strong) UIImage * aLiyunImage;/**保存从阿里云下载下来的图片*/
/**
 *  上传图片到阿里云
 */
-(void)updateTheImage:(NSArray *)Images Type:(NSString *)type;
/**
 *  下载图片
 */
-(void)saveAndDisplayImage:(NSString *)ImageName;
/**
 *  保存下载的图片
 */
- (void)saveAndDisplayImage:(NSData *)objectData
          downloadObjectKey:(NSString *)objectKey;

@end
