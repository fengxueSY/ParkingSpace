//
//  OrderDetailController.m
//  CheWei
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderDetailController.h"
#import "DetailCell.h"
@interface OrderDetailController ()
@property(nonatomic,strong)NSArray * dataSource;
@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITE_color;
    
    self.dataSource = @[@"出租车位发布成功",@"刘小姐--1832498888",@"车位预定费已付",@"管理员已接受二维码",@"进库~管理员:郑师傅",@"出库~康师傅",@"已支付停车费",@"此次出租车位已结束"];
    
    self.detailTableView = [[UITableView alloc]init];
    self.detailTableView.frame  = CGRectMake(0, 0, WindowWidth, WindowHeight - 64);
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    self.detailTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.detailTableView];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cell1 = @"cell1";
    DetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cell1];
    if (cell == nil) {
        cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell1];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.font = FONT_size(15);
    cell.imageView.image = [UIImage imageNamed:@"find_dynamic"];
    cell.detailTextLabel.text = @"11:54";
    cell.detailTextLabel.textColor = BLACK_color;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return WindowHeight / 9;
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
