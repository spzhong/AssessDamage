//
//  Lostdamage.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/26.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "Lostdamage.h"
#import "ConfigData.h"

@implementation Lostdamage


//计算
-(void)calculation{
    
    //获取经营品牌
    ManagementBrand *brand = [self.factory4S isManagementBrandTheCar:self.carInfo];
    double allWorkHous = 0.0;
    double allPartsPrice = 0.0;
    int countItemType_Paint = 0;
    double itemType_PaintWorkHous = 0.0;
    for (LostItem *oneItem in self.lostItemArray) {
        //计算每一项
        [self calculationOneItem:oneItem with:brand];
        //喷漆
        if (oneItem.itemType==ItemType_Paint) {
            countItemType_Paint++;
            itemType_PaintWorkHous += [oneItem final_workHours];
        }else{
            allWorkHous += [oneItem final_workHours];
        }
        //每一项的配件价格
        allPartsPrice += [oneItem final_partsPrice];
    }
    //该factory4S尚未经营该品牌
    if (brand==nil) {
        //没有折扣
        allWorkHous += itemType_PaintWorkHous;
    }else{
        //进行计算折扣后的工时
        allWorkHous += [brand morePaintDiscount:countItemType_Paint] * itemType_PaintWorkHous;
    }
    //最终得出最终的工时
    
    NSLog(@"\n");
    NSLog(@"总和##############################################");
    NSLog(@"一共有%ld项维修项",self.lostItemArray.count);
    NSLog(@"所有的工时总和：%.2f",allWorkHous);
    NSLog(@"所有配件价格总和：%.2f",allPartsPrice);
    NSLog(@"总计：%.2f",allPartsPrice+allWorkHous);
    NSLog(@"总和##############################################");
}



//计算-核心的算法
-(void)calculationOneItem:(LostItem *)oneItem with:(ManagementBrand *)brand{

    
    //配件的价格折扣系数
    double partsPrice_coefficient =  [self calculation_partsPrice:oneItem with:brand];
    oneItem.partsPrice_coefficient = partsPrice_coefficient;
    
    //工时折扣系数
    double workTime_coefficient = [self calculation_workingHours:oneItem with:brand];
    oneItem.workTime_coefficient = workTime_coefficient;
    
    //品牌折扣系数
    double brand_coefficient = [self calculation_brand:oneItem with:brand];
    oneItem.brand_coefficient = brand_coefficient;
    
    //价格区间系数
    double carPrice_coefficient = [ConfigData getCarPrice_coefficient:self.carInfo.price];
    oneItem.carPrice_coefficient = carPrice_coefficient;
    
    //地区系数
    double city_coefficient = [ConfigData getCity_coefficient:nil];
    oneItem.city_coefficient = city_coefficient;
    
    //标准工时的数据
    double standardWorkTime = [ConfigData getStandardWorkTime:self.carInfo.price withItem:oneItem];
    oneItem.standardWorkTime = standardWorkTime;
    
    
    //打印配件的信息
    [oneItem log];
}


//计算配件等价格
-(double)calculation_partsPrice:(LostItem *)oneItem with:(ManagementBrand *)brand{
    //该factory4S尚未经营该品牌
    if (brand==nil) {
        oneItem.repairType = 2;//非经营品牌
        return brand.noBrand_coefficient;
    }else{
        if (oneItem.repairType==0) {
            return brand.brand_giveRepair_coefficient;
        }else if (oneItem.repairType==1) {
            return brand.brand_backRepair_coefficient;
        }
        return oneItem.partsPrice;
    }
}

//工时折扣系数
-(double)calculation_workingHours:(LostItem *)oneItem with:(ManagementBrand *)brand{
    
    double workHours = 1.0;
    //该factory4S尚未经营该品牌
    if (brand==nil) {
        return workHours;
    }else{
        switch (oneItem.itemType) {
            case ItemType_disassembly://拆装
                workHours *= brand.disassembly_coefficient;
                break;
            case ItemType_replace://更换
                workHours *= brand.replace_coefficient;
                break;
            case ItemType_sheetMetal_light://钣金-轻
                workHours *= brand.sheetMetal_light_coefficient;
                break;
            case ItemType_sheetMetal_mid://钣金-中
                workHours *= brand.sheetMetal_mid_coefficient;
                break;
            case ItemType_sheetMetal_heavy://钣金-重
                workHours *= brand.sheetMetal_heavy_coefficient;
                break;
            case ItemType_Paint://喷漆
                workHours *= brand.paint_midcoefficient;
                break;
            default:
                break;
        }
        return workHours;
    }
}


//品牌折扣系数
-(double)calculation_brand:(LostItem *)oneItem with:(ManagementBrand *)brand{
    
    double brandCoefficient = 1.0;
    //该factory4S尚未经营该品牌
    if (brand==nil) {
        return [ConfigData getNoBrand:self.carInfo.brandId];
    }else{
        for (NSMutableDictionary *dic in brand.brandDiscountArray) {
            //车型属于该品牌
            if ([dic[@"carId"] isEqualToString:self.carInfo.carId]) {
                NSMutableArray *carDiscountArray = dic[@"carDiscountArray"];
                for (NSMutableDictionary *dicOne in carDiscountArray) {
                    if ([dicOne[@"partsId"] isEqualToString:oneItem.partsId] &&  [dicOne[@"workItem"] intValue] ==oneItem.itemType) {
                        return [dicOne[@"coefficient"] doubleValue] * brandCoefficient;
                    }
                }
                break;
            }
        }
        return brandCoefficient;
    }
}






@end
