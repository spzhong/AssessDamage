//
//  VerifyViewController.m
//  SMS_SDKDemo
//
//  Created by admin on 14-6-4.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "VerifyViewController.h"
#import <AddressBook/AddressBook.h>
//#import "YJLocalCountryData.h"
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDKUserInfo.h>
#import <SMS_SDK/Extend/SMSSDKAddressBook.h>


#define TRY_AGAIN_GETSMSCODE_ALERTVIEW_TAG    10
#define CLICKLEFTBUTTON_ALERTVIEW_TAG         11
#define COMMITCODE_SUCCES_ALERTVIEW_TAG       12
#define TRY_AGAIN_GETVOICECODE_ALERTVIEW_TAG  13

#import "Verification.h"


@interface VerifyViewController ()
{
    NSString* _phone;
    NSString* _areaCode;
    NSError *verifyError;
    NSBundle *_bundle;

}

@property (nonatomic, strong) NSTimer* timer2;

@property (nonatomic, strong) NSTimer* timer1;

@end

static int count = 0;

@implementation VerifyViewController

-(void)clickLeftButton
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"notice", @"Localizable", _bundle, nil)
                                                  message:NSLocalizedStringFromTableInBundle(@"codedelaymsg", @"Localizable", _bundle, nil)
                                                 delegate:self
                                        cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"back", @"Localizable", _bundle, nil)
                                        otherButtonTitles:NSLocalizedStringFromTableInBundle(@"wait", @"Localizable", _bundle, nil), nil];

    alert.tag = CLICKLEFTBUTTON_ALERTVIEW_TAG;
    [alert show];    
}

-(void)setPhone:(NSString*)phone AndAreaCode:(NSString*)areaCode
{
    _phone = phone;
    _areaCode = areaCode;
}

-(void)submit
{
    //验证号码
    [self.view endEditing:YES];
    NSString *msg = [Verification smsCode:self.verifyCodeField.text];
    if (msg.length>0) {
        [DCProgressHUD showHUDText:msg];
    }else{
        
        [DCProgressHUD showHUDLoading:self.view text:@"加载中..."];
        [SMSSDK commitVerificationCode:[Verification newsmsCode:self.verifyCodeField.text]  phoneNumber:_phone zone:_areaCode result:^(SMSSDKUserInfo *userInfo, NSError *error) {
            {
                [DCProgressHUD hideHUDView:self.view];
                
                
                //验证成功了
                [self dismissViewControllerAnimated:YES completion:NULL];
                //保存当前的手机号
                [[NSUserDefaults standardUserDefaults] setObject:_phone forKey:@"curPhone"];
                //切换到主页
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kNFExchangeRootViewToMainView" object:nil userInfo:[NSMutableDictionary dictionaryWithObjectsAndKeys:_phone,@"phone",[Verification newsmsCode:self.verifyCodeField.text],@"code",nil]];
                
                return;
                if (!error)
                {
                    //验证成功了
                    [self dismissViewControllerAnimated:YES completion:NULL];
                    //保存当前的手机号
                    [[NSUserDefaults standardUserDefaults] setObject:_phone forKey:@"curPhone"];
                    //切换到主页
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNFExchangeRootViewToMainView" object:nil userInfo:[NSMutableDictionary dictionaryWithObjectsAndKeys:_phone,@"phone",_areaCode,@"code",nil]];
                    
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
                    [Tool saveToErrorLog:nil withPost:[NSMutableDictionary dictionaryWithObjectsAndKeys:_phone,@"phone", nil] withLog:dic  withDsc:@"调用SMSSDK验证短信验证码"];
                    //保存记录
                }
            }
            
        }];
    }
    
    
 
}


