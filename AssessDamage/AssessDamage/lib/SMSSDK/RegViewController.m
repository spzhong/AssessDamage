//
//  RegViewController.m
//  SMS_SDKDemo
//
//  Created by 掌淘科技 on 14-6-4.
//  Copyright (c) 2014年 掌淘科技. All rights reserved.
//

#import "RegViewController.h"
#import "VerifyViewController.h"
#import "SectionsViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDKCountryAndAreaCode.h>
#import <SMS_SDK/Extend/SMSSDK+ExtexdMethods.h>
#import <MOBFoundation/MOBFoundation.h>
#import "Verification.h"
#import "ErrorLog+CoreDataClass.h"



@interface RegViewController ()
{
    SMSSDKCountryAndAreaCode* _data2;
    
    NSString* _defaultCode;
    NSString* _defaultCountryName;
    NSBundle *_bundle;
    
}

@property (nonatomic, strong) NSMutableArray* areaArray;
@property (nonatomic, strong) UIButton *nextButton;


@end

@implementation RegViewController

-(void)clickLeftButton
{
    if (self.verificationCodeResult) {
        
        self.verificationCodeResult (SMSUIResponseStateCancel,nil,nil, nil);
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //不允许用户输入 国家码
    if (textField ==_areaCodeField)
    {
        [self.view endEditing:YES];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark - SecondViewControllerDelegate的方法
- (void)setSecondData:(SMSSDKCountryAndAreaCode *)data
{
    _data2 = data;
    NSLog(@"the area data：%@,%@", data.areaCode,data.countryName);
    
    self.areaCodeField.text = [NSString stringWithFormat:@"+%@",data.areaCode];
    [self.tableView reloadData];
}

-(void)nextStep
{
    NSString *msg = [Verification phone:self.telField.text];
    if ([msg length]>0) {
        //错误信息
        [DCProgressHUD showHUDText:msg];
    }else{
        NSString* str2 = [self.areaCodeField.text stringByReplacingOccurrencesOfString:@"+" withString:@""];
        [self getVerificationCodeByMethod:self.getCodeMethod phoneNumber:[Verification newPhone:self.telField.text] zone:str2];
    }
}


- (void)getVerificationCodeByMethod:(SMSGetCodeMethod)getCodeMethod phoneNumber:(NSString *)phoneNumber zone:(NSString *)zone
{
    __weak RegViewController *regViewController = self;
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumber
                                   zone:zone
                       customIdentifier:nil
                                 result:^(NSError *error)
     {
         
         [regViewController getVerificationCodeResultHandler:phoneNumber zone:zone error:error];
         
     }];
}

- (void)getVerificationCodeResultHandler:(NSString *)phoneNumber zone:(NSString *)zone error:(NSError *)error
{
    NSString *imageString = [_bundle pathForResource:@"button4" ofType:@"png"];
    self.nextButton.enabled = YES;
    [self.nextButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:imageString] forState:UIControlStateNormal];
    
    if (!error)
    {
        VerifyViewController* verify = [[VerifyViewController alloc] init];
        verify.title = @"登录";
        verify.getCodeMethod = self.getCodeMethod;
        //发送验证码成功，进行回调
        verify.verificationCodeResult = ^(enum SMSUIResponseState state,NSString *phoneNumber,NSString *zone,NSError *error){
            if (!error) {
                if (state == SMSUIResponseStateSuccess) {
                    
                    
                }
            }
        };
        [verify setPhone:phoneNumber AndAreaCode:zone];
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:verify];
        [self presentViewController:na animated:YES completion:^{}];
    }
    else
    {
        //显示错误的信息
        NSString *msg = [Verification smsCodeMsg:[NSString stringWithFormat:@"%ld",(long)error.code]];
        [DCProgressHUD showHUDText:msg];
        
        //保存记录
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
        [dic setObject:[NSString stringWithFormat:@"%ld",(long)error.code] forKey:@"resultCode"];
        [dic setObject:msg forKey:@"resultMsg"];
        [Tool saveToErrorLog:nil withPost:[NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNumber,@"phone", nil] withLog:dic  withDsc:@"调用SMSSDK获取短信验证码"];
        //保存记录
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
  
    CGFloat statusBarHeight = 0;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        statusBarHeight = 20;
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SMSSDKUI" ofType:@"bundle"];
    NSBundle *bundle = [[NSBundle alloc] initWithPath:filePath];
    _bundle = bundle;
    
    self.title = @"登录";

    
    UILabel* label = [[UILabel alloc] init];
    label.frame = CGRectMake(15,statusBarHeight, self.view.frame.size.width - 30, 50);
    label.text = @"请输入您的手机号码进行短信验证登录";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica" size:16];
    label.textColor = [UIColor darkGrayColor];
    [self.view addSubview:label];
    
    
    statusBarHeight += 10;
    
    //区域码
    UILabel *seperateLineUp = [[UILabel alloc] initWithFrame:CGRectMake(10, 50 + statusBarHeight, self.view.frame.size.width - 20, 1)];
    seperateLineUp.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:seperateLineUp];
    
    UITextField* areaCodeField = [[UITextField alloc] init];
    areaCodeField.frame = CGRectMake(10, 50 + statusBarHeight, (self.view.frame.size.width - 30)/4, 40 + statusBarHeight/4);
    areaCodeField.text = [NSString stringWithFormat:@"+86"];
    areaCodeField.textAlignment = NSTextAlignmentCenter;
    areaCodeField.font = [UIFont fontWithName:@"Helvetica" size:18];
    areaCodeField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:areaCodeField];
    
    UILabel *verticalLine = [[UILabel alloc] initWithFrame:CGRectMake(areaCodeField.frame.origin.x + areaCodeField.frame.size.width + 1, seperateLineUp.frame.origin.y +1, 1, areaCodeField.frame.size.height)];
    verticalLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:verticalLine];
    
    //
    UITextField* telField = [[UITextField alloc] init];
    telField.frame = CGRectMake(20 + (self.view.frame.size.width - 30)/4, 50 + statusBarHeight,(self.view.frame.size.width - 30)*3/4 , 40 + statusBarHeight/4);
    telField.placeholder = @"请输入你的手机号";
    telField.keyboardType = UIKeyboardTypePhonePad;
    telField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:telField];
    
    UILabel *seperateLineDown = [[UILabel alloc] initWithFrame:CGRectMake(seperateLineUp.frame.origin.x, seperateLineUp.frame.origin.y + areaCodeField.frame.size.height + 1, seperateLineUp.frame.size.width, 1)];
    seperateLineDown.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:seperateLineDown];
    
    //
    UIButton* nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    
    NSString *imageString = [bundle pathForResource:@"button4" ofType:@"png"];
    [nextBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:imageString] forState:UIControlStateNormal];
    nextBtn.frame = CGRectMake(10, seperateLineDown.origin.y+20, self.view.frame.size.width - 20, 42);
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    self.nextButton = nextBtn;
    [self.view addSubview:nextBtn];
    
    _telField = telField;
    _areaCodeField = areaCodeField;

}



@end
