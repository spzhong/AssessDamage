//
//  UILabel+Category.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/24.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

-(void)addLineUp{
    UIView *lineTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.size.width, 0.5)];
    lineTop.backgroundColor = RGB(201, 201, 201);
    [self addSubview:lineTop];
}

-(void)addLineBom{
    UIView *lineBottom = [[UIView alloc]initWithFrame:CGRectMake(0, self.size.height - 0.5, self.size.width, 0.5)];
    lineBottom.backgroundColor = RGB(201, 201, 201);;
    [self addSubview:lineBottom];
}




@end
