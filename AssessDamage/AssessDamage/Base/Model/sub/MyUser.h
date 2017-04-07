//
//  User.h
//  AssessDamage
//
//  Created by qj0714 on 17/3/19.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseM.h"
#import "User+CoreDataClass.h"

#define CurrUser [MyUser currUser]


@interface MyUser : BaseM<BaseMDelagete>


//获取当前的用户
+(User *)currUser;
//清空用户数据
-(void)clearUser;

@end
