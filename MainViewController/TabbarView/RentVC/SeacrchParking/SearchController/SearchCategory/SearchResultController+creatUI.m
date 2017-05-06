//
//  SearchResultController+creatUI.m
//  CheWei
//
//  Created by shenyang on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchResultController+creatUI.h"

@implementation SearchResultController (creatUI)
-(void)creatBaseUI{
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"地图" style:UIBarButtonItemStyleDone target:self action:@selector(inspectMap)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.resultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight * 3 / 4)];
    self.resultTableView.scrollEnabled = NO;
    self.resultTableView.delegate = self;
    self.resultTableView.dataSource = self;
    [self.view addSubview:self.resultTableView];
//确认租赁
    UIButton * resultButton = [CreatUI creatButtonWithTitle:@"确认租赁" TitleColor:[UIColor blackColor] Frame:CGRectMake(WindowWidth / 9,CGRectGetMaxY(self.resultTableView.frame) + 5 , WindowWidth / 3, WindowHeight / 14) SetMasks:YES SetCorner:10 BackgroudColor:RGBcolor(190, 190, 190, 1) BackgroudImage:nil];
    resultButton.titleLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"16"] floatValue]];
    [resultButton addTarget:self action:@selector(resultButtonThePark) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resultButton];
    
//下一个
    UIButton * nextButton = [CreatUI creatButtonWithTitle:@"下一个" TitleColor:[UIColor blackColor] Frame:CGRectMake(WindowWidth * 5 / 9,CGRectGetMaxY(self.resultTableView.frame) + 5 , WindowWidth / 3, WindowHeight / 14) SetMasks:YES SetCorner:10 BackgroudColor:RGBcolor(190, 190, 190, 1) BackgroudImage:nil];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"16"] floatValue]];
    [nextButton addTarget:self action:@selector(nextButtonParkMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}
#pragma mark -- 确认支付的弹窗
-(void)resultWindow:(NSDictionary *)priceDic{
    if (self.windowView) {
        [self.windowView removeFromSuperview];
    }
    self.windowView = [[UIView alloc]init];
    self.windowView.frame = CGRectMake(WindowWidth / 8, WindowHeight / 6, WindowWidth * 6 / 8, WindowHeight / 2);
    self.windowView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.windowView];
    float viewW = WindowWidth * 6 / 8;
    float viewH = WindowHeight / 2;
    UILabel * snLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewW / 32, 0, viewW, viewH / 6)];
    snLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"16"] floatValue]];
    snLabel.text = [NSString stringWithFormat:@"订单号：%@",[priceDic objectForKey:@"sn"]];
    [self.windowView addSubview:snLabel];
    
    UILabel * amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewW / 32, CGRectGetMaxY(snLabel.frame), viewW, viewH / 6)];
    amountLabel.text = [NSString stringWithFormat:@"金额：%@",[priceDic objectForKey:@"amount"]];
    amountLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"16"] floatValue]];
    [self.windowView addSubview:amountLabel];
    
    UILabel * descLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewW / 32, CGRectGetMaxY(amountLabel.frame), viewW, viewH / 6)];
    descLabel.text = [NSString stringWithFormat:@"订单说明：%@",[priceDic objectForKey:@"desc"]];
    descLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"16"] floatValue]];
    [self.windowView addSubview:descLabel];
    
    UILabel * createdLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewW / 32, CGRectGetMaxY(descLabel.frame), viewW, viewH / 6)];
    createdLabel.text = [NSString stringWithFormat:@"时间：%@",[NSString millisecondChangeTime:[priceDic objectForKey:@"created"]]];
    createdLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"16"] floatValue]];
    [self.windowView addSubview:createdLabel];
    
    UIButton * moneyButton = [CreatUI creatButtonWithTitle:@"去支付" TitleColor:BLACK_color Frame:CGRectMake(viewW / 9, CGRectGetMaxY(createdLabel.frame) + viewH / 12, viewW / 3, viewH / 6) SetMasks:YES SetCorner:10 BackgroudColor:RGBcolor(190, 190, 190, 1) BackgroudImage:nil];
    moneyButton.titleLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"16"] floatValue]];
    [moneyButton addTarget:self action:@selector(moneyButtonForPay) forControlEvents:UIControlEventTouchUpInside];
    [self.windowView addSubview:moneyButton];
    
    UIButton * cleanButton = [CreatUI creatButtonWithTitle:@"取消" TitleColor:BLACK_color Frame:CGRectMake(viewW * 5 / 9, CGRectGetMaxY(createdLabel.frame) + viewH / 12, viewW / 3, viewH / 6) SetMasks:YES SetCorner:10 BackgroudColor:RGBcolor(190, 190, 190, 1) BackgroudImage:nil];
    cleanButton.titleLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"16"] floatValue]];
    [cleanButton addTarget:self action:@selector(cleanButtonTheView) forControlEvents:UIControlEventTouchUpInside];
    [self.windowView addSubview:cleanButton];
}
@end
