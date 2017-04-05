//
//  UIViewController+View.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/26.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "UIViewController+View.h"
#import "SlideView.h"
#import "MyUserController.h"
#import "SetController.h"
#import "AboutController.h"
#import "MessageCenterController.h"
#import "HistoryDamageController.h"

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
    
    //创建左边滑动的栏目
    [self leftViewSet];
     
}
 
- (void)leftViewSet
{
    CGFloat leftWidth = ScreenWidth-80;
    SlideView *leftView = [[SlideView alloc]initWithFrame:CGRectMake(-leftWidth-5, 0, leftWidth, ScreenHeight) superView:AppWindow];
    [AppWindow addSubview:leftView];
    [leftView handle:^(NSInteger indexRow) {
        [leftView leftViewShow:NO];
        
        if (indexRow==-1) {//用户
            MyUserController *my = [[MyUserController alloc] init];
            my.title = @"用户信息";
            UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:my];
            [self presentViewController:na animated:YES completion:NULL];
        }else if (indexRow==-2) {//关于
            AboutController *about = [[AboutController alloc] init];
            about.title = @"关于";
            UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:about];
            [self presentViewController:na animated:YES completion:NULL];
        }else if (indexRow==0) {//历史估损单
            HistoryDamageController *history = [[HistoryDamageController alloc] init];
            history.title = @"历史估损单";
            [self.navigationController pushViewController:history animated:YES];
        }else if (indexRow==1) {//消息中心
            MessageCenterController *msg = [[MessageCenterController alloc] init];
            msg.title = @"消息中心";
            UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:msg];
            [self presentViewController:na animated:YES completion:NULL];
        }else if (indexRow==2) {//设置
            SetController *set = [[SetController alloc] init];
            set.title = @"设置";
            UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:set];
            [self presentViewController:na animated:YES completion:NULL];
        }
    }];
    leftView.tag = 1988;
    
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
    
}


@end
