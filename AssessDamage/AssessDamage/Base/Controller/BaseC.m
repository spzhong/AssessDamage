//
//  BaseC.m
//  AssessDamage
//
//  Created by qj0714 on 17/3/19.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "BaseC.h"

@interface BaseC ()

@end

@implementation BaseC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rewriteBackButton;
{
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 53, 22)];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imgArrow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 22)];
    imgArrow.image = [UIImage imageNamed:@"back"];
    [leftBtn addSubview:imgArrow];
    UILabel *labBack = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 40, 22)];
    labBack.text = @"返回";
    labBack.textColor = [UIColor whiteColor];
    labBack.font = Font(17);
    labBack.textAlignment = NSTextAlignmentRight;
    [leftBtn addSubview:labBack];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = backButton;
    
}

//点击导航右边的按钮
-(void)rewriteRightNav_title:(NSString *)title withBlock:(void (^)())touch{
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 22)];
    [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            touch();
        });
    }];
    UILabel *labBack = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 22)];
    labBack.text = title;
    labBack.textColor = [UIColor whiteColor];
    labBack.font = [UIFont systemFontOfSize:17];
    labBack.textAlignment = NSTextAlignmentRight;
    [leftBtn addSubview:labBack];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
}


//点击导航右边的按钮
-(void)rewriteLeftNav_title:(NSString *)title withBlock:(void (^)())touch{
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,35, 22)];
    [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            touch();
        });
    }];
    UILabel *labBack = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 22)];
    labBack.text = title;
    labBack.textColor = [UIColor whiteColor];
    labBack.font = [UIFont systemFontOfSize:17];
    labBack.textAlignment = NSTextAlignmentRight;
    [leftBtn addSubview:labBack];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = rightButton;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BaseV *)defaultModel{
    return self.dataArray.firstObject;
}



/**
 *  返回pop上几层的
 *
 *  @param num 默认是1，返回上一层
 */
-(void)poplastControllerwithNum:(int)num {
    NSArray *arrayview = self.navigationController.viewControllers;
    if (num < 1 || num > arrayview.count) {
        return;
    }
    NSInteger start = [arrayview count] -num-1;
    if (start==0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        UIViewController *view = arrayview[[arrayview count] -num-1];
        [self.navigationController popToViewController:view animated:YES];
    }
}

//删除上一个controller
-(void)deleteLastViewController{
    NSArray *arrayview = self.navigationController.viewControllers;
    if (arrayview.count>2) {
        NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:0];
        for (int  i =0; i < arrayview.count; i++) {
            if (i == arrayview.count-2) {
                continue;
            }
            [newArray addObject:arrayview[i]];
        }
        self.navigationController.viewControllers = newArray;
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc{
    NSLog(@"\n\n\n-----------%@dealloc-----------\n\n\n",self.title);
    
}

@end
