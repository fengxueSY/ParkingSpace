//
//  OssService.h
//  OssIOSDemo
//
//  Created by 凌琨 on 15/12/15.
//  Copyright © 2015年 Ali. All rights reserved.
//

#ifndef OssService_h
#define OssService_h
#import <AliyunOSSiOS/OSSService.h>
#import "ViewController.h"
@interface OssService : NSObject

- (id)initWithViewwithEndPoint:(NSString *)enpoint;

- (void)setCallbackAddress:(NSString *)address;

- (void)asyncPutImage:(NSString *)objectKey
        localFilePath:(NSString *)filePath;

- (void)asyncGetImage:(NSString *)objectKey;

- (void)resumableUpload:(NSString *)objectKey
          localFilePath:(NSString *)filePath
               partSize:(int)size;

- (void)normalRequestCancel;
- (void)ResumableUploadCancel;
- (void)resumableUploadPause;
/**
 *	@brief	初始化获取OSSClient
 */
- (void)ossInit:(NSDictionary *)tokenDic;
@end

#endif /* OssService_h */
