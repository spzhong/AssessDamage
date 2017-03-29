//
//  Lostdamage.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/26.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <Foundation/Foundation.h>


//车辆信息
@interface Car : NSObject

@property(nonatomic,retain)NSString *carId;
@property(nonatomic,retain)NSString *carName;

@property(nonatomic,retain)NSString *brandId;//品牌的id
@property(nonatomic,retain)NSString *brandName;//品牌名称

@end



//估损的项目-ITEM
@interface LostItem : NSObject

@property(nonatomic,retain)NSString *itemId;//估损的id
@property(nonatomic,retain)NSString *itemType;//估损单类型（1是拆装，2更换，3是钣金轻，31是钣金中，32是钣金重，4是喷漆）

@property(nonatomic,retain)NSString *partsId;//配件id
@property(nonatomic,retain)NSString *partsName;//配件名称

@property(nonatomic,retain)NSString *workTime;//工时



@end




//经营品牌
@interface ManagementBrand : NSObject

@property(nonatomic,retain)NSString *brandId;//品牌的id
@property(nonatomic,retain)NSString *brandName;//品牌名称

@property(nonatomic,retain)NSMutableArray<NSMutableDictionary<NSString*,NSString *> *> *partsFactorArray;//配件折扣系数
@property(nonatomic,retain)NSMutableArray<NSMutableDictionary<NSString*,NSString *> *> *workTimeArray;//工时折扣系数
@property(nonatomic,retain)NSMutableArray<NSMutableDictionary<NSString*,NSString *> *> *paintArray;//配件系数


@end




//4s
@interface RepairFactory4S : NSObject

@property(nonatomic,retain)NSString *factoryId;//修来厂商的id
@property(nonatomic,retain)NSString *factoryName;//修来厂商的名称

@property(nonatomic,retain)NSMutableArray<ManagementBrand *> *brandArray;//经营品牌,及相关的系数

@end






@interface Lostdamage : NSObject

@property(retain,nonatomic)Car *carInfo;              //车辆信息
@property(retain,nonatomic)RepairFactory4S *factory4S;//修理厂商
@property(retain,nonatomic)NSMutableArray<LostItem *> *lostItemArray;//估损单的项目


@end
