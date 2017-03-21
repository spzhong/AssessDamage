//
//  User.m
//  AssessDamage
//
//  Created by qj0714 on 17/3/19.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "MyUser.h"

@implementation MyUser


//获取当前的用户
+(MyUser *)currUser{
    NSString *currentUserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserId"];
    if (currentUserId!=nil) {
        MyUser *user = nil;
        user = (MyUser *)[CoreData selcet_OneData:@"User" withWhere_id:[NSString stringWithFormat:@"userId='%@'",currentUserId]];
        return user;
    }else{
        return nil;
    }
}



//创建model
-(void)createModel:(NSMutableDictionary *)dic{
    
    self.key = [NSString stringWithFormat:@"%@",dic[@"key"]];
    self.pId = [NSString stringWithFormat:@"%@",dic[@"pId"]];
    
}

@end
