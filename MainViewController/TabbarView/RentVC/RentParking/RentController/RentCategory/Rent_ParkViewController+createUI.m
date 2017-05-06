//
//  Rent_ParkViewController+createUI.m
//  CheWei
//
//  Created by shenyang on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Rent_ParkViewController+createUI.h"

@implementation Rent_ParkViewController (createUI)
//创建基础的ui
-(void)creatBaseUI:(CGFloat)tabH Str:(NSString *)reSt{
    self.messageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, tabH)];
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    if ([reSt integerValue] == 9) {
        self.messageTableView.scrollEnabled = YES;
    }else{
        self.messageTableView.scrollEnabled = NO;
    }
//    self.messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.messageTableView];
    CGRect rect1;
    CGRect rect2;
    NSString * publishS;
    NSString * saveS;
    if ([reSt integerValue] == 3) {
        rect1 = CGRectMake(WindowWidth / 3, CGRectGetMaxY(self.messageTableView.frame) + 10, WindowWidth / 3, WindowHeight / 14);
        rect2 = CGRectMake(0, 0, 0, 0);
        publishS = @"发布车位";
        self.publishBu.backgroundColor = [UIColor redColor];
        saveS = nil;
    }else if ([reSt integerValue] == 7){
        rect1 = CGRectMake(WindowWidth / 3, CGRectGetMaxY(self.messageTableView.frame) + 10, WindowWidth / 3, WindowHeight / 14);
        rect2 = CGRectMake(WindowWidth / 3, CGRectGetMaxY(self.messageTableView.frame) + 10, WindowWidth / 3, WindowHeight / 14);
        if ([self.spaceDic objectForKey:@"isFrequent"]) {
            if ([[self.spaceDic objectForKey:@"isFrequent"] intValue] == 0) {
                publishS = @"设为常租放车位";
            }else{
                publishS = @"取消设置";
            }
        }else{
            publishS = @"设为常租放车位";
        }
        saveS = @"保存车位";
    }else{
        rect1 = CGRectMake(WindowWidth / 9, CGRectGetMaxY(self.messageTableView.frame) + 10, WindowWidth / 3, WindowHeight / 14);
        rect2 = CGRectMake(WindowWidth * 5 / 9, CGRectGetMaxY(self.messageTableView.frame) + 10, WindowWidth / 3, WindowHeight / 14);
        publishS = @"设为常租放车位";
        saveS = @"保存并发布车位";
    }
    self.publishBu = [CreatUI creatButtonWithTitle:publishS TitleColor:BLACK_color Frame:rect1 SetMasks:YES SetCorner:5 BackgroudColor:nil BackgroudImage:nil];
    self.publishBu.titleLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"16"] floatValue]];
    if ([self.spaceDic objectForKey:@"isFrequent"]) {
        if ([[self.spaceDic objectForKey:@"isFrequent"] intValue] == 0) {
            self.publishBu.backgroundColor = RGBcolor(240, 240, 240, 1);
        }else{
            self.publishBu.backgroundColor = [UIColor redColor];
        }
    }else{
        self.publishBu.backgroundColor = RGBcolor(240, 240, 240, 1);
    }
    [self.publishBu addTarget:self action:@selector(publishPark) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.publishBu];
    UIButton * saveBu = [CreatUI creatButtonWithTitle:saveS TitleColor:BLACK_color Frame:rect2 SetMasks:YES SetCorner:5 BackgroudColor:RGBcolor(240, 240, 240, 1) BackgroudImage:nil];
    saveBu.titleLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"15"] floatValue]];
    [saveBu addTarget:self action:@selector(savePark) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBu];
}
-(UIView *)creatIndexOne:(CGRect)rect{
    UIView * _cellView = [[UIView alloc]initWithFrame:rect];
    float buW = _cellView.frame.size.width;
    float buH = _cellView.frame.size.height;
    self.packTypeImageView0 = [[UIImageView alloc]initWithFrame:CGRectMake(buW / 50, buH / 4, buW * 3 / 50, buH / 2)];
    [_cellView addSubview:self.packTypeImageView0];
    
    UIButton * button1 = [CreatUI creatButtonWithTitle:@"月保卡" TitleColor:GRAY_color Frame:CGRectMake(buW / 10, 0, buW / 4, buH) SetMasks:YES SetCorner:2 BackgroudColor:[UIColor clearColor] BackgroudImage:nil];
    button1.titleLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"16"] floatValue]];
    button1.tag = 1200000;
    [button1 addTarget:self action:@selector(parkTypeNumber:) forControlEvents:UIControlEventTouchUpInside];
    [_cellView addSubview:button1];
    
    self.packTypeImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button1.frame) + buW / 50, buH / 4, buW * 3 / 50 , buH / 2)];
    [_cellView addSubview:self.packTypeImageView1];

    UIButton * button2 = [CreatUI creatButtonWithTitle:@"临时卡" TitleColor:GRAY_color Frame:CGRectMake(CGRectGetMaxX(button1.frame) + buW / 10, 0, buW / 4, buH) SetMasks:YES SetCorner:2 BackgroudColor:[UIColor clearColor] BackgroudImage:nil];
    button2.tag = 1200001;
    button2.titleLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"16"] floatValue]];
    [button2 addTarget:self action:@selector(parkTypeNumber:) forControlEvents:UIControlEventTouchUpInside];
    [_cellView addSubview:button2];
    if ([self.spaceDic objectForKey:@"spaceType"]) {
        if ([[self.spaceDic objectForKey:@"spaceType"] intValue] == 0) {
            self.packTypeImageView0.backgroundColor = [UIColor clearColor];
            self.packTypeImageView1.backgroundColor = [UIColor redColor];
        }else{
            self.packTypeImageView0.backgroundColor = [UIColor redColor];
            self.packTypeImageView1.backgroundColor = [UIColor clearColor];
        }
    }else{
        self.packTypeImageView0.backgroundColor = [UIColor redColor];
        self.packTypeImageView1.backgroundColor = [UIColor clearColor];
    }

    return _cellView;
}
-(void)parkTypeNumber:(UIButton *)sender{
    if (sender.tag == 1200000) {
        //月保卡
        self.packTypeImageView0.backgroundColor = [UIColor redColor];
        self.packTypeImageView1.backgroundColor = [UIColor clearColor];
        self.packType = @"0";
    }else{
        //临时卡
        self.packType = @"1";
        self.packTypeImageView1.backgroundColor = [UIColor redColor];
        self.packTypeImageView0.backgroundColor = [UIColor clearColor];
    }
}
//出租价格
-(UILabel *)prace_park:(CGRect)rect{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelPraceTap:)];
    UILabel * label = [CreatUI creatLabelWithFrame:rect Text:@"点击选择收费方式" TextFont:[[NSString fontForDifferentTextSize:@"15"] floatValue] BackgroudColor:[UIColor clearColor] TextColor:BLACK_color];
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    label.tag = 1100000;
    [label addGestureRecognizer:tap];
    return label;
}
//出租时间
-(UIView *)time_park:(CGRect)rect StartTime:(UILabel *)startLabel EndTime:(UILabel *)endLabel{
    UIView * viewTime = [[UIView alloc]initWithFrame:rect];
    viewTime.userInteractionEnabled = YES;
    UITapGestureRecognizer * timeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelPraceTap:)];
    UITapGestureRecognizer * startTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelPraceTap:)];
    startLabel.frame = CGRectMake(0, 0, viewTime.frame.size.width * 4 / 9, viewTime.frame.size.height);
    startLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"15"] floatValue]];
    startLabel.adjustsFontSizeToFitWidth = YES;
    startLabel.minimumScaleFactor = 0.6;
    startLabel.userInteractionEnabled = YES;
    startLabel.textAlignment = NSTextAlignmentRight;
    startLabel.tag = 1100001;
    [startLabel addGestureRecognizer:startTap];
    [viewTime addSubview:startLabel];
    UILabel * comLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startLabel.frame), 0, viewTime.frame.size.width / 9 ,  viewTime.frame.size.height)];
    comLabel.textAlignment = NSTextAlignmentCenter;
    comLabel.text = @"~";
    [viewTime addSubview:comLabel];
    endLabel.frame = CGRectMake(CGRectGetMaxX(comLabel.frame), 0,  viewTime.frame.size.width * 4 / 9,  viewTime.frame.size.height);
    endLabel.adjustsFontSizeToFitWidth = YES;
    endLabel.minimumScaleFactor = 0.6;
    endLabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"15"] floatValue]];
    endLabel.textAlignment = NSTextAlignmentLeft;
    endLabel.userInteractionEnabled = YES;
    endLabel.tag = 1100002;
    [endLabel addGestureRecognizer:timeTap];
    [viewTime addSubview:endLabel];
    return viewTime;
}
//出租车位的照片
-(UIView *)photos_park:(CGRect)rect{
    UIView * photoView = [[UIView alloc]initWithFrame:rect];
    float pH = photoView.frame.size.height;
    float pW = photoView.frame.size.width;
    self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, pW / 4, pH)];
    self.imageView1.userInteractionEnabled = YES;
    self.imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame) + 10, 0, pW / 4, pH)];
    self.imageView2.userInteractionEnabled = YES;
    self.imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView2.frame) + 10, 0, pW / 4, pH)];
    self.imageView3.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * imageTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    UITapGestureRecognizer * imageTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    UITapGestureRecognizer * imageTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    self.imageView1.tag = 1300001;
    [self.imageView1 addGestureRecognizer:imageTap1];
    self.imageView2.tag = 1300002;
    [self.imageView2 addGestureRecognizer:imageTap2];
    self.imageView3.tag = 1300003;
    [self.imageView3 addGestureRecognizer:imageTap3];
    [photoView addSubview:self.imageView1];
    [photoView addSubview:self.imageView2];
    [photoView addSubview:self.imageView3];
    
    self.imageView1.backgroundColor = [UIColor grayColor];
    self.imageView2.backgroundColor = [UIColor yellowColor];
    self.imageView3.backgroundColor = [UIColor brownColor];
    return photoView;
}
//填写出租车位的各项信息
-(UITextField *)writeInformation_park:(CGRect)rect{
    UITextField *   _textField = [[UITextField alloc]initWithFrame:rect];
    _textField.placeholder = @"看看里面的内容";
    _textField.delegate = self;
    _textField.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"15"] floatValue]];
    [_textField setBorderStyle:UITextBorderStyleNone];
    return _textField;
}
-(void)labelPraceTap:(UITapGestureRecognizer *)tap{
    if (tap.view.tag == 1100000) {
        NSArray * array = @[@"每小时：",@"每次："];
        self.pickView = [[ZHPickView alloc]initPickviewWithArray:array isHaveNavControler:NO];
        self.pickView.delegate = self;
        self.pickView.tag = 1100000;
        [self.pickView show];
    }
    if (tap.view.tag == 1100001) {
        NSDate * date = [NSDate date];
        self.pickView = [[ZHPickView alloc]initDatePickWithDate:date datePickerMode:UIDatePickerModeDateAndTime isHaveNavControler:NO];
        self.pickView.tag = 1100001;
        self.pickView.delegate = self;
        [self.pickView show];
    }
    if (tap.view.tag == 1100002) {
        NSDate * date = [NSDate date];
        self.pickView = [[ZHPickView alloc]initDatePickWithDate:date datePickerMode:UIDatePickerModeDateAndTime isHaveNavControler:NO];
        self.pickView.tag = 1100002;
        self.pickView.delegate = self;
        [self.pickView show];
    }
}
-(void)imageTap:(UITapGestureRecognizer *)tap{
    self.imageStr = [NSString stringWithFormat:@"%ld",tap.view.tag];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        //        TTAlert1(@"手机不允许使用摄像头", self.view);
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if ([self.imageStr integerValue] == 1300001) {
        self.imageView1.image = image;
    }
    if ([self.imageStr integerValue] == 1300002) {
        self.imageView2.image = image;
    }
    if ([self.imageStr integerValue] == 1300003) {
        self.imageView3.image = image;
    }
    
}

@end
