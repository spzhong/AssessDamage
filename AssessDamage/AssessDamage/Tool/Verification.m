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
        if (![phoneTest evaluateWithObject:phone]) {
            msg = @"请输入正确的手机号";
        }
    }
    return msg;
}

+(NSString *)newPhone:(NSString *)phone{
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"+" withString:@""];
    return phone;
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

//短信密码
+(NSString *)newsmsCode:(NSString *)code{
    code = [code stringByReplacingOccurrencesOfString:@" " withString:@""];
    return code;
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


//短信验证码的错误信息
+(NSString *)smsCodeMsg:(NSString *)code{
    if ([code isEqualToString:@"-1009"]) {
        return @"无法连接到网络";
    }else if ([code isEqualToString:@"251"]) {
        return @"访问过于频繁";
    }else if ([code isEqualToString:@"252"]) {
        return @"发送短信条数超过限制";
    }else if ([code isEqualToString:@"253"]) {
        return @"无权限进行此操作";
    }else if ([code isEqualToString:@"254"]) {
        return @"无权限发送验证码";
    }else if ([code isEqualToString:@"258"]) {
        return @"操作过于频繁";
    }else if ([code isEqualToString:@"458"]) {
        return @"手机号码在黑名单中";
    }else if ([code isEqualToString:@"462"]) {
        return @"每分钟发送次数超限";
    }else if ([code isEqualToString:@"463"]) {
        return @"手机号码每天发送次数超限";
    }else if ([code isEqualToString:@"464"]) {
        return @"每台手机每天发送次数超限";
    }else if ([code isEqualToString:@"465"]) {
        return @"号码在App中每天发送短信次数超限";
    }else if ([code isEqualToString:@"466"]) {
        return @"验证码为空";
    }else if ([code isEqualToString:@"467"]) {
        return @"校验验证码请求频繁";
    }else if ([code isEqualToString:@"468"]) {
        return @"验证码错误";
    }else if ([code isEqualToString:@"470"]) {
        return @"账号余额不足";
    }else if ([code isEqualToString:@"472"]) {
        return @"客户端请求发送短信验证过于频繁";
    }else if ([code isEqualToString:@"476"]) {
        return @"当前appkey发送短信的数量超过限额";
    }else if ([code isEqualToString:@"477"]) {
        return @"当前手机号发送短信的数量超过当天限额";
    }else if ([code isEqualToString:@"478"]) {
        return @"当前手机号在当前应用内发送超过限额";
    }else if ([code isEqualToString:@"479"]) {
        return @"请使用idfa版本的公共库";
    }else if ([code isEqualToString:@"480"]) {
        return @"SDK没有提交aes-key";
    }else if ([code isEqualToString:@"500"]) {
        return @"服务器内部错误";
    }else{
        return @"其它未知错误";
    }
}


















@end