-(void)CannotGetSMS
{
    NSString* str = [NSString stringWithFormat:@"%@:%@",NSLocalizedStringFromTableInBundle(@"cannotgetsmsmsg", @"Localizable", _bundle, nil) ,_phone];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"surephonenumber", @"Localizable", _bundle, nil) message:str delegate:self cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"cancel", @"Localizable", _bundle, nil) otherButtonTitles:NSLocalizedStringFromTableInBundle(@"sure", @"Localizable", _bundle, nil), nil];
    alert.tag = TRY_AGAIN_GETSMSCODE_ALERTVIEW_TAG;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __weak VerifyViewController *verifyViewController = self;
    
    switch (alertView.tag)
    {
        case TRY_AGAIN_GETSMSCODE_ALERTVIEW_TAG:
        {
            switch (buttonIndex)
            {
                case 1:
                {
                    NSLog(@"重发验证码");
                    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phone zone:_areaCode customIdentifier:nil result:^(NSError *error) {
                        if (!error)
                        {
                            NSLog(@"获取验证码成功");
                        }
                        else
                        {
                            NSString *messageStr = [NSString stringWithFormat:@"%zidescription",error.code];
                            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"codesenderrtitle", @"Localizable", _bundle, nil)
                                                                          message:NSLocalizedStringFromTableInBundle(messageStr, @"Localizable", _bundle, nil)
                                                                         delegate:self
                                                                cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"sure", @"Localizable", _bundle, nil)
                                                                otherButtonTitles:nil, nil];
                            [alert show];
                        }
                    }];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case CLICKLEFTBUTTON_ALERTVIEW_TAG:
        {
            switch (buttonIndex)
            {
                case 0:
                {
                    [verifyViewController dismissViewControllerAnimated:YES completion:^{
                        [verifyViewController.timer2 invalidate];
                        [verifyViewController.timer1 invalidate];
                    }];
   
                    break;
                }
                default:
                    break;
            }
            break;
        }
            
        case COMMITCODE_SUCCES_ALERTVIEW_TAG:
        {
            if (self.verificationCodeResult)
            {
                self.verificationCodeResult (SMSUIResponseStateSuccess,_phone,_areaCode,verifyError);
                //解决等待时间乱跳的问题
                [verifyViewController.timer2 invalidate];
                [verifyViewController.timer1 invalidate];
            }
            break;
        }
        case TRY_AGAIN_GETVOICECODE_ALERTVIEW_TAG:
        {
            switch (buttonIndex)
            {
                case 0:
                {
                    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodVoice
                                            phoneNumber:_phone
                                                   zone:_areaCode
                                       customIdentifier:nil
                                                 result:^(NSError *error)
                     {
                         if (error)
                         {
                             NSString *messageStr = [NSString stringWithFormat:@"%zidescription",error.code];
                             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"codesenderrtitle", @"Localizable", _bundle, nil)
                                                                             message:NSLocalizedStringFromTableInBundle(messageStr, @"Localizable", _bundle, nil)
                                                                            delegate:self
                                                                   cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"sure", @"Localizable", _bundle, nil)
                                                                   otherButtonTitles:nil, nil];
                             [alert show];
                         }
                     }];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak __typeof(self) weakSelf= self;
    [self rewriteLeftNav_title:@"取消" withBlock:^{
        [weakSelf dismissViewControllerAnimated:YES completion:NULL];
    }];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat statusBarHeight = 0;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        statusBarHeight = 20;
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SMSSDKUI" ofType:@"bundle"];
    NSBundle *bundle = [[NSBundle alloc] initWithPath:filePath];
    _bundle = bundle;

    
    
    UILabel* label = [[UILabel alloc] init];
    label.frame = CGRectMake(15,statusBarHeight, self.view.frame.size.width - 30, 21);
    label.text = @"已发送验证码到这个号码";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica" size:17];
    [self.view addSubview:label];
    
    UILabel* telLabel = [[UILabel alloc] init];
    telLabel.frame=CGRectMake(15, 21+statusBarHeight, self.view.frame.size.width - 30, 21);
    telLabel.textAlignment = NSTextAlignmentCenter;
    telLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    [self.view addSubview:telLabel];
    telLabel.text = [NSString stringWithFormat:@"+%@ %@",_areaCode,_phone];
    
    UILabel *seperaterLineUp = [[UILabel alloc] initWithFrame:CGRectMake(10, 57 + statusBarHeight, self.view.frame.size.width - 20, 1)];
    seperaterLineUp.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:seperaterLineUp];
    
    UILabel *verifyCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 111-53 + statusBarHeight, 80, 46)];
    verifyCodeLabel.text = @"验证码";
    [self.view addSubview:verifyCodeLabel];
    
    UILabel *verticalLine = [[UILabel alloc] initWithFrame:CGRectMake(verifyCodeLabel.frame.origin.x - 10 + verifyCodeLabel.frame.size.width + 1, verifyCodeLabel.frame.origin.y, 1, verifyCodeLabel.frame.size.height)];
    verticalLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:verticalLine];
    
    _verifyCodeField = [[UITextField alloc] init];
    _verifyCodeField.frame = CGRectMake(verticalLine.frame.origin.x, 111-53 + statusBarHeight, self.view.frame.size.width - verifyCodeLabel.frame.size.width - 20, 46);
    _verifyCodeField.textAlignment = NSTextAlignmentCenter;
    _verifyCodeField.placeholder = @"请输入验证码";
    _verifyCodeField.font = [UIFont fontWithName:@"Helvetica" size:18];
    _verifyCodeField.keyboardType = UIKeyboardTypePhonePad;
    _verifyCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_verifyCodeField];
    
    UILabel *seperaterLineDown = [[UILabel alloc] initWithFrame:CGRectMake(seperaterLineUp.frame.origin.x, _verifyCodeField.frame.origin.y + _verifyCodeField.frame.size.height + 1, seperaterLineUp.frame.size.width, 1)];
    seperaterLineDown.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:seperaterLineDown];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.frame = CGRectMake(15, 169-53 + statusBarHeight, self.view.frame.size.width - 30, 40);
    _timeLabel.numberOfLines = 0;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    _timeLabel.text = @"接受短信大约需要60秒";
    [self.view addSubview:_timeLabel];
    
    _repeatSMSBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _repeatSMSBtn.frame = CGRectMake(15, 169-53 + statusBarHeight, self.view.frame.size.width - 30, 30);
    [_repeatSMSBtn setTitle:@"收不到短信验证码？" forState:UIControlStateNormal];
    [_repeatSMSBtn addTarget:self action:@selector(CannotGetSMS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_repeatSMSBtn];
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    NSString *imageString = [bundle pathForResource:@"button4" ofType:@"png"];
    [submitBtn setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:imageString] forState:UIControlStateNormal];
    submitBtn.frame = CGRectMake(15, 220-53 + statusBarHeight, self.view.frame.size.width - 30, 42);
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
  
    self.repeatSMSBtn.hidden = YES;
    
    [_timer2 invalidate];
    [_timer1 invalidate];
    
    count = 0;
    
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:60
                                           target:self
                                         selector:@selector(showRepeatButton)
                                         userInfo:nil
                                          repeats:YES];
    
    self.timeLabel.textColor = [UIColor lightGrayColor];
    NSTimer* timer2 = [NSTimer scheduledTimerWithTimeInterval:1
                                                    target:self
                                                  selector:@selector(updateTime)
                                                  userInfo:nil
                                                   repeats:YES];
    _timer1 = timer;
    _timer2 = timer2;
    
   // [YJLocalCountryData showMessag:NSLocalizedStringFromTableInBundle(@"sendingin", @"Localizable", bundle, nil) toView:self.view];
    
}


-(void)updateTime
{
    
    count ++;
    if (count >= 60)
    {
        [_timer2 invalidate];
        return;
    }
    //NSLog(@"更新时间");
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@%i%@",@"接收验证码大约需要",60 - count,@" 秒"];
    
    if (count == 30)
    {
        if (self.getCodeMethod == SMSGetCodeMethodSMS) {
            
            if (_voiceCallMsgLabel.hidden)
            {
                _voiceCallMsgLabel.hidden = NO;
            }
            
            if (_voiceCallButton.hidden)
            {
                _voiceCallButton.hidden = NO;
            }
        }
        
    }
}

-(void)showRepeatButton{
    self.timeLabel.hidden = YES;
    self.repeatSMSBtn.hidden = NO;
    
    [_timer1 invalidate];
    return;
}

@end
