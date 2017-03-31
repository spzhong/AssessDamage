//
//  Car.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/30.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "Car.h"

@implementation Car

-(void)log{
    NSLog(@"\n");
    NSLog(@"车型信息############################################");
    NSLog(@"车型的ID:%@",self.carId);
    NSLog(@"车型的名称:%@",self.carName);
    NSLog(@"车型的价格:%.2f",self.price);
    NSLog(@"所属品牌的id:%@",self.brandId);
    NSLog(@"所属品牌的名称:%@",self.brandName);
    NSLog(@"车型信息############################################");
    NSLog(@"\n");
}

@end
