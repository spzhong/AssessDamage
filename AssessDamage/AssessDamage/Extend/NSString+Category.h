//
//  NSString+Category.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/21.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

// 计算字符串的高度或者宽度
- (CGSize)getStringOfHeight:(NSString *)str
                  strFont:(UIFont *)font
                   CGSize:(CGSize)rectSie;


@end
