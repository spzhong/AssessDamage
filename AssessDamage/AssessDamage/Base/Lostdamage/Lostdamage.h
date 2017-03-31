//
//  Lostdamage.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/26.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Car.h"
#import "RepairFactory4S.h"
#import "LostItem.h"


@interface Lostdamage : NSObject

@property(retain,nonatomic)Car *carInfo;              //车辆信息
@property(retain,nonatomic)RepairFactory4S *factory4S;//修理厂商
@property(retain,nonatomic)NSMutableArray<LostItem *> *lostItemArray;//估损单的项目
 
//计算
-(void)calculation;


@end
