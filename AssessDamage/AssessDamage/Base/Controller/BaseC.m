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
        touch();
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
        touch();
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)dealloc{
    
}

@end
