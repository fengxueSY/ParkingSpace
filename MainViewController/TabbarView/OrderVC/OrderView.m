//
//  OrderView.m
//  CheWei
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderView.h"
#import "NewsView.h"
#import "MenuView.h"
#import "OrderView+Views.h"
#import "OrderCell.h"
#import "OrderDetailController.h"
@interface OrderView (){
    
}
@end

@implementation OrderView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title = @"订单信息";
    self.view.backgroundColor = [UIColor colorWithRed:0.318 green:0.8745 blue:0.9987 alpha:1.0];
    
    self.findDatasource = [[NSMutableArray alloc]init];
    self.rentDatasource = [[NSMutableArray alloc]init];
    
    [self baseOrderViews];
    [self.baseSegment addTarget:self action:@selector(chooseTypes:) forControlEvents:UIControlEventValueChanged];
    [self findPacking:@"1"];
    [self rentPacking:@"1"];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.baseScrollView) {
        CGPoint offset = scrollView.contentOffset;
        CGRect bounds = scrollView.frame;
        double p = offset.x / bounds.size.width;
        if (p <= 0 ){
            self.baseSegment.selectedSegmentIndex = 0;
            CGPoint pt = CGPointMake(0, 0);
            [self.baseScrollView setContentOffset:pt animated:YES];
        }else if (p >= 1 ){
            self.baseSegment.selectedSegmentIndex = 1;
            CGPoint pt = CGPointMake(WindowWidth, 0);
            [self.baseScrollView setContentOffset:pt animated:YES];
        }
    }
}

-(void)chooseTypes:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0) {
        CGPoint pt = CGPointMake(0, 0);
        [self.baseScrollView setContentOffset:pt animated:YES];
    }else if (segment.selectedSegmentIndex == 1){
        CGPoint pt = CGPointMake(WindowWidth, 0);
        [self.baseScrollView setContentOffset:pt animated:YES];
    }
}
#pragma mark -- 找车位
-(void)operateAction1:(UIButton *)sender{
      N1(sender.tag - 50000);
}
-(void)detailAction1:(UIButton *)sender{
     N1(sender.tag - 60000);
    OrderDetailController * detailVC = [[OrderDetailController alloc]init];
    detailVC.title = @"订单状态";
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark -- 放租
-(void)operateAction2:(UIButton *)sender{
    N1(sender.tag - 70000);
}
-(void)detailAction2:(UIButton *)sender{
    N1(sender.tag - 80000);
}
#pragma mark -- tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cell1 = @"cell";
    OrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cell1];
    if (cell == nil) {
        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        //需要把model的数据传到自定义的cell 里面 这样创建的cell就包含数据!
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView == self.findTableView) {
        cell.orderNumberLabel.text = @"订单号:P124512312 --- 月报卡";
        cell.orderAddressLabel.text = @"华标广场地下车库 -- 08号";
        cell.timeLabel.text = @"2016/5/4 10:23~13:23(3个小时)";
        cell.userLabel.text = @"刘先生 -- 18680521721";
        cell.statusLabel.text = @"停车中 - 一个小时";
        cell.priceLabel.text = @"💰30元/次";
        cell.tipsLabel.text = @"进行中";
        
        cell.operateButton.tag = indexPath.row + 50000;
        [cell.operateButton addTarget:self action:@selector(operateAction1:) forControlEvents:UIControlEventTouchDown];

        cell.detailButton.tag = indexPath.row + 60000;
        [cell.detailButton addTarget:self action:@selector(detailAction1:) forControlEvents:UIControlEventTouchDown];
    }else{
        cell.textLabel.text = @"出租的车位!";
        cell.operateButton.tag = indexPath.row + 70000;
        [cell.operateButton addTarget:self action:@selector(operateAction2:) forControlEvents:UIControlEventTouchDown];
        
        cell.detailButton.tag = indexPath.row + 80000;
        [cell.detailButton addTarget:self action:@selector(detailAction2:) forControlEvents:UIControlEventTouchDown];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WindowHeight / 5;
}
#pragma mark -- HTTPS--出租车位
-(void)rentPacking:(NSString *)page{
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_XML:self.baseInfo.myToken];
    [manager GET:[NSString stringWithFormat:@"%@/api/lessor/%@/park_order/p/%@",self.baseInfo.myURL,self.baseInfo.myUid,@"1"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        L1(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        L1(error);
    }];

}
///api/lessee/{uid}/park_order/p/{page}
#pragma mark -- HTTPS 找到车位
-(void)findPacking:(NSString *)page{
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_XML:self.baseInfo.myToken];
    [manager GET:[NSString stringWithFormat:@"%@/api/lessee/%@/park_order/p/%@",self.baseInfo.myURL,self.baseInfo.myUid,@"1"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        L1(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        L1(error);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
