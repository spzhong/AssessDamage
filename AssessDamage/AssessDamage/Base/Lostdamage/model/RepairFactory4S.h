//
//  RepairFactory4S.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/30.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagementBrand.h"
#import "Car.h"


//4s
@interface RepairFactory4S : NSObject

@property(nonatomic,retain)NSString *factoryId;//修来厂商的id
@property(nonatomic,retain)NSString *factoryName;//修来厂商的名称

@property(nonatomic,retain)NSMutableArray<ManagementBrand *> *brandArray;//经营品牌,及相关的系数


//判断是否经营此品牌的车--返回此品牌的数据
-(ManagementBrand *)isManagementBrandTheCar:(Car *)car;

-(void)log;

@end
