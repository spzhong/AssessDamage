//
//  AppDelegate+SDK.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/4/8.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (SDK)

//分享估损单
-(void)shareAssessDamage:(NSString *)damageId with:(NSString *)sixCode;

@end