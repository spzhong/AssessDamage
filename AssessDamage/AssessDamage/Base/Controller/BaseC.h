//
//  BaseC.h
//  AssessDamage
//
//  Created by qj0714 on 17/3/19.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseV.h"

@interface BaseC : UIViewController

@property(nonatomic,strong)NSMutableArray<BaseV *>* dataArray;

-(BaseV *)defaultModel;

@end
