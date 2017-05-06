//
//  PublishController+creatUI.m
//  CheWei
//
//  Created by shenyang on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PublishController+creatUI.h"

@implementation PublishController (creatUI)
#pragma mark -- 创建基础的UI
-(void)creatBaseUI:(NSString *)pubStr{
    self.publishTableView = [[UITableView alloc]init];
    if ([pubStr integerValue] == 0) {
        self.publishTableView.frame = CGRectMake(0, 0, WindowWidth, WindowHeight * 2 / 3);
    }else if ([pubStr integerValue] == 1){
        self.publishTableView.frame = CGRectMake(0, 0, WindowWidth, WindowHeight / 8);
    }else{
        self.publishTableView.frame = CGRectMake(0, 0, WindowWidth, WindowHeight * 2 / 3);
    }
    self.publishTableView.delegate = self;
    self.publishTableView.dataSource = self;
    self.publishTableView.scrollEnabled = NO;
    [self.view addSubview:self.publishTableView];
    
    if ([pubStr integerValue] == 0) {
        //常用车位
        self.commonlyButton = [CreatUI creatButtonWithTitle:@"删除" TitleColor:[UIColor blackColor] Frame:CGRectMake(WindowWidth / 6, CGRectGetMaxY(self.publishTableView.frame) + 10, WindowWidth / 4, WindowHeight / 12) SetMasks:YES SetCorner:10 BackgroudColor:RGBcolor(230, 230, 230, 1) BackgroudImage:nil];
        self.commonlyButton.tag = 17000 + [[self.publishDic objectForKey:@"addressId"] integerValue];
        [self.commonlyButton addTarget:self action:@selector(deleteOftenSearchPark:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.commonlyButton];
        self.publishButton = [CreatUI creatButtonWithTitle:@"发布车位" TitleColor:[UIColor blackColor] Frame:CGRectMake(CGRectGetMaxX(self.commonlyButton.frame) + WindowWidth / 6, CGRectGetMaxY(self.publishTableView.frame) + 10, WindowWidth / 4, WindowHeight / 12) SetMasks:YES SetCorner:10 BackgroudColor:RGBcolor(230, 230, 230, 1) BackgroudImage:nil];
        self.publishButton.tag = 1600001;
        [self.publishButton addTarget:self action:@selector(publishSrarchPark) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.publishButton];
    }else if ([pubStr integerValue] == 1){
        
    }else{
        //找其他车位
        self.commonlyButton = [CreatUI creatButtonWithTitle:@"设为常找车位" TitleColor:[UIColor blackColor] Frame:CGRectMake(WindowWidth / 9 - 3, CGRectGetMaxY(self.publishTableView.frame) + 10, WindowWidth / 3 + 6, WindowHeight / 12) SetMasks:YES SetCorner:10 BackgroudColor:RGBcolor(230, 230, 230, 1) BackgroudImage:nil];
        [self.commonlyButton addTarget:self action:@selector(setOftenParkingForButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.commonlyButton];
        self.publishButton = [CreatUI creatButtonWithTitle:@"发布车位" TitleColor:[UIColor blackColor] Frame:CGRectMake(CGRectGetMaxX(self.commonlyButton.frame) + WindowWidth / 9 - 3, CGRectGetMaxY(self.publishTableView.frame) + 10, WindowWidth / 3 + 6, WindowHeight / 12) SetMasks:YES SetCorner:10 BackgroudColor:RGBcolor(230, 230, 230, 1) BackgroudImage:nil];
        self.publishButton.tag = 1600002;
        [self.publishButton addTarget:self action:@selector(publishSrarchPark) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.publishButton];
    }

}
-(UIView *)creatViewForLastCell:(CGRect)rect{
    UIView * view = [[UIView alloc]initWithFrame:rect];
    float viewH = view.frame.size.height;
    float viewW = view.frame.size.width;
    UILabel * nowTimeLabel = [CreatUI creatLabelWithFrame:CGRectMake(0, viewH / 16, viewW * 2 / 3, viewH / 4) Text:@"当前有效" TextFont:15 BackgroudColor:CLEAR_color TextColor:BLACK_color];
    [view addSubview:nowTimeLabel];
    self.customNowTimeButton = [CreatUI creatButtonWithTitle:nil TitleColor:nil Frame:CGRectMake(CGRectGetMaxX(nowTimeLabel.frame), viewH / 16, viewW / 4, viewH / 4) SetMasks:YES SetCorner:0 BackgroudColor:[UIColor greenColor] BackgroudImage:nil];
    [self.customNowTimeButton addTarget:self action:@selector(customNowTime) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.customNowTimeButton];
    
    self.cutomStr = @"0";
    
    UILabel * customLabel = [CreatUI creatLabelWithFrame:CGRectMake(0, CGRectGetMaxY(nowTimeLabel.frame) + viewH / 16, viewW * 2 / 3, viewH / 4) Text:@"自定义有效时间" TextFont:15 BackgroudColor:CLEAR_color TextColor:BLACK_color];
    [view addSubview:customLabel];
    self.customTimeButton = [CreatUI creatButtonWithTitle:nil TitleColor:nil Frame:CGRectMake(CGRectGetMaxX(customLabel.frame), CGRectGetMaxY(nowTimeLabel.frame) + viewH / 16, viewW / 4, viewH / 4) SetMasks:YES SetCorner:0 BackgroudColor:[UIColor grayColor] BackgroudImage:nil];
    [self.customTimeButton addTarget:self action:@selector(customTimeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.customTimeButton];
    
    self.cutomsTetxField = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(customLabel.frame) + viewH / 16, viewW, viewH / 4)];
    self.cutomsTetxField.placeholder = @"自定义时间";
    self.cutomsTetxField.delegate = self;
    [self.cutomsTetxField setBorderStyle:UITextBorderStyleRoundedRect];
    [view addSubview:self.cutomsTetxField];
    return view;
}
-(void)customNowTime{
    if ([self.cutomStr integerValue] == 1) {
        self.cutomStr = @"0";
        self.customNowTimeButton.backgroundColor = [UIColor greenColor];
        self.customTimeButton.backgroundColor = [UIColor grayColor];
    }else{
        
    }
}
-(void)customTimeButtonAction{
    if ([self.cutomStr integerValue] == 1) {
        
    }else{
        self.cutomStr = @"1";
        self.customNowTimeButton.backgroundColor = [UIColor grayColor];
        self.customTimeButton.backgroundColor = [UIColor greenColor];
    }
}
@end
