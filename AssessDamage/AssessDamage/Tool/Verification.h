//
//  Verification.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/4/5.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Verification : NSObject

//验证手机号
+(NSString *)phone:(NSString *)phone;

//新的手机号
+(NSString *)newPhone:(NSString *)phone;

//验证登录密码
+(NSString *)signCode:(NSString *)code;

//验证短信密码
+(NSString *)smsCode:(NSString *)code;

//短信密码
+(NSString *)newsmsCode:(NSString *)code;

//短信验证码的错误信息
+(NSString *)smsCodeMsg:(NSString *)code;


@end
