//
//  ManagementBrand.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/30.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <Foundation/Foundation.h>


//经营品牌
@interface ManagementBrand : NSObject


@property(nonatomic,retain)NSString *brandId;//经营品牌的id
@property(nonatomic,retain)NSString *brandName;//经营品牌的名称

//配件折扣系数
@property(nonatomic)double brand_giveRepair_coefficient;//品牌送修(系数)
@property(nonatomic)double brand_backRepair_coefficient;//品牌返修(系数)
@property(nonatomic)double noBrand_coefficient;//非品牌(系数)

//工时折扣系数
@property(nonatomic)double disassembly_coefficient;//拆装(系数)
@property(nonatomic)double replace_coefficient;//更换(系数)
@property(nonatomic)double sheetMetal_light_coefficient;//钣金轻(系数)
@property(nonatomic)double sheetMetal_mid_coefficient;//钣金中(系数)
@property(nonatomic)double sheetMetal_heavy_coefficient;//钣金重(系数)
@property(nonatomic)double paint_midcoefficient;//喷漆(系数)

//多幅油漆折扣系数
@property(nonatomic)int paintStar;//喷漆3幅开始优惠
@property(nonatomic,retain)NSMutableArray *paintArray;//3,4,5,6,7,.......


//经营改品牌车下的车型-对应的品牌折扣系数
//key carId车型
 //key Array (coefficient系数,partsId维修配件的项目)
@property(nonatomic,retain)NSMutableArray *brandDiscountArray;//对应的是品牌折扣的系数

//获取多幅油漆的优惠-系数
-(double)morePaintDiscount:(int)cout;


-(void)log;

@end
