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
    [self rewriteLeftNav_title:@"取消" withBlock:^{
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    
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