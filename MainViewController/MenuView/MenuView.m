//
//  MenuView.m
//  CheWei
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MenuView.h"

@interface MenuView ()

@end

@implementation MenuView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.9184 blue:0.3742 alpha:1.0];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [NSU_DayI defaultsRemove:PHONENUMBER];
    NSNotification * noti = [[NSNotification alloc]initWithName:@"rootViewChange" object:nil userInfo:@{@"code":@"2"}];
    [[NSNotificationCenter defaultCenter] postNotification:noti];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
