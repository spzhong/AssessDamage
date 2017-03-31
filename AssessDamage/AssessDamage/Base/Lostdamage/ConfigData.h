//
//  ConfigData.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/30.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LostItem.h"

@interface ConfigData : NSObject


//价格区间系数
+(double)getCarPrice_coefficient:(double)price;

//地区系数
+(double)getCity_coefficient:(NSString *)cityId;

//标准工时
+(double)getStandardWorkTime:(double)price withItem:(LostItem *)item;


//非品牌对应的系数
+(double)getNoBrand:(NSString *)broundId;

@end
