//
//  TTShowAlter.m
//  CheWei
//
//  Created by apple on 16/3/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TTShowAlter.h"

//@implementation TTShowAlter
void TTAlert1(NSString * message,UIViewController * view){
    if (TT_systemVersion() >= 8.0) {
         UIAlertController * alter1 = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
         [alter1 addAction:action1];
         [view presentViewController:alter1 animated:YES completion:nil];
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:message
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
        [alert show];
    }
    
    
}
float TT_systemVersion(){
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
NSString *const myurl = @"登陆";
//@end
