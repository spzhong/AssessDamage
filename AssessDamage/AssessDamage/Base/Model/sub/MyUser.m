//
//  User.m
//  AssessDamage
//
//  Created by qj0714 on 17/3/19.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "MyUser.h"
#import "User+CoreDataClass.h"

@implementation MyUser


//获取当前的用户
+(User *)currUser{
    NSString *currentUserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserId"];
    if (currentUserId!=nil) {
        User *user = nil;
        user = (User *)[CoreData selcet_OneData:@"User" withWhere_id:[NSString stringWithFormat:@"userId='%@'",currentUserId]];
        return user;
    }else{
        return nil;
    }
}



//创建model
-(void)createModel:(NSMutableDictionary *)dic{
    CurrUser.userId = dic[@"userId"];
    CurrUser.name = dic[@"name"];
    CurrUser.cityId = dic[@"cityId"];
    CurrUser.token = dic[@"token"];
    CurrUser.userType = dic[@"userType"];
    CurrUser.phone = dic[@"phone"];
    CurrUser.enterpriseId = dic[@"enterpriseId"];
    CurrUser.enterpriseName = dic[@"enterpriseName"];
    CurrUser.regionId = dic[@"regionId"];
    CurrUser.cityName = dic[@"cityName"];
    CurrUser.regionName = dic[@"regionName"];
}


//清空用户数据
-(void)clearUser{
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"currentUserId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //释放model数据
    [self freeModel];
}

@end
