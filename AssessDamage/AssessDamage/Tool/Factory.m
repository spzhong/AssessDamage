//
//  Factory.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/21.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "Factory.h"

@implementation Factory

+(UILabel *)lab:(NSString *)text with:(float)font withFrame:(CGRect)frame with:(UIColor *)color{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    [lab setBackgroundColor:[UIColor clearColor]];
    lab.text = text;
    lab.textColor = color;
    lab.font = Font(font);
    lab.shadowColor = [UIColor grayColor];
    //阴影大小
    lab.shadowOffset = CGSizeMake(.2, .2);
    return lab;
}
@end
