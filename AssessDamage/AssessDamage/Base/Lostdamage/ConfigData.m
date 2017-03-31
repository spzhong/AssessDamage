//
//  ConfigData.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/30.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "ConfigData.h"

@implementation ConfigData

//价格区间系数
+(double)getCarPrice_coefficient:(double)price{
    if (price < 6) {
        return 0.8;
    }else if (price<10){
        return 0.9;
    }else if (price<15){
        return 1;
    }else if (price<25){
        return 1;
    }else if (price<30){
        return 1;
    }else if (price<40){
        return 1.1;
    }else if (price<50){
        return 1.2;
    }else if (price<60){
        return 1.3;
    }else{
        return 1.4;
    }
}

//地区系数--默认的是深圳
+(double)getCity_coefficient:(NSString *)cityId{
    return 1.0;
}


//标准工时
+(double)getStandardWorkTime:(double)price withItem:(LostItem *)item{
    //读取配置的数据
    NSArray *array = [Tool readStandardWorkHours];
    for (NSMutableDictionary *dic in array) {
        if ([dic[@"partsId"] isEqualToString:item.partsId]) {
            NSArray *carPriceArray = dic[@"carPriceArray"];
            for (NSMutableDictionary *dicOne in carPriceArray) {
                if ([dicOne[@"start_price"] floatValue] > price && price <= [dicOne[@"end_price"] floatValue]) {
                    return [dicOne[@"workHours"] floatValue];
                }
            }
            break;
        }
    }
    return -1;
}


//非品牌对应的系数
+(double)getNoBrand:(NSString *)broundId{
    NSArray *brandArray = [Tool readNoBrand];
    for (NSMutableDictionary *dic in brandArray) {
        if([dic[@"carBrandId"] isEqualToString:broundId]){
            return [dic[@"coefficient"] doubleValue];
        }
    }
    return 1.0;
}

@end
