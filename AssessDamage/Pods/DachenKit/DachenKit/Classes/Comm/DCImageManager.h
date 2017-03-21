//
//  DCImageManager.h
//  Pods
//
//  Created by 黄登登 on 2017/2/14.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface DCImageManager : UIView<UIScrollViewDelegate, UIActionSheetDelegate>
{
    UIScrollView        *scrollView_;
    UILabel             *labelNumber_;
    NSInteger           currentIndex_;
}

+ (instancetype) dc_shareInstance;

- (void)dc_showWithImage:(id)image;
- (void)dc_showWithImageArr:(NSArray *)arrImage index:(NSInteger)intIndex;


@end
