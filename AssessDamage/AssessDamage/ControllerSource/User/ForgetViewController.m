//
//  ForgetViewController.m
//  eMDT
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 dachen. All rights reserved.
//

#import "ForgetViewController.h"
#import "NSTimer+PauseTimerEMDT.h"
#import "ModifyViewController.h"
#import "Verification.h"
#import "JSMSSDK.h"


@interface ForgetViewController ()
{
    NSString *smsId;
}
@property (retain, nonatomic)   UITextField *userTextField;
@property (retain, nonatomic)   UITextField *validCodeTextfield;
@property (retain, nonatomic)   UITextField *passwdTextField;
@property (retain, nonatomic)   UITextField *passwdTextField2;
@property (retain, nonatomic)   UIButton *commitButton;
@property (retain, nonatomic)   UIView *downCountBGView;
@property (retain, nonatomic)   UILabel *secondLabel;
@property (retain, nonatomic)   UIButton *secondButton;
@property (nonatomic, strong) UIButton *btnSound;
@property (nonatomic, strong) UIView *viewLine;


@property (nonatomic,retain) UIButton *getMsgCode;
@property (nonatomic, strong) NSTimer *getValidateCodeTimer;
@property (nonatomic, strong) NSDate *getValidateCodeTimerStopDate;


@end

@implementation ForgetViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    //self.navigationController.navigationBar.hidden = YES;
}


-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self addHideKeyboardTapGesture];
 
    
    [self rewriteBackButton];
    
    
    int allH = 30 ;
    
    //输入框
    self.userTextField  = [[UITextField alloc] initWithFrame:CGRectMake(15, allH, ScreenWidth-30, 44)];
    [self.view addSubview:self.userTextField];
    self.userTextField.font = Font(15);
    self.userTextField.placeholder = @"请输入手机号";
    self.userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userTextField.autocapitalizationType = UITextAutocorrectionTypeNo;
    self.userTextField.keyboardType= UIKeyboardTypeNumberPad;
    [self.userTextField setBorderStyle:UITextBorderStyleRoundedRect];
    
    
    self.validCodeTextfield  = [[UITextField alloc] initWithFrame:CGRectMake(15, allH+44+10, ScreenWidth-30, 44)];
    [self.view addSubview:self.validCodeTextfield];
    self.validCodeTextfield.font = Font(15);
    self.validCodeTextfield.placeholder = @"请输入验证码";
    self.validCodeTextfield.autocapitalizationType = UITextAutocorrectionTypeNo;
    self.validCodeTextfield.keyboardType= UIKeyboardTypeNumberPad;
    [self.validCodeTextfield setBorderStyle:UITextBorderStyleRoundedRect];
    
    
    //增加一个按钮-获取动态验证码
    
    UIView *fen = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-140, 10, 1, 24)];
    [fen setBackgroundColor:RGB(220, 224, 225)];
    [self.validCodeTextfield addSubview:fen];
    
    self.secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.secondButton.frame = CGRectMake(ScreenWidth-120,  allH+44+12, 100, 40);
    [self.secondButton setTitleColor:RGB(53,74,83) forState:UIControlStateNormal];
    [self.secondButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.secondButton.titleLabel.font = Font(15);
    [self.secondButton addTarget:self action:@selector(getValidCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.secondButton];
    
    
    
    allH += 88 + 40;
    
    UIButton *registerBut = [[UIButton alloc] initWithFrame:CGRectMake(15, allH, ScreenWidth-30, 44)];
    [registerBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBut setTitle:@"下一步" forState:UIControlStateNormal];
    [registerBut setBackgroundColor:kThemeColor];
    registerBut.titleLabel.font = Font(18);
    [registerBut addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBut];
    registerBut.layer.cornerRadius = 5;
    registerBut.layer.masksToBounds = YES;
    
    
    
    UILabel *labelT = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-100, registerBut.frame.origin.y + 64, 100, 20)];
    labelT.textColor = RGB(53,74,83);
    labelT.backgroundColor = [UIColor clearColor];
    labelT.font = [UIFont systemFontOfSize:14];
    labelT.text = @"收不到验证码？";
    [labelT sizeToFit];
    //[self.view addSubview:labelT];
    
    self.btnSound = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnSound.frame = CGRectMake(ScreenWidth/2, registerBut.frame.origin.y + 58, 100, 20);
    self.btnSound.tag = 100;
    self.btnSound.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btnSound setTitle:@"试试语音获取" forState:UIControlStateNormal];
    [self.btnSound setTitleColor:RGB(68, 140, 235) forState:UIControlStateNormal];
    [self.btnSound addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSound sizeToFit];
    self.btnSound.clipsToBounds = YES;
    //[self.view addSubview:self.btnSound];
    
    
    
     
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string length] == 0)return YES;
    
    if (textField.tag == 100) {
        if (self.validCodeTextfield.text.length == 0) return YES;
        NSInteger existedLength = self.validCodeTextfield.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 6) return NO;
        
    }else if (textField.tag == 101) {
        
        //        //        if (self.passwdTextField.text.length == 0) return YES;
        //        NSInteger existedLength = self.passwdTextField.text.length;
        //        NSInteger selectedLength = range.length;
        //        NSInteger replaceLength = string.length;
        //        if (existedLength - selectedLength + replaceLength > 20) return NO;
        //
        //        NSCharacterSet *cs;
        //
        //        cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
        //
        //
        //        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
        //
        //
        //        BOOL canChange = [string isEqualToString:filtered];
        //
        
        return YES;
        
        
    }
    
    return YES;
}

