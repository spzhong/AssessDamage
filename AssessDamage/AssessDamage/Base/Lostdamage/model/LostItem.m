//
//  LostItem.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/30.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "LostItem.h"

@implementation LostItem


-(void)log{
    NSLog(@"配件信息############################################");
    NSLog(@"配件的ID:%@",self.partsId);
    NSLog(@"配件的名称:%@",self.partsName);
    NSLog(@"配件的价格:%.2f",self.partsPrice);
    NSLog(@"处理配件的类型:%@",[self itemTypeToString]);
    if (self.repairType==0) {
        NSLog(@"经营品牌送修");
    }else if (self.repairType==1) {
        NSLog(@"经营品牌返修");
    }else if (self.repairType==2) {
        NSLog(@"非经营品牌");
    }
    NSLog(@"标准工时:%f",self.standardWorkTime);
    NSLog(@"备注:%@",self.reMark);
    
    NSLog(@"计算的结果{");
    NSLog(@"    配件折扣系数:%f",self.partsPrice_coefficient);
    NSLog(@"    工时系数:%f",self.workTime_coefficient);
    NSLog(@"    工时折扣系数:%f",self.workTimeDiscount_coefficient);
    NSLog(@"    品牌折扣系数:%f",self.brand_coefficient);
    NSLog(@"    车价区间系数:%f",self.carPrice_coefficient);
    NSLog(@"    地区系数:%f",self.city_coefficient);
    NSLog(@"    标准工时:%.0f",self.standardWorkTime);
    NSLog(@"}计算的结果");
    NSLog(@"当前配件折后的价格:%.2f",[self final_partsPrice]);
    NSLog(@"当前配件所需的工时:%.2f",[self final_workHours]);
    NSLog(@"配件信息############################################");
}


-(NSString *)itemTypeToString{
    switch (self.itemType) {
        case ItemType_disassembly:
            return @"拆装";
            break;
        case ItemType_replace:
            return @"更换";
            break;
        case ItemType_sheetMetal_light:
            return @"钣金-轻";
            break;
        case ItemType_sheetMetal_mid:
            return @"钣金-中";
            break;
        case ItemType_sheetMetal_heavy:
            return @"钣金-重";
            break;
        default:
            return @"未知";
            break;
    }
}


//最终的折扣配件价格
-(double)final_partsPrice{
    return self.partsPrice_coefficient*self.partsPrice;
}

//最终的工时
-(double)final_workHours{
    return self.standardWorkTime*self.workTime_coefficient*self.brand_coefficient*self.carPrice_coefficient*self.city_coefficient*self.workTimeDiscount_coefficient;
}



@end
