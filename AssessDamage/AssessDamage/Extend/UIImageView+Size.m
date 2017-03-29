//
//  UIImageView+Size.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/24.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "UIImageView+Size.h"

@implementation UIImageView (Size)

-(void)autorImgSize{
    UIImage *img = self.image;
    if(img){
        self.frame = CGRectMake(self.getX, self.getY, img.size.width/2,img.size.height/2);
    }else{
        self.frame = CGRectMake(self.getX, self.getY, self.getW, self.getH);
    }
}

@end
