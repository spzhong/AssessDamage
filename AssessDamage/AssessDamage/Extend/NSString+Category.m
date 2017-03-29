//
//  NSString+Category.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/21.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

// 计算字符串的高度或者宽度
- (CGSize)getStringOfHeight:(NSString *)str
                    strFont:(UIFont *)font
                     CGSize:(CGSize)rectSie{
    if (str== nil && str.length==0) {
        str = @"";
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [str boundingRectWithSize:rectSie options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

@end
