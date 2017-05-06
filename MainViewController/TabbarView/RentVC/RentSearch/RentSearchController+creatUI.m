//
//  RentSearchController+creatUI.m
//  CheWei
//
//  Created by shenyang on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RentSearchController+creatUI.h"

@implementation RentSearchController (creatUI)
-(void)creatBaseUI{
    self.baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight * 2 / 3 + 10)];
    self.baseScrollView.delegate = self;
    self.baseScrollView.pagingEnabled = YES;
    self.baseScrollView.alwaysBounceVertical = NO;
    self.baseScrollView.showsHorizontalScrollIndicator = NO;
    self.baseScrollView.contentSize = CGSizeMake(WindowWidth * 2, 0);
    [self.view addSubview:self.baseScrollView];
    
    self.SearchTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, self.baseScrollView.frame.size.height)];
    self.SearchTabelView.delegate = self;
    self.SearchTabelView.dataSource = self;
    self.SearchTabelView.scrollEnabled = NO;
    self.SearchTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseScrollView addSubview:self.SearchTabelView];
    
    self.RentTabelView = [[UITableView alloc]initWithFrame:CGRectMake(WindowWidth, 0, WindowWidth, self.baseScrollView.frame.size.height)];
    self.RentTabelView.dataSource = self;
    self.RentTabelView.delegate = self;
    self.RentTabelView.scrollEnabled = NO;
    self.RentTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseScrollView addSubview:self.RentTabelView];
    
    self.addRentButton = [CreatUI creatButtonWithTitle:nil TitleColor:[UIColor blueColor] Frame:CGRectMake(WindowWidth / 6, CGRectGetMaxY(self.baseScrollView.frame) + 10, WindowWidth * 2 / 3, WindowHeight * 2 / 22) SetMasks:YES SetCorner:5 BackgroudColor:nil BackgroudImage:nil];
    [self.addRentButton addTarget:self action:@selector(addButtonOther:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addRentButton];
    self.chooseSegementControl = [[UISegmentedControl alloc]initWithItems:@[@"找车位",@"放租"]];
    if (WindowWidth >= 370) {
        self.chooseSegementControl.frame = CGRectMake(WindowWidth / 4, CGRectGetMaxY(self.addRentButton.frame) + WindowHeight / 23, WindowWidth / 2, WindowHeight / 15);
    }else{
        self.chooseSegementControl.frame = CGRectMake(WindowWidth / 4, CGRectGetMaxY(self.addRentButton.frame) + 10, WindowWidth / 2, WindowHeight / 15);
    }
    NSString * seg = [NSU_DayI defaultsRead:@"chooseSegementControlnumberOfSegments"];
    if (seg == nil) {
        [self changeRightItem:@"0"];
        self.chooseSegementControl.selectedSegmentIndex = 0;
        self.addRentButton.tag = 567000;
        [self.addRentButton setTitle:@"找其他车位" forState:UIControlStateNormal];
        [self.baseScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [NSU_DayI defaultsSave:@"0" withKey:@"chooseSegementControlnumberOfSegments"];
    }else{
        self.chooseSegementControl.selectedSegmentIndex = [seg integerValue];
        [NSU_DayI defaultsSave:seg withKey:@"chooseSegementControlnumberOfSegments"];
        if ([seg integerValue] == 0) {
            [self changeRightItem:@"0"];
            self.chooseSegementControl.selectedSegmentIndex = 0;
            [self.baseScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            self.addRentButton.tag = 567000;
            [self.addRentButton setTitle:@"找其他车位" forState:UIControlStateNormal];
        }else{
            [self changeRightItem:@"1"];
            self.chooseSegementControl.selectedSegmentIndex = 1;
            [self.baseScrollView setContentOffset:CGPointMake(WindowWidth, 0) animated:YES];
            self.addRentButton.tag = 678000;
            [self.addRentButton setTitle:@"增加其他车位" forState:UIControlStateNormal];
        }
    }
    [self.chooseSegementControl addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.chooseSegementControl];
}
#pragma mark -- 管理员界面
-(void)creatBaseUIAddendant{
    UIButton * scanButton = [CreatUI creatButtonWithTitle:@"扫码" TitleColor:BLACK_color Frame:CGRectMake(WindowWidth / 4, WindowHeight / 3, WindowWidth / 2, WindowHeight / 9) SetMasks:YES SetCorner:10 BackgroudColor:RGBcolor(220, 220, 220, 1) BackgroudImage:nil];
    [scanButton addTarget:self action:@selector(scanImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButton];
}
-(void)scanImage{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    
    reader.readerDelegate = self;
    reader.showsZBarControls = NO;
    [self setOverlayPickerView:reader];
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    [self presentViewController:reader animated:YES completion:nil];
}
#pragma mark -- 二维码扫描界面的优化
- (void)setOverlayPickerView:(ZBarReaderViewController *)reader
{
//清除原有控件
    for (UIView *temp in [reader.view subviews]) {
        for (UIButton *button in [temp subviews]) {
            if ([button isKindOfClass:[UIButton class]]) {
                [button removeFromSuperview];
            }
        }
        for (UIToolbar *toolbar in [temp subviews]) {
            if ([toolbar isKindOfClass:[UIToolbar class]]) {
                [toolbar setHidden:YES];
                [toolbar removeFromSuperview];
            }
        }
    }
    //画中间的基准线
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(WindowWidth / 6, WindowHeight / 5, WindowWidth * 4 / 6, 1)];
    lineView.backgroundColor = [UIColor redColor];
    [self lineAnimate:lineView];
    [reader.view addSubview:lineView];
    
    //最上部view
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight / 5)];
    upView.alpha = 0.3;
    upView.backgroundColor = [UIColor blackColor];
    [reader.view addSubview:upView];
    //用于说明的label
    UILabel * labIntroudction = [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame = CGRectMake(0, 20, WindowWidth, WindowHeight / 5);
    labIntroudction.numberOfLines = 0;
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.textColor = [UIColor whiteColor];
    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    [upView addSubview:labIntroudction];
    
    //左侧的view
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(upView.frame), WindowWidth / 6, WindowHeight * 2 / 5)];
    leftView.alpha = 0.3;
    leftView.backgroundColor = [UIColor blackColor];
    [reader.view addSubview:leftView];
    
    //右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(WindowWidth * 5 / 6, CGRectGetMaxY(upView.frame), WindowWidth / 6, WindowHeight * 2 / 5)];
    rightView.alpha = 0.3;
    rightView.backgroundColor = [UIColor blackColor];
    [reader.view addSubview:rightView];
    
    //底部view
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(leftView.frame), WindowWidth, WindowHeight * 2 / 5)];
    downView.alpha = 0.3;
    downView.backgroundColor = [UIColor blackColor];
    [reader.view addSubview:downView];
    
    //用于取消操作的button
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelButton.alpha = 0.4;
    [cancelButton setFrame:CGRectMake(WindowWidth / 4, WindowHeight * 4 / 5, WindowWidth / 2, WindowHeight / 7)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [cancelButton addTarget:self action:@selector(dismissOverlayView)forControlEvents:UIControlEventTouchUpInside];
    [reader.view addSubview:cancelButton];
}
-(void)dismissOverlayView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//-(void)lineAnimate:(UIView *)lineView{
//    [UIView animateWithDuration:3 animations:^{
//        self.lineView.frame = CGRectMake(WindowWidth / 6, WindowHeight * 3 / 5, WindowWidth * 4 / 6, 1);
//    }];
//    [UIView animateWithDuration:3 animations:^{
//        self.lineView.frame = CGRectMake(WindowWidth / 6, WindowHeight * 3 / 5, WindowWidth * 4 / 6, 1);
//    } completion:^(BOOL finished) {
//        self.lineView.frame = CGRectMake(WindowWidth / 6, WindowHeight / 5, WindowWidth * 4 / 6, 1);
//    }];
//}
@end
