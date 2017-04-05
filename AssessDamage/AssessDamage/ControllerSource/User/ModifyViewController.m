//
//  ModifyViewController.m
//  eMDT
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 dachen. All rights reserved.
//

#import "ModifyViewController.h"
#import "Verification.h"

@interface ModifyViewController ()
{
    UITextField *codetext;
    BOOL isshow;
}
@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self rewriteBackButton];
    
    int y = 30;
    
    codetext = [[UITextField alloc] initWithFrame:CGRectMake(15, y, ScreenWidth-30, 44)];
    [self.view addSubview:codetext];
    codetext.textColor = RGB(53, 53, 53);
    codetext.placeholder = @"请输入密码";
    codetext.secureTextEntry = YES;
    [codetext setBorderStyle:UITextBorderStyleRoundedRect];
    UIButton *seeCode = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-15-36, y + 13, 18, 18)];
    [seeCode setBackgroundImage:[UIImage imageNamed:@"eye_cloes"] forState:UIControlStateNormal];
    [self.view addSubview:seeCode];
    [[seeCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (isshow) {
            isshow = NO;
            [seeCode setBackgroundImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateNormal];
            codetext.secureTextEntry = NO;
        }else{
            codetext.secureTextEntry = YES;
            isshow = YES;
            [seeCode setBackgroundImage:[UIImage imageNamed:@"eye_cloes"] forState:UIControlStateNormal];
        }
        
    }];

    [codetext becomeFirstResponder];
    
    
    //登录
    y += 44+25;
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, y, ScreenWidth-30, 45)];
    [leftBtn setTitle:@"修改" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setBackgroundColor:kThemeColor];
    [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.view endEditing:YES];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
        [dic setObject:self.telephone forKey:@"telephone"];
        [dic setObject:self.code forKey:@"code"];
        [dic setObject:self.smsId forKey:@"smsId"];
        [dic setObject:codetext.text forKey:@"newPwd"];
        [dic setObject:codetext.text forKey:@"renewPwd"];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
 
    }];
    [self.view addSubview:leftBtn];
    
    //添加点击背景键盘下来
    [self addHideKeyboardTapGesture];

}

- (void)addHideKeyboardTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboardTapGesture:)];
    [self.view addGestureRecognizer:tap];
}

- (IBAction)hideKeyboardTapGesture:(id)sender {
    [self.view endEditing:YES];
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