- (void)addHideKeyboardTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboardTapGesture:)];
    [self.view addGestureRecognizer:tap];
}

- (IBAction)hideKeyboardTapGesture:(id)sender {
    [self.view endEditing:YES];
}


#pragma mark - Action

- (IBAction)commitBtnClick:(id)sender {
    [self.view endEditing:YES];
    
//    if (!StringNotEmpty(self.userTextField.text)) {
//        [self showHUDText:@"请输入手机号"];return;
//    }
//    if (![self validateMobile:self.userTextField.text]) {
//        [self showHUDText:@"请输入正确的手机号"];
//        return;
//    }
//    if (!StringNotEmpty(self.validCodeTextfield.text)) {
//        [self showHUDText:@"请输入验证码"];
//        return;
//    }
//    if (!StringNotEmpty(smsId)) {
//        [self showHUDText:@"请获取短信验证码"];
//        return;
//    }
    
    
    ModifyViewController *modify = [[ModifyViewController alloc] init];
    modify.title = @"重置密码";
    modify.code = self.validCodeTextfield.text;
    modify.smsId = smsId;
    modify.telephone = self.userTextField.text;
    [self.navigationController pushViewController:modify animated:YES];
}

- (IBAction)getValidCodeClick:(id)sender {
    [self.view endEditing:YES];
    
    
    NSString *msg = [Verification phone:self.userTextField.text];
    if (msg.length>0) {
        
        return;
    }
    //获取验证码
    [JSMSSDK getVerificationCodeWithPhoneNumber:self.userTextField.text andTemplateID:@"1" completionHandler:^(id resultObject, NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功！");
        }else{
            NSLog(@"获取验证码失败！");
        }
    }];
    
    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
//    [dic setObject:self.userTextField.text forKey:@"telephone"];
//    [dic setObject:@"1" forKey:@"type"];
//    RequestData *data = [BoolPostData smsgetCode_boolPostData:dic];
//    if ([data booPostErorMsg:self]) {
//        return;
//    }
//    [self showHUDLoading];
//    [[HTTP shared] REQUSET_DATA:data  completion:^(id rep, int code) {
//        [self hideHUDView];
//        
//        if (code == 1) {
//            
//            smsId = [rep[@"smsId"] mutableCopy];
//            [self startGetValidateTimer];
//            [self showHUDText:@"短信已发送，请注意查收"];
//            
//        }else{
//            [self showHUDText:rep];
//        }
//    }];
    
    
}

#pragma mark - 按钮事件

- (void)btnClick:(UIButton *)btn
{
    // 语音验证码
    if (btn.tag == 100)
    {
        [self getSondYZM];
    }
}

