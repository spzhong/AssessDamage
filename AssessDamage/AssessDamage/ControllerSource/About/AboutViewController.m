//
//  AboutViewController.m
//  DGroupBusiness
//
//  Created by shichuang on 16/2/20.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "AboutViewController.h"
//#import "ConditionsDetailVC.h"

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *appIcon;

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"关于";
    [self.appIcon setBorderOnViewCornerRadius:10];
    _labelVersions.text = [NSString stringWithFormat:@"v%@",AppVersion];
}

//跳转服务条款、隐私政策页面
- (IBAction)pushConditionsDetailVC:(UIButton *) sender
{
//    ConditionsDetailVC *vc = [[ConditionsDetailVC alloc] init];
//    if (sender.tag == 0) {
//        vc.title = @"服务条款";
//    }else
//    {
//        vc.title = @"隐私政策";
//    }
//    [self.navigationController pushViewController:vc animated:YES];
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
