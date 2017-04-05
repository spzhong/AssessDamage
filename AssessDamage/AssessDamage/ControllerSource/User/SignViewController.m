//
//  SignViewController.m
//  eMDT
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 dachen. All rights reserved.
//

#import "SignViewController.h"
#import "MyUser.h"
#import "AppDelegate.h"
#import "User+CoreDataClass.h"
#import "ForgetViewController.h"
#import "Verification.h"


@interface SignViewController ()<UIActionSheetDelegate>
{
    UITextField *moblietext;
    UITextField *codetext;
    BOOL isshow;
}
@end

@implementation SignViewController


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"currentUserId"];
    isshow = YES;
    
    int y = 110;
    
    if (Iphone5Screen) {
        y = 80;
    }
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, y, ScreenWidth, ScreenHeight)];
    [self.view addSubview:bg];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 32)];
    title.text = @"用户登录";
    title.font = Font(32);
    title.textColor = RGB(53, 53, 53);
    title.textAlignment = NSTextAlignmentCenter;
    [title setBackgroundColor:[UIColor clearColor]];
    [bg addSubview:title];
    
    
    
   
    
    
    
    y = (32+40);
    moblietext =  [[UITextField alloc] initWithFrame:CGRectMake(15, y, ScreenWidth-30, 44)];
    moblietext.textColor = RGB(53, 53, 53);
    [bg addSubview:moblietext];
    moblietext.keyboardType= UIKeyboardTypeNumberPad;
    moblietext.placeholder = @"请输入手机号";
    [moblietext setBorderStyle:UITextBorderStyleRoundedRect];
    
    NSString *curPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"curPhone"];
    if(curPhone != nil){
        moblietext.text = curPhone;
    }
    
    
    y += (44+10);
    codetext = [[UITextField alloc] initWithFrame:CGRectMake(15, y, ScreenWidth-30, 44)];
    [bg addSubview:codetext];
    codetext.textColor = RGB(53, 53, 53);
    codetext.placeholder = @"请输入密码";
    codetext.secureTextEntry = YES;
    [codetext setBorderStyle:UITextBorderStyleRoundedRect];
    UIButton *seeCode = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-15-36, y + 13, 18, 18)];
    [seeCode setBackgroundImage:[UIImage imageNamed:@"eye_cloes"] forState:UIControlStateNormal];
    [bg addSubview:seeCode];
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
    
    //忘记密码
    y += 44;
    UIButton *fogetCode = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-15-70, y+10, 70, 15)];
    [bg addSubview:fogetCode];
    [fogetCode setTitleColor:RGB(68, 140, 235) forState:UIControlStateNormal];
    fogetCode.titleLabel.font = Font(14);
    [fogetCode setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [[fogetCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        ForgetViewController *foget = [[ForgetViewController alloc] init];
        foget.title = @"忘记密码";
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController pushViewController:foget animated:YES];
    }];

    //登录
    y += 44;
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, y, ScreenWidth-30, 45)];
    [leftBtn setTitle:@"登录" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setBackgroundColor:kThemeColor];
    [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //下移键盘
        [self hideKeyboardTapGesture:nil];
        //拼装数据
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
        [dic setObject:moblietext.text forKey:@"accountNum"];
        [dic setObject:codetext.text forKey:@"password"];
        
        
        
        
        //[[HTTP shared] REQUSET_DATA:data  completion:^(id rep, int code) {
            
        
                NSString *userId = @"song12";
                User *user =  (User *)[CoreData creat_coredata:@"User" withWhere_id:[NSString stringWithFormat:@"userId='%@'",userId]];
                user.userId = userId;
                user.name = @"宋";
                [CoreData save_coredata];
        
        
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"currentUserId"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //切换到主页
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kNFExchangeRootViewToMainView" object:nil];
                
                [[NSUserDefaults standardUserDefaults] setObject:moblietext.text forKey:@"curPhone"];
                
        
        
    }];
    [bg addSubview:leftBtn];
    
    //添加点击背景键盘下来
    [self addHideKeyboardTapGesture];
    
    
    title.userInteractionEnabled = YES;
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qihuanTap)];
    //[title addGestureRecognizer:tap];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addHideKeyboardTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboardTapGesture:)];
    [self.view addGestureRecognizer:tap];
}

- (IBAction)hideKeyboardTapGesture:(id)sender {
    [self.view endEditing:YES];
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
