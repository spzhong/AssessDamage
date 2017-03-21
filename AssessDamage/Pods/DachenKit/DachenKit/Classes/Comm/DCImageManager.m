//
//  DCImageManager.m
//  Pods
//
//  Created by 黄登登 on 2017/2/14.
//
//

#import "DCImageManager.h"
#import "DCUtilsMacro.h"
#import "UIImageView+DCKit.h"
#import "DCSysHelper.h"
#import "DCProgressHUD.h"

@implementation DCImageManager

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)dc_shareInstance
{
    static DCImageManager *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self alloc] init];
    });
    return _shareInstance;
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight)];
    self.backgroundColor = [UIColor blackColor];
    
    scrollView_ = [[UIScrollView alloc] initWithFrame:self.frame];
    scrollView_.backgroundColor = [UIColor clearColor];
    scrollView_.pagingEnabled = YES;
    scrollView_.showsHorizontalScrollIndicator = NO;
    scrollView_.delegate = self;
    scrollView_.tag = 1000;
    [self addSubview:scrollView_];
    
    labelNumber_ = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth - 40)/2, ScreenHeight - 30, 40, 20)];
    labelNumber_.textColor = [UIColor whiteColor];
    labelNumber_.backgroundColor = DCRGBA(0, 0, 0, 0.2);
    labelNumber_.font = [UIFont systemFontOfSize:14];
    labelNumber_.textAlignment = NSTextAlignmentCenter;
    labelNumber_.layer.cornerRadius = 3;
    labelNumber_.clipsToBounds = YES;
    [self addSubview:labelNumber_];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTap:)];
    [scrollView_ addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(touchLongPress:)];
    [scrollView_ addGestureRecognizer:longPress];
    
    return self;
}

- (void)dc_showWithImage:(id)image;
{
    labelNumber_.hidden = YES;
    [self dc_showWithImageArr:@[image] index:0];
}

- (void)dc_showWithImageArr:(NSArray *)arrImage index:(NSInteger)intIndex
{
    [scrollView_ removeFromSuperview];
    currentIndex_ = intIndex;
    
    for (int i = 0; i < arrImage.count; i++)
    {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(i * ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.maximumZoomScale = 2.0;
        scrollView.minimumZoomScale = 1.0;
        scrollView.delegate = self;
        [scrollView_ addSubview:scrollView];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        img.tag = 100;
        img.contentMode = UIViewContentModeScaleAspectFit;
        if ([arrImage[i] isKindOfClass:[NSString class]])
        {
            if ([arrImage[i] hasPrefix:@"http"]) {
                
                [MBProgressHUD showHUDAddedTo:img animated:YES];
                [img dc_setImageWithURL:[NSString stringWithFormat:@"%@",arrImage[i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [MBProgressHUD hideHUDForView:img animated:YES];
                }];
                
            }else{
                UIImage *imgs = [[UIImage alloc] initWithContentsOfFile:arrImage[i]];
                img.image = imgs;
            }
        }
        else
        {
            img.image = arrImage[i];
        }
        [scrollView addSubview:img];
    }
    
    scrollView_.contentSize = CGSizeMake(arrImage.count * ScreenWidth, ScreenHeight);
    scrollView_.contentOffset = CGPointMake(intIndex * ScreenWidth, 0);
    labelNumber_.text = [NSString stringWithFormat:@"%ld-%ld",(long)(intIndex + 1),(long)arrImage.count];
    
    [[DCSysHelper dc_getCurrentShowWindow] addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^
     {
         self.alpha = 1;
         
     }];
}

#pragma mark - UITapGestureRecognizer

- (void)touchTap:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
}

#pragma mark - 长按保存图片

- (UIImageView *)currentImageView
{
    UIImageView *imageView = [scrollView_ viewWithTag:currentIndex_ + 100];
    return imageView;
}

- (void)touchLongPress:(UIGestureRecognizer *)gesture
{
    // 长按保存图片
    if (gesture.state == UIGestureRecognizerStateBegan) {
        UIImageView *imageView = [self currentImageView];
        if (imageView.image) {
            UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存", nil];
            [as showInView:self];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        UIImageView *imageView = [self currentImageView];
        UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [DCProgressHUD showHUDText:@"保存失败" image:nil duration:1 inView:self];
    } else {
        [DCProgressHUD showHUDText:@"已保存" image:nil duration:1 inView:self];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [self currentImageView];
}

// 滚动停止时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1000)
    {
        // 滚动页数
        NSInteger count = scrollView.contentSize.width / scrollView.frame.size.width;
        NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
        currentIndex_ = page;
        
        labelNumber_.text = [NSString stringWithFormat:@"%ld-%ld",(long)(page + 1),(long)count];
    }
    
}

@end
