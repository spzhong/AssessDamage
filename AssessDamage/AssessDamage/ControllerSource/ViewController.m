//
//  ViewController.m
//  AssessDamage
//
//  Created by qj0714 on 17/3/19.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "ViewController.h"
#import "MyUser.h"
#import "UIViewController+View.h"
#import "Lostdamage.h"
#import "SlideView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"定损";

    MyUser *my = [[MyUser alloc] init];
    //获取数据
    [my getData:@"hroror/qwwq" withPostDic:nil isReadFromCache:NO withBlock:^(BOOL success, id rep) {
    }];
    
    [self iniLoadView];
    
    [self rewriteLeftNav_title:@"用户" withBlock:^{
        SlideView *sli = [AppWindow viewWithTag:1988];
        [sli leftViewShow:YES];
    }];
    [self rewriteRightNav_title:@"通知" withBlock:^{
        
    }];
    
    [self lostdamage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//估损
-(void)lostdamage{
 
    //品牌   本田
    //车型    艾力绅
    //车价格区间 25<x<30
    
    //鹏峰4s店
    
    //项目
    /*
        1拆装     前保险杠皮
        2更换     燃油箱
        3钣金（中）后侧围
        4喷漆     举升门
        5喷漆     尾门
        6喷漆     后围板
     */
    
    
    Car *car = [[Car alloc] init];
    car.carId = @"1";//车型
    car.carName = @"兰德酷路泽";
    car.price = 30;
    car.brandId = @"1";//品牌
    car.brandName = @"丰田";
    
    
    
    //汽修厂或4S
    RepairFactory4S *factory4S = [[RepairFactory4S alloc] init];
    factory4S.factoryId = @"1";
    factory4S.factoryName = @"鹏峰汽修4s店铺";
    factory4S.brandArray = [NSMutableArray arrayWithCapacity:0];//经营品牌
    //维修厂或4S店
    ManagementBrand *mangent1 = [[ManagementBrand alloc] init];
    mangent1.brandId = @"1";
    mangent1.brandName = @"丰田";
    mangent1.brand_giveRepair_coefficient = 1;//经营品牌送修
    mangent1.brand_backRepair_coefficient = 1;//经营品牌返修
    mangent1.noBrand_coefficient = 0.9;//非经营品牌
    mangent1.disassembly_coefficient = 0.3;//拆装(系数)
    mangent1.replace_coefficient = 0.4;//更换(系数)
    mangent1.sheetMetal_light_coefficient=0.5;//钣金轻(系数)
    mangent1.sheetMetal_mid_coefficient=0.5;//钣金中(系数)
    mangent1.sheetMetal_heavy_coefficient=0.5;//钣金重(系数)
    mangent1.paint_midcoefficient=0.2;//喷漆(系数)
    mangent1.paintStar=3;//3幅起开始计算优惠
    mangent1.paintArray=[NSMutableArray arrayWithObjects:@"0.95",@"0.9",@"0.85",@"0.8",@"0.75",@"0.75",@"0.75",@"0.75",@"0.75",@"0.75",@"0.75", nil];//3-11幅起开始计算优惠
    //经营改品牌车下的车型-对应的品牌折扣系数
    //key carId车型
    //key Array (coefficient系数,lostItem维修的项目)
    mangent1.brandDiscountArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableDictionary *dicDiscount1 = [NSMutableDictionary dictionaryWithCapacity:0];
    [dicDiscount1 setObject:@"1" forKey:@"carId"];
    //对应的车型在不同工项数组
    NSMutableArray *carDiscountArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableDictionary *oneItem1 = [NSMutableDictionary dictionaryWithCapacity:0];
    [oneItem1 setObject:@"0.5" forKey:@"coefficient"];//对应的系数
    [oneItem1 setObject:@"1" forKey:@"partsId"];//对应的配件
    [oneItem1 setObject:@"1" forKey:@"workItem"];//对应的工项
    [carDiscountArray addObject:oneItem1];
    NSMutableDictionary *oneItem2 = [NSMutableDictionary dictionaryWithCapacity:0];
    [oneItem2 setObject:@"0.6" forKey:@"coefficient"];//对应的系数
    [oneItem2 setObject:@"2" forKey:@"partsId"];//对应的工项-对应的工项id
    [oneItem1 setObject:@"1" forKey:@"workItem"];//对应的工项
    [carDiscountArray addObject:oneItem2];
    [dicDiscount1 setObject:carDiscountArray forKey:@"carDiscountArray"];
    
    
    
    [mangent1.brandDiscountArray addObject:dicDiscount1];
    
    
    
    ManagementBrand *mangent2 = [[ManagementBrand alloc] init];
    mangent2.brandId = @"2";
    mangent2.brandName = @"本田";
    
    
    
    //添加经营的品牌
    [factory4S.brandArray addObject:mangent1];
    [factory4S.brandArray addObject:mangent2];
    
    
    
    //初始化参数
    Lostdamage *lost = [[Lostdamage alloc] init];
    lost.carInfo = car;
    lost.factory4S = factory4S;
    lost.lostItemArray = [NSMutableArray arrayWithCapacity:0];//维修的项目
    [self addLostItem:lost];
    
    
    
    [lost.carInfo log];
    [lost.factory4S log];
     
    
    //计算
    [lost calculation];
    
    
    
}



//添加维修的项目
-(void)addLostItem:(Lostdamage *)lost{
    //维修的项目
    LostItem *item = [[LostItem alloc] init];
    item.itemType = ItemType_disassembly;
    item.partsId = @"1";//配件
    item.partsName = @"前保险杠皮";
    item.partsPrice = 1000;
    item.reMark = @"备注";
    item.repairType = 0;//默认是返修
    [lost.lostItemArray addObject:item];
}







@end
