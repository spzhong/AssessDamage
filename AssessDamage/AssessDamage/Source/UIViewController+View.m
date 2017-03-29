//
//  UIViewController+View.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/26.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "UIViewController+View.h"

@implementation UIViewController (View)

-(void)iniLoadView{
    //头部的信息
    UIScrollView *head = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    head.contentSize = CGSizeMake(ScreenWidth*3, 200);
    head.pagingEnabled = YES;
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    [view1 setBackgroundColor:[UIColor redColor]];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, 200)];
    [view2 setBackgroundColor:[UIColor greenColor]];
    
    [head addSubview:view1];
    [head addSubview:view2];
    [self.view addSubview:head];

    //创建ITEM
    [self createItem];
     
}

-(void)createItem{
    
    float y = 210;
    float w = (ScreenWidth-40)/3;
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but setTitle:@"创建定损单" forState:UIControlStateNormal];
    but.frame = CGRectMake(10, y, w, w);
    [but setBackgroundColor:[UIColor redColor]];
    [[but rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
      
    }];
    [self.view addSubview:but];
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but1 setTitle:@"修改定损单" forState:UIControlStateNormal];
    but1.frame = CGRectMake(20+w, y, w, w);
    [but1 setBackgroundColor:[UIColor redColor]];
    [[but1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    [self.view addSubview:but1];
    
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but2 setTitle:@"分享定损单" forState:UIControlStateNormal];
    but2.frame = CGRectMake(30+2*w, y, w, w);
    [but2 setBackgroundColor:[UIColor redColor]];
    [[but2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    [self.view addSubview:but2];
    
    
    y += w+10;
    UIButton *but3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but3 setTitle:@"历史定损单" forState:UIControlStateNormal];
    but3.frame = CGRectMake(10, y, w, w);
    [but3 setBackgroundColor:[UIColor redColor]];
    [[but3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    [self.view addSubview:but3];
    
}


@end
