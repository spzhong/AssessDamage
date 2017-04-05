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

//验证登录密码
+(NSString *)signCode:(NSString *)code;

//验证短信密码
+(NSString *)smsCode:(NSString *)code;


@end
