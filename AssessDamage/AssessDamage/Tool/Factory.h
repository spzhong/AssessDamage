//
//  Factory.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/21.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject

+(UILabel *)lab:(NSString *)text with:(float)font withFrame:(CGRect)frame with:(UIColor *)color;


@end
