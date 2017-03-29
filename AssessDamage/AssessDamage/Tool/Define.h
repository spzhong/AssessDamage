//
//  Define.h
//  AssessDamage
//
//  Created by 宋培众 on 2017/3/24.
//  Copyright © 2017年 damage. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height

#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)

#define StringNotEmpty(str)                 (str && (str.length > 0))
#define ArrayNotEmpty(arr)                  (arr && (arr.count > 0))

#define DCRGB(r, g, b)                        [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]
#define DCRGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

#define AUTO_WIDTH							((ScreenWidth)*1.0/375)
#define AUTO_HEIGHT							((ScreenHeight)*1.0/667)

#define Iphone4Screen                       ([UIScreen mainScreen].bounds.size.height == 480.0f)
#define Iphone5Screen                       ([UIScreen mainScreen].bounds.size.height == 568.0f)
#define Iphone6Screen                       ([UIScreen mainScreen].bounds.size.height == 667.0f)
#define Iphone6PScreen                      ([UIScreen mainScreen].bounds.size.height == 736.0f)

#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define backItem(aBarButtonItem) UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];backItem.title = @"返回";aBarButtonItem = backItem;
#define Font(A) [UIFont systemFontOfSize:A]

#define SET_IMG_BTN(btn,url) [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@-small1",(url)]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_image"]];

#define SET_IMG(img,url) [(img) sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@-small1",(url)]] placeholderImage:[UIImage imageNamed:@"default_image"]];

#define VCInStoryboard(storyboard, VCID)       [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier:VCID]


#define kThemeColor RGB(33,117,188)

#endif /* Define_h */
