//
//  UIImageView+Size.m
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/24.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "UIImageView+Size.h"
#import "UIView+Category.h"


@implementation UIImageView (Size)

-(void)autorImgSize{
    UIImage *img = self.image;
    if(img){
        self.frame = CGRectMake(self.origin.x, self.origin.y, img.size.width/2,img.size.height/2);
    }else{
        self.frame = CGRectMake(self.origin.x, self.origin.y, self.size.width, self.size.height);
    }
}

@end