#pragma mark - 获取验证码倒计时timer
- (void)startGetValidateTimer
{
    //self.secondButton.hidden = YES;
    //self.secondLabel.hidden = NO;
    
    if (!_getValidateCodeTimer)
    {
        _getValidateCodeTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(getValidateCodeTimerFiredRefreshTime:) userInfo:nil repeats:YES];
        [_getValidateCodeTimer setFireDate:[NSDate date]];
        [_getValidateCodeTimer pauseTimer];
    }else{}
    
    _getValidateCodeTimerStopDate = [NSDate dateWithTimeIntervalSinceNow:120];
    [_getValidateCodeTimer resumeTimer];
    
    self.secondButton.userInteractionEnabled = NO;
}

- (void)stopGetValidateTimer
{
    if (_getValidateCodeTimer)
    {
        [_getValidateCodeTimer pauseTimer];
    }else{}
    
    [self.secondButton setTitle:@"重新获取" forState:UIControlStateNormal];
    self.secondButton.userInteractionEnabled = YES;
}

- (void)getValidateCodeTimerFiredRefreshTime:(NSTimer *)timer
{
    NSInteger iLeftSecond = 0;
    if (_getValidateCodeTimerStopDate)
    {
        iLeftSecond = [_getValidateCodeTimerStopDate timeIntervalSinceNow];
        iLeftSecond = (iLeftSecond > 0) ? iLeftSecond : 0;
        
        if (iLeftSecond <= 0)
        {
            [self performSelector:@selector(stopGetValidateTimer) withObject:nil afterDelay:0.001f];
        }else{}
    }else{}
    
    [self.secondButton setTitle:[NSString stringWithFormat:@"%@s", @(iLeftSecond)] forState:UIControlStateNormal];
}


//手机号码验证
- (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1[0-9]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

- (void)getSondYZM
{
//    [self.view endEditing:YES];
//    if (self.userTextField.text.length == 0) {
//        [self showHUDText:@"请输入手机号"];
//        return;
//    }
//    if (![self validateMobile:self.userTextField.text]) {
//        [self showHUDText:@"请输入正确的手机号"];
//        return;
//    }
//    
//    
//    [self showHUDLoading];
//    [self.userOperator VerifiTelisRegisteredWith:self.userTextField.text callBack:^(BOOL success, id responseObject, NSError *error) {
//        [self hideHUDView];
//        if (success)
//        {
//            [self getSondYZMWithTelphone];
//        } else {
//            if (!error) {
//                [self showHUDText:responseObject[@"resultMsg"]];
//            }
//        }
//    }];
    
}

-(void)getSondYZMWithTelphone
{
//    
//    [self showHUDLoading];
//    [self.userOperator getSondYZMWithTelphone:self.userTextField.text callBack:^(BOOL success, id responseObject, NSError *error)
//     {
//         
//         [self hideHUDView];
//         if (success)
//         {
//             [self showHUDText:@"语音验证码已发送，请注意接听电话"];
//             [self.btnSound setTitleColor: RGB(170, 170, 170) forState:UIControlStateNormal];
//             self.btnSound.userInteractionEnabled = NO;
//             [self startGetValidateTimer];
//         } else {
//             if (!error) {
//                 [self showHUDText:responseObject[@"resultMsg"]];
//             }
//         }
//     }];
}

#pragma mark - 获取验证码
-(void)verificationCodeWithTelphone
{
//    
//    [self showHUDLoading];
//    [self.userOperator verificationCodeWithTelphone:self.userTextField.text callBack:^(BOOL success, id responseObject, NSError *error) {
//        
//        [self hideHUDView];
//        if (success) {
//            [self showHUDText:@"短信已发送，请注意查收"];
//            [self.btnSound setTitleColor: RGB(170, 170, 170) forState:UIControlStateNormal];
//            self.btnSound.userInteractionEnabled = NO;
//            [self startGetValidateTimer];
//            [self.secondButton setTitle:@"再次获取" forState:UIControlStateNormal];
//        } else {
//            if (!error) {
//                [self showHUDText:responseObject[@"resultMsg"]];
//            }
//        }
//    }];
}


@end
