//
//  RepairFactory4S.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/30.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "RepairFactory4S.h"

@implementation RepairFactory4S

//判断是否经营此品牌的车--返回此品牌的数据
-(ManagementBrand *)isManagementBrandTheCar:(Car *)car{
    
    for (ManagementBrand *brand in self.brandArray) {
        if ([brand.brandId isEqualToString:car.brandId]) {
            return brand;
        }
    }
    return nil;
}


-(void)log{
    NSLog(@"\n");
    NSLog(@"修理厂或4s店铺信息############################################");
    NSLog(@"修理厂或4s店铺的id:%@",self.factoryId);
    NSLog(@"修理厂或4s店铺的名称:%@",self.factoryName);
    NSLog(@"修理厂或4s店铺经营的品牌[");
    for (ManagementBrand *brand in self.brandArray) {
        [brand log];
    }
    NSLog(@"]修理厂或4s店铺经营的品牌");
    NSLog(@"修理厂或4s店铺信息############################################");
    NSLog(@"\n");
}

@end
