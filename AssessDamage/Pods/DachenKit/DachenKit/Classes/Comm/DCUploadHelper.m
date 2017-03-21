//
//  DCUploadHelper.m
//  Pods
//
//  Created by 黄登登 on 2017/2/14.
//
//

#import "DCUploadHelper.h"
#import "DCFileHelper.h"
#import "DCUtilsMacro.h"
#import "ReactiveCocoa.h"

@interface DCUploadHelper ()

@property (nonatomic, copy) DCUploadCompleteHandler uploadCompleteHandler;
@property (nonatomic, strong) NSMutableArray *filePaths;
@property (nonatomic, strong) NSMutableArray *uploadSuccessKeys;
@property (nonatomic, assign) YMImageSaveType imageSaveType;

@end

@implementation DCUploadHelper

- (id)init {
    self = [super init];
    if (self) {
        _filePaths = [NSMutableArray new];
        _uploadSuccessKeys = [NSMutableArray new];
    }
    return self;
}

- (void)dc_uploadImage:(NSArray *)images
         completion:(DCUploadCompleteHandler)completion
{
    [self dc_uploadImage:images imageSaveType:YMImageSaveTypeShare completion:completion];
}

- (void)dc_uploadImage:(NSArray *)images
      imageSaveType:(YMImageSaveType)imageSaveType
         completion:(DCUploadCompleteHandler)completion
{
    [self dc_uploadImage:images compressionQuality:0.45f maxWidth:960.0f maxHeight:960.0f imageSaveType:imageSaveType completion:completion];
}


- (void)dc_uploadImage:(NSArray *)images
 compressionQuality:(CGFloat)compressionQuality
           maxWidth:(CGFloat)maxWidth
          maxHeight:(CGFloat)maxHeight
      imageSaveType:(YMImageSaveType)imageSaveType
         completion:(DCUploadCompleteHandler)completion
{
    if (!ArrayNotEmpty(images)) {
        if (self.uploadCompleteHandler) self.uploadCompleteHandler(NO, nil, nil);
        return;
    }
    
    self.uploadCompleteHandler = completion;
    self.imageSaveType = imageSaveType;
    
    [self.filePaths removeAllObjects];
    [self.uploadSuccessKeys removeAllObjects];
    
    BOOL isImageSource = [images.firstObject isKindOfClass:[UIImage class]];
    BOOL isFilePathSource = [images.firstObject isKindOfClass:[NSString class]];
    
    if (!isImageSource && !isFilePathSource) {
        if (self.uploadCompleteHandler) self.uploadCompleteHandler(NO, nil, nil);
        return;
    }
    
    if (isImageSource) {
        @weakify(self);
        NSMutableArray *filePaths = [NSMutableArray new];
        [images enumerateObjectsUsingBlock:^(id image, NSUInteger idx, BOOL *stop) {
            [self getImageFilePath:image compressionQuality:compressionQuality maxWidth:maxWidth maxHeight:maxHeight index:idx completetion:^(NSString *filePath) {
                @strongify(self);
                [filePaths addObject:filePath];
                if (filePaths.count == images.count) {
                    [self uploadImages:filePaths];
                }
            }];
        }];
    } else if (isFilePathSource){
        [self uploadImages:images];
    }
}

- (void)uploadImages:(NSArray *)filePaths {
}

- (void)getImageFilePath:(id)image
      compressionQuality:(CGFloat)compressionQuality
                maxWidth:(CGFloat)maxWidth
               maxHeight:(CGFloat)maxHeight
                   index:(NSInteger)index
            completetion:(void (^)(NSString *filePath))completetion
{
    if (!image) {
        if (completetion) {
            completetion(nil);
        }
    }
    
    if ([image isKindOfClass:[NSString class]]) {
        if (completetion) {
            completetion([image copy]);
        }
    } else if ([image isKindOfClass:[UIImage class]]){
        
        // 压缩图片
        CGSize scaleSize=((UIImage *)image).size;
        if (maxHeight > 0 && maxWidth > 0) {
            scaleSize = [self aspectShrinkSize:((UIImage *)image).size maxWidth:maxWidth maxHeight:maxHeight];
        }
        UIImage *thumbnailImage =[self scaleImage:image scaleToSize:scaleSize];
        CGFloat eCompressionQuality = compressionQuality > 0 ? compressionQuality : 1.0f;
        eCompressionQuality = compressionQuality < 1.0f ? compressionQuality : 1.0f;
        NSData *imageData = UIImageJPEGRepresentation(thumbnailImage, eCompressionQuality);
        
        NSString *fileName = [NSString stringWithFormat:@"%@.%@", @([NSDate timeIntervalSinceReferenceDate]), @(index)];
        [DCFileHelper dc_storeImageWithDirectoryType:DCSubDirectoryTypeTemp image:imageData fileName:fileName subDirectory:nil extensionType:@"jpg" callBack:^(BOOL success, NSString *filePath) {
            
            if (success && StringNotEmpty(filePath)) {
                if (completetion) {
                    completetion([filePath copy]);
                }
            } else {
                if (completetion) {
                    completetion(nil);
                }
            }
            
        }];
    }
}

#pragma mark - Util
- (CGSize)aspectShrinkSize:(CGSize)originalSize maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight {
    CGFloat w = originalSize.width;
    CGFloat h = originalSize.height;
    
    if (originalSize.height > originalSize.width) {
        if (originalSize.height > maxHeight) {
            h = maxHeight;
            w = h*originalSize.width / originalSize.height;
        }
    } else if (originalSize.height < originalSize.width) {
        if (originalSize.width > maxWidth) {
            w = maxWidth;
            h = w*originalSize.height / originalSize.width;
        }
    } else if (originalSize.height == originalSize.width) {
        if (originalSize.height > maxHeight) {
            w = maxHeight;
            h = maxHeight;
        }
    }
    
    return CGSizeMake(w, h);
}

- (UIImage *)scaleImage:(UIImage *)image scaleToSize:(CGSize)newSize {
    if (!image) return nil;
    if (newSize.width == 0 || newSize.height == 0) return image;
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *changeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return changeImage;
}

@end
