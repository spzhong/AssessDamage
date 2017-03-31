//
//  Car.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/30.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <Foundation/Foundation.h>
 
//车辆信息
@interface Car : NSObject

@property(nonatomic,retain)NSString *carId;
@property(nonatomic,retain)NSString *carName;
@property(nonatomic)double price;//价格

@property(nonatomic,retain)NSString *brandId;//品牌的id
@property(nonatomic,retain)NSString *brandName;//品牌名称

-(void)log;

@end
