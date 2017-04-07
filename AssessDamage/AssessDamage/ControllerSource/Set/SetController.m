//
//  SetController.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/4/5.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "SetController.h"

@interface SetController ()

@end

@implementation SetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak __typeof(self) weakSelf= self;
    [self rewriteLeftNav_title:@"取消" withBlock:^{
        [weakSelf dismissViewControllerAnimated:YES completion:NULL];
    }];
    
    
    //创建一个表
    [self configWithTable:^(UITableView *tabl) {
        
    } withSections:^NSInteger{
        return 1;
    } withSectionsInRow:^NSInteger(NSInteger section) {
        return 1;
    } withHeightForRow:^float(NSIndexPath *indexPath) {
        return 44;
    } withLoadCell:^UITableViewCell *(NSIndexPath *indexPath) {
        
        UITableViewCell *cell = (UITableViewCell *)[weakSelf.baseTableView dequeueReusableCellWithIdentifier:@"cell"];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            [cell setBackgroundColor:[UIColor whiteColor]];
        }
        
        cell.textLabel.text = @"退出";
        return cell;
    } withSelectRow:^(NSIndexPath *indexPath) {
        if (indexPath.row==0 && indexPath.section==0) {
            [weakSelf exit];
        }
    }];
}


//退出
-(void)exit{
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"currentUserId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:NULL];
    //切换到登录的页面
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNFExchangeRootViewToLoginView" object:nil];
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
