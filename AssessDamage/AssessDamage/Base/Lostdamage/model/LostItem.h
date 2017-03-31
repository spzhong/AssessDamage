//
//  LostItem.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/30.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <Foundation/Foundation.h>

//维修项目的类型--工项
typedef enum LostItemType {
    ItemType_disassembly = 1,       //拆装
    ItemType_replace=2,             //更换
    ItemType_sheetMetal_light=30,   //钣金_轻
    ItemType_sheetMetal_mid=31,     //钣金_中
    ItemType_sheetMetal_heavy=32,   //钣金_重
    ItemType_Paint=4,               //喷漆
}type;

//估损的项目-ITEM
@interface LostItem : NSObject

@property(nonatomic)enum LostItemType itemType;//配件类型（1是拆装，2更换，30是钣金轻，31是钣金中，32是钣金重，4是喷漆）

@property(nonatomic,retain)NSString *partsId;//配件id
@property(nonatomic,retain)NSString *partsName;//配件名称
@property(nonatomic)double partsPrice;//配件价格

@property(nonatomic)int repairType;//（需要的配件类型）0是经营品牌送修，1是经营品牌返修，2是非经营品牌
@property(nonatomic,retain)NSString *reMark;//备注



//计算得出的结果
@property(nonatomic)double partsPrice_coefficient;//配件折扣系数
@property(nonatomic)double workTime_coefficient;//工时折扣系数
@property(nonatomic)double brand_coefficient;//品牌折扣系数
@property(nonatomic)double carPrice_coefficient;//车价区间折扣系数
@property(nonatomic)double city_coefficient;//地区系数
@property(nonatomic)double standardWorkTime;//标准工时


-(void)log;

//最终的折扣配件价格
-(double)final_partsPrice;
//最终的工时
-(double)final_workHours;


@end
