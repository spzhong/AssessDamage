//
//  ViewController.m
//  AssessDamage
//
//  Created by qj0714 on 17/3/19.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "ViewController.h"
#import "MyUser.h"
#import "UIViewController+View.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"定损";

    MyUser *my = [[MyUser alloc] init];
    //获取数据
    [my getData:@"hroror/qwwq" withPostDic:nil isReadFromCache:NO withBlock:^(BOOL success, id rep) {
    }];
    
    [self iniLoadView];
    
    [self rewriteLeftNav_title:@"用户" withBlock:^{
        
    }];
    [self rewriteRightNav_title:@"通知" withBlock:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//估损
-(void)lostdamage{
 
    //品牌   本田
    //车型    艾力绅
    //车价格区间 25<x<30
    
    //鹏峰4s店
    
    //项目
    /*
        1拆装     前保险杠皮
        2更换     燃油箱
        3钣金（中）后侧围
        4喷漆     举升门
        5喷漆     尾门
        6喷漆     后围板
     */
    
    
    
    
    
}




@end
