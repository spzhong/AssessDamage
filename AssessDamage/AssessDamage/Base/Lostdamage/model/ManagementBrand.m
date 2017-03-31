//
//  ManagementBrand.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/30.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "ManagementBrand.h"

@implementation ManagementBrand

//获取多幅油漆的优惠-系数
-(double)morePaintDiscount:(int)cout{
    if (cout < self.paintStar) {
        return 1.0;
    }
    //临界点的判断
    if (cout-self.paintStar >= self.paintArray.count) {
        return [[self.paintArray lastObject] doubleValue];
    }
    //取出该范围的数据
    return [self.paintArray[cout-self.paintStar] doubleValue];
}

-(void)log{
    NSString *space = @"    ";
    NSLog(@"%@该修理厂或4s店铺经营的品牌############################################",space);
    
    NSLog(@"%@%@配件折扣系数{",space,space);
    NSLog(@"%@%@%@品牌送修(系数):%.2f",space,space,space,self.brand_giveRepair_coefficient);
    NSLog(@"%@%@%@品牌返修(系数):%.2f",space,space,space,self.brand_backRepair_coefficient);
    NSLog(@"%@%@%@非品牌(系数):%.2f",space,space,space,self.noBrand_coefficient);
    NSLog(@"%@%@}配件折扣系数",space,space);
    
    
    NSLog(@"%@%@工时折扣系数{",space,space);
    NSLog(@"%@%@%@拆装(系数):%.2f",space,space,space,self.disassembly_coefficient);
    NSLog(@"%@%@%@更换(系数):%.2f",space,space,space,self.replace_coefficient);
    NSLog(@"%@%@%@钣金轻(系数):%.2f",space,space,space,self.sheetMetal_light_coefficient);
    NSLog(@"%@%@%@钣金中(系数):%.2f",space,space,space,self.sheetMetal_mid_coefficient);
    NSLog(@"%@%@%@钣金重(系数):%.2f",space,space,space,self.sheetMetal_heavy_coefficient);
    NSLog(@"%@%@%@喷漆(系数):%.2f",space,space,space,self.paint_midcoefficient);
    NSLog(@"%@%@}工时折扣系数",space,space);
    
    
    NSLog(@"%@%@多幅油漆折扣系数{",space,space);
    NSLog(@"%@%@%@起始%d幅优惠",space,space,space,self.paintStar);
    NSLog(@"%@%@%@%@",space,space,space,self.paintArray);
    NSLog(@"%@%@}多幅油漆折扣系数",space,space);
    
    
    NSLog(@"%@%@经营改品牌车下的车型-对应的品牌折扣系数{",space,space);
    NSLog(@"%@%@%@起始%@幅优惠",space,space,space,self.brandDiscountArray);
    NSLog(@"%@%@}经营改品牌车下的车型-对应的品牌折扣系数",space,space);
    NSLog(@"%@该修理厂或4s店铺经营的品牌############################################",space);
}

@end
