//
//  Verification.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/4/5.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "Verification.h"

@implementation Verification


//验证手机号
+(NSString *)phone:(NSString *)phone{
    NSString *msg = @"";
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (phone.length==0) {
        msg = @"请输入手机号";
    }else{
        NSString *phoneRegex = @"^1[0-9]{10}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        if ([phoneTest evaluateWithObject:phone]) {
            msg = @"请输入正确的手机号";
        }
    }
    return msg;
}

//验证登录密码
+(NSString *)signCode:(NSString *)code{
    NSString *msg = @"";
    code = [code stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (code.length==0) {
        msg = @"请输入登录密码";
    }else{
        if (code.length<6) {
            msg = @"输入的密码太短了";
        }else if (code.length<16) {
            msg = @"输入的密码太长了";
        }
    }
    return msg;
}

//验证短信密码
+(NSString *)smsCode:(NSString *)code{
    NSString *msg = @"";
    code = [code stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (code.length==0) {
        msg = @"请输入短信验证码";
    }else{
        if (code.length!=4) {
            msg = @"请输入正确的短信验证码";
        }
    }
    return msg;
}

@end
