//
//  SettingView.m
//  CheWei
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SettingView.h"
#import "UpdatePassword.h"
#import "BindPhoneNumber.h"
@interface SettingView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SettingView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.titlesArray = @[@"修改密码",@"修改绑定手机号"];
    self.settingTableView = [[UITableView alloc]init];
    self.settingTableView.frame = CGRectMake(0, 0, WindowWidth, WindowHeight - barHeight44);
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;
    self.settingTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.settingTableView];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        UpdatePassword * passwordVC = [[UpdatePassword alloc]init];
        [self.navigationController pushViewController:passwordVC animated:YES];
    }
    if (indexPath.row == 1) {
        BindPhoneNumber * bindVC = [[BindPhoneNumber alloc]init];
        [self.navigationController pushViewController:bindVC animated:YES];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = self.titlesArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WindowHeight / 10;
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
