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

//重新返回的按钮
- (void)rewriteBackButton;

//点击导航右边的按钮
-(void)rewriteRightNav_title:(NSString *)title withBlock:(void (^)())touch;

//点击导航右边的按钮
-(void)rewriteLeftNav_title:(NSString *)title withBlock:(void (^)())touch;


@end
