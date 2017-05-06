//
//  ScanResultController+creatUI.m
//  CheWei
//
//  Created by shenyang on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ScanResultController+creatUI.h"

@implementation ScanResultController (creatUI)
#pragma mark --  创建基础的UI
-(void)creatBaseUI:(NSString *)lastStr{
    self.scanResultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, WindowWidth, WindowHeight * 4 / 5)];
    self.scanResultTableView.delegate = self;
    self.scanResultTableView.dataSource = self;
    [self.view addSubview:self.scanResultTableView];
    
    UIView * lastView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scanResultTableView.frame), WindowWidth, WindowHeight / 5 - 20)];
    [self.view addSubview:lastView];
    float viewW = lastView.frame.size.width;
    float viewH = lastView.frame.size.height;
    if ([lastStr integerValue] == 1) {
        UIButton * button = [CreatUI creatButtonWithTitle:@"确认进场" TitleColor:[UIColor blackColor] Frame:CGRectMake(viewW / 4, viewH / 5, viewW / 2, viewH * 3 / 5) SetMasks:YES SetCorner:10 BackgroudColor:RGBcolor(240, 240, 240, 1) BackgroudImage:nil];
        [button addTarget:self action:@selector(addendantConfirmEntering) forControlEvents:UIControlEventTouchUpInside];
        [lastView addSubview:button];
    }else{
        UILabel * upLabel = [CreatUI creatLabelWithFrame:CGRectMake(0, 0, viewW, viewH / 6) Text:lastStr TextFont:15 BackgroudColor:CLEAR_color TextColor:BLACK_color];
        upLabel.textAlignment = NSTextAlignmentCenter;
        [lastView addSubview:upLabel];
        UIButton * midButton = [CreatUI creatButtonWithTitle:@"确认离场" TitleColor:BLACK_color Frame:CGRectMake(viewW / 4, CGRectGetMaxY(upLabel.frame), viewW / 2, viewH * 4 / 6) SetMasks:YES SetCorner:10 BackgroudColor:RGBcolor(240, 240, 240, 1) BackgroudImage:nil];
        [midButton addTarget:self action:@selector(addendantConfirmLeaving) forControlEvents:UIControlEventTouchUpInside];
        [lastView addSubview:midButton];
        UILabel * downLabel = [CreatUI creatLabelWithFrame:CGRectMake(0, CGRectGetMaxY(midButton.frame), viewW, viewH / 6) Text:@"注：请管理员注意收回月卡" TextFont:16 BackgroudColor:CLEAR_color TextColor:BLACK_color];
        downLabel.textAlignment = NSTextAlignmentCenter;
        [lastView addSubview:downLabel];
    }

}
@end
