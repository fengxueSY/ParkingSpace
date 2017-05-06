//
//  TabBarView+parkMessage.m
//  CheWei
//
//  Created by shenyang on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TabBarView+parkMessage.h"

@implementation TabBarView (parkMessage)
#pragma mark -- 显示车场信息
-(void)creatParkMessageView:(NSDictionary *)parkMessageDic{
    if (self.parkMessageView) {
        [self.parkMessageView removeFromSuperview];
    }
    NSArray * array = [parkMessageDic objectForKey:@"data"];
    NSMutableDictionary * dic;
    if (array.count > 0) {
        dic = [[NSMutableDictionary alloc]initWithDictionary:array[0]];
        self.parkMessageView = [[UIView alloc]initWithFrame:CGRectMake(WindowWidth / 8, WindowHeight / 4, WindowWidth * 6 / 8, WindowHeight / 3)];
        self.parkMessageView.backgroundColor = [UIColor blackColor];
        self.parkMessageView.alpha = 0.7;
        [self.view addSubview:self.parkMessageView];
        
        float viewW = WindowWidth * 6 / 8;
        float viewH = WindowHeight / 3;
        //顶部的label
        UILabel * topLabel = [CreatUI creatLabelWithFrame:CGRectMake(viewW / 4, 0, viewW / 2, viewH / 8) Text:@"系统找到以下车位" TextFont:15 BackgroudColor:[UIColor clearColor] TextColor:[UIColor whiteColor]];
        [self.parkMessageView addSubview:topLabel];
        //取消的butto
        UIButton * deleteButton = [CreatUI creatButtonWithTitle:@"取消" TitleColor:BLACK_color Frame:CGRectMake(CGRectGetMaxX(topLabel.frame), 0, viewW / 4, viewH / 8) SetMasks:NO SetCorner:0 BackgroudColor:[UIColor orangeColor] BackgroudImage:nil];
        deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [deleteButton addTarget:self action:@selector(deleteParkMessageView) forControlEvents:UIControlEventTouchUpInside];
        [self.parkMessageView addSubview:deleteButton];
        //车位的地址
        NSString * spaceType;
        if ([[dic objectForKey:@"spaceType"] integerValue] == 0) {
            spaceType = @"月保卡";
        }else{
            spaceType = @"临时卡";
        }
        NSString * parkStr = [NSString stringWithFormat:@"%@ %@ %@",[dic objectForKey:@"parkingAddr"],[dic objectForKey:@"specificLoc"],spaceType];
        UILabel * parkAddressLabel = [CreatUI creatLabelWithFrame:CGRectMake(0, CGRectGetMaxY(topLabel.frame), viewW, viewH / 4) Text:parkStr TextFont:15 BackgroudColor:[UIColor clearColor] TextColor:[UIColor whiteColor]];
        parkAddressLabel.numberOfLines = 0;
        [self.parkMessageView addSubview:parkAddressLabel];
        //租放发时间
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        NSDate * startTime = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"parkStart"] doubleValue] / 1000];
        NSDate * endTime = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"parkEnd"] doubleValue] / 1000];
        NSString * timeStr = [NSString stringWithFormat:@"%@~%@",[formatter stringFromDate:startTime],[formatter stringFromDate:endTime]];
        UILabel * timeLabel = [CreatUI creatLabelWithFrame:CGRectMake(0, CGRectGetMaxY(parkAddressLabel.frame), viewW, viewH / 8) Text:timeStr TextFont:15 BackgroudColor:[UIColor clearColor] TextColor:[UIColor whiteColor]];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.parkMessageView addSubview:timeLabel];
        //统计时间
        float time = ([[dic objectForKey:@"parkEnd"] floatValue] - [[dic objectForKey:@"parkStart"] floatValue]) / 1000;
        int Stime = time / 3600;
        int Mtime = (time - (Stime * 3600)) / 60;
        NSString * timeMis = [NSString stringWithFormat:@"%d小时%d分",Stime,Mtime];
        UILabel * timeMistakeLabel = [CreatUI creatLabelWithFrame:CGRectMake(0, CGRectGetMaxY(timeLabel.frame), viewW / 2, viewH / 8) Text:timeMis TextFont:15 BackgroudColor:[UIColor clearColor] TextColor:[UIColor whiteColor]];
        timeMistakeLabel.textAlignment = NSTextAlignmentCenter;
        [self.parkMessageView addSubview:timeMistakeLabel];
        //显示价位
        NSString * priceStr;
        if ([[dic objectForKey:@"priceType"] integerValue] == 1) {
            priceStr = [NSString stringWithFormat:@"每小时%.2f元",[[dic objectForKey:@"price"] floatValue]];
        }else{
            priceStr = [NSString stringWithFormat:@"每次%.2f元",[[dic objectForKey:@"price"] floatValue]];
        }
        UILabel * priceLabel = [CreatUI creatLabelWithFrame:CGRectMake(CGRectGetMaxX(timeMistakeLabel.frame), CGRectGetMaxY(timeLabel.frame), viewW / 2, viewH / 8) Text:priceStr TextFont:15 BackgroudColor:[UIColor clearColor] TextColor:[UIColor whiteColor]];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        [self.parkMessageView addSubview:priceLabel];
        //三个button
        UIButton * confirmButton = [CreatUI creatButtonWithTitle:@"确认租赁" TitleColor:[UIColor blackColor] Frame:CGRectMake(viewW / 16, CGRectGetMaxY(priceLabel.frame) + viewH / 24, viewW / 4, viewH / 6) SetMasks:YES SetCorner:5 BackgroudColor:[UIColor greenColor] BackgroudImage:nil];
        confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [confirmButton addTarget:self action:@selector(confirmButtonParkAddress) forControlEvents:UIControlEventTouchUpInside];
        [self.parkMessageView addSubview:confirmButton];
        
        UIButton * detailsButton = [CreatUI creatButtonWithTitle:@"查看详情" TitleColor:[UIColor blackColor] Frame:CGRectMake(CGRectGetMaxX(confirmButton.frame) + viewW / 16, CGRectGetMaxY(priceLabel.frame) + viewH / 24, viewW / 4, viewH / 6) SetMasks:YES SetCorner:5 BackgroudColor:[UIColor greenColor] BackgroudImage:nil];
        detailsButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [detailsButton addTarget:self action:@selector(detailsButtonParkMessage) forControlEvents:UIControlEventTouchUpInside];
        [self.parkMessageView addSubview:detailsButton];
        
        UIButton * nextButton = [CreatUI creatButtonWithTitle:@"下一个" TitleColor:[UIColor blackColor] Frame:CGRectMake(CGRectGetMaxX(detailsButton.frame) + viewW / 16, CGRectGetMaxY(priceLabel.frame) + viewH / 24, viewW / 4, viewH / 6) SetMasks:YES SetCorner:5 BackgroudColor:[UIColor greenColor] BackgroudImage:nil];
        nextButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [nextButton addTarget:self action:@selector(nextButtonParkMessage) forControlEvents:UIControlEventTouchUpInside];
        [self.parkMessageView addSubview:nextButton];
        //系统提示
        UILabel * sysTLabel = [CreatUI creatLabelWithFrame:CGRectMake(0, viewH * 7 / 8, viewW, viewH / 8) Text:@"注：最多只能接收到三个车位" TextFont:13 BackgroudColor:nil TextColor:[UIColor whiteColor]];
        sysTLabel.textAlignment = NSTextAlignmentCenter;
        [self.parkMessageView addSubview:sysTLabel];
    }else{
        [self showHint:@"系统正在为你努力匹配,请稍后"];
    }
    
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
    snLabel.text = [NSString stringWithFormat:@"订单号：%@",[priceDic objectForKey:@"sn"]];
    [self.windowView addSubview:snLabel];
    
    UILabel * amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewW / 32, CGRectGetMaxY(snLabel.frame), viewW, viewH / 6)];
    amountLabel.text = [NSString stringWithFormat:@"金额：%@",[priceDic objectForKey:@"amount"]];
    [self.windowView addSubview:amountLabel];
    
    UILabel * descLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewW / 32, CGRectGetMaxY(amountLabel.frame), viewW, viewH / 6)];
    descLabel.text = [NSString stringWithFormat:@"订单说明：%@",[priceDic objectForKey:@"desc"]];
    [self.windowView addSubview:descLabel];
    
    UILabel * createdLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewW / 32, CGRectGetMaxY(descLabel.frame), viewW, viewH / 6)];
    createdLabel.text = [NSString stringWithFormat:@"时间：%@",[NSString millisecondChangeTime:[priceDic objectForKey:@"created"]]];
    [self.windowView addSubview:createdLabel];
    
    UIButton * moneyButton = [CreatUI creatButtonWithTitle:@"选择支付方式" TitleColor:BLACK_color Frame:CGRectMake(viewW / 4, CGRectGetMaxY(createdLabel.frame) + viewH / 12, viewW / 2, viewH / 6) SetMasks:YES SetCorner:10 BackgroudColor:[UIColor greenColor] BackgroudImage:nil];
    [moneyButton addTarget:self action:@selector(moneyButtonForPayBar) forControlEvents:UIControlEventTouchUpInside];
    [self.windowView addSubview:moneyButton];
}
@end
