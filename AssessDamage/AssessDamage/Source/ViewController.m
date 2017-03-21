//
//  ViewController.m
//  AssessDamage
//
//  Created by qj0714 on 17/3/19.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "ViewController.h"
#import "MyUser.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MyUser *my = [[MyUser alloc] init];
    //获取数据
    [my getData:@"hroror/qwwq" withPostDic:nil isReadFromCache:NO withBlock:^(BOOL success, id rep) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
