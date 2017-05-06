//
//  MessageController.m
//  CheWei
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MessageController.h"
#import "TextCell.h"
@interface MessageController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.findDatasource = [[NSMutableArray alloc]init];
    
    self.tipLabel = [[UILabel alloc]init];
    self.tipLabel.frame = CGRectMake(0, 64, WindowWidth, WindowHeight / 20);
    self.tipLabel.text = @"我常找的车位:";
    self.tipLabel.backgroundColor = [UIColor lightGrayColor];
    self.tipLabel.font = FONT_size(15);
//    [self.view addSubview:self.tipLabel];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.7448 green:1.0 blue:0.8271 alpha:1.0];
    self.baseScrollView = [[UIScrollView alloc]init];
    
    self.baseScrollView.frame = CGRectMake(0,Max_Y(self.tipLabel), WindowWidth, WindowHeight / 2);
    self.baseScrollView.backgroundColor = [UIColor whiteColor];
    self.baseScrollView.contentSize = CGSizeMake(WindowWidth * 2, WindowHeight / 2);
    self.baseScrollView.showsHorizontalScrollIndicator = NO;
    self.baseScrollView.showsVerticalScrollIndicator = NO;
    self.baseScrollView.pagingEnabled = YES;
    self.baseScrollView.bounces = NO;
    self.baseScrollView.scrollEnabled = NO;
//    [self.baseScrollView setContentOffset:CGPointMake(0, 64)];
//    [self.view addSubview:self.baseScrollView];

    
    self.findTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, WindowWidth, WindowHeight / 2) style:UITableViewStylePlain];
    self.findTableView.backgroundColor = [UIColor orangeColor];
    self.findTableView.tableFooterView = [[UIView alloc]init];
    self.findTableView.delegate = self;
    self.findTableView.dataSource = self;
    self.findTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    [self.baseScrollView addSubview:self.findTableView];
    
    self.rentTableView = [[UITableView alloc]initWithFrame:CGRectMake(WindowWidth, 0, WindowWidth, WindowHeight / 2) style:UITableViewStylePlain];
    self.rentTableView.backgroundColor = [UIColor redColor];
    self.rentTableView.tableFooterView = [[UIView alloc]init];
    self.rentTableView.delegate = self;
    self.rentTableView.dataSource = self;
    self.rentTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    [self.baseScrollView addSubview:self.rentTableView];
    
    self.typeSengment = [[UISegmentedControl alloc]initWithItems:@[@"找车位",@"放租"]];
    self.typeSengment.frame = CGRectMake(WindowWidth / 4, WindowHeight * 16 / 20, WindowWidth / 2, WindowHeight / 15);
    self.typeSengment.selectedSegmentIndex = 0;
    [self.typeSengment addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:self.typeSengment];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.frame = CGRectMake(WindowWidth / 4, Min_Y(self.typeSengment) - WindowHeight / 15 - 3, WindowWidth / 2, WindowHeight / 15);
    [self.addButton setTitle:@"找其他车位" forState:UIControlStateNormal];
    [self.addButton setTitleColor:BLACK_color forState:UIControlStateNormal];
    self.addButton.titleLabel.font = FONT_size(17);
    [self.addButton addTarget:self action:@selector(packingAction:) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:self.addButton];
    
//    [self httpsDiscoverPark];
}
-(void)packingAction:(UIButton *)sender{
    if (Equarl_String(sender.currentTitle, @"找其他车位")) {
        L1(sender.currentTitle);
    }else{
        L1(sender.currentTitle);
    }
}
-(void)chooseType:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"000");
        self.tipLabel.text = @"我常找的车位:";
        [self.addButton setTitle:@"找其他车位" forState:UIControlStateNormal];
        CGPoint pt = CGPointMake(0, 0);
        [self.baseScrollView setContentOffset:pt animated:YES];

    }
    if (sender.selectedSegmentIndex == 1) {
        L1(@"1111");
        self.tipLabel.text = @"我常放租的车位:";
        [self.addButton setTitle:@"放租其他车位" forState:UIControlStateNormal];
        CGPoint pt = CGPointMake(WindowWidth, 0);
        [self.baseScrollView setContentOffset:pt animated:YES];

    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cell1 = @"cell";
    TextCell * cell = [tableView dequeueReusableCellWithIdentifier:cell1];
    if (cell == nil) {
        cell = [[TextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
    }
    if (self.findDatasource.count > 0 ) {
        NSDictionary * dic = self.findDatasource[indexPath.row];
        cell.addressLabel.text = Format_String(dic[@"parkingAddr"]);
        cell.addressLabel.backgroundColor = CLEAR_color;
        cell.addressLabel.textColor = BLACK_color;
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.findDatasource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WindowHeight  / 6;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)httpsDiscoverPark{
    //    [self showHudInView:self.view hint:@"数据加载中..."];
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager GET:[NSString searchOftenPark:self.baseInfo.myUid httpsUrl:self.baseInfo.myURL] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hideHud];
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
//        NSLog(@"di  ===== %@",dic);
        if (Equarl_stringCode0(Format_String(dic[@"code"]))) {
            self.findDatasource = [[NSMutableArray alloc]initWithArray:dic[@"data"]];
            [self.findTableView reloadData];
        }else{
            [self showHint:@"获取找车位信息失败!"];
        }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHint:@"获取找车位信息失败!"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)viewDidAppear:(BOOL)animated{
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
