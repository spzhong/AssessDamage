//
//  DCFileHelper.m
//  Pods
//
//  Created by 黄登登 on 2017/2/13.
//
//

#import "DCFileHelper.h"
#include <sys/xattr.h>

@implementation DCFileHelper

+ (instancetype)dc_defaultDCFileHelper
{
    static DCFileHelper *DCFileHelper_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (DCFileHelper_ == nil) {
            DCFileHelper_ = [[self alloc] init];
        }
    });
    return DCFileHelper_;
}

+ (void)dc_initAPPRootPath{
    [self dc_createFilepath:[self dc_filepathAtRoot:nil]];
}

//判断文件(夹)是否存在
+(BOOL)dc_targetExist:(NSString *)filepath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filepath];
}

+(void)dc_createFilepath:(NSString *)filepath
{
    if(filepath.length<=0)
    {
        return;
    }
    if(![self dc_targetExist:filepath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:filepath])
        {
            [fileManager createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error:nil];
            [self addSkipBackupAttributeToTarget:filepath];
        }
    }
}

+(NSString *)dc_filepathAtCaches:(NSString *)file
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *rootDirectory=[DCFileHelper getSubDirectoryWithType:DCSubDirectoryTypeCache];
    return [[documentsDirectory stringByAppendingPathComponent:rootDirectory] stringByAppendingPathComponent:file];
}

+(NSString *)dc_filepathAtRoot:(NSString *)file
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [[documentsDirectory stringByAppendingPathComponent:@"IM"] stringByAppendingPathComponent:file];
}

+(NSString *)dc_filepathAtRes:(NSString *)file
{
    //Resources目录
    return [[NSBundle mainBundle] pathForResource:file ofType:nil];
}

+(NSString *)dc_filepathAtDoc:(NSString *)file
{
    //Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:file];
}


+(void)addSkipBackupAttributeToTarget:(NSString *)filepath
{
    const char *fp = [filepath cStringUsingEncoding:NSUTF8StringEncoding];
    
    const char *attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    setxattr(fp,attrName,&attrValue,sizeof(attrValue),0,0);
}

+(NSArray *)dc_filelistAtPath:(NSString *)filepath
{
    NSMutableArray *filelistAry = nil;
    if([self dc_targetExist:filepath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        filelistAry = [[NSMutableArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:filepath error:nil]];
        for(NSString *item in filelistAry)
        {
            if([item isEqual:@".DS_Store"])
            {
                [filelistAry removeObject:item];
                break;
            }
        }
    }
    return filelistAry;
}

//删除目标文件
+(void)dc_deleteTargetAtPath:(NSString *)filepath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager isDeletableFileAtPath:filepath])
    {
        [fileManager removeItemAtPath:filepath error:nil];
    }
}

+(void)dc_moveTargetAtPath:(NSString *)path1 toPath:(NSString *)path2
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([self dc_targetExist:path1])
    {
        [fileManager moveItemAtPath:path1 toPath:path2 error:nil];
    }
}

+(void)dc_copyTargetAtPath:(NSString *)path1 toPath:(NSString *)path2
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([self dc_targetExist:path1])
    {
        [fileManager copyItemAtPath:path1 toPath:path2 error:nil];
    }
}

//优先获取Documents资源
+(NSString *)dc_filepathAtDocOrRes:(NSString *)file
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:[DCFileHelper dc_filepathAtDoc:file]])
    {
        //NSLog(@"Documents目录");
        return [self dc_filepathAtDoc:file];
    }
    else if([fileManager fileExistsAtPath:[self dc_filepathAtRes:file]])
    {
        //NSLog(@"Resources目录");
        return [self dc_filepathAtRes:file];
    }
    else
    {
        NSLog(@"Documents/Resources目录均无目标文件:%@",file);
        return nil;
    }
}

+ (void)dc_storeImageWithDirectoryType:(DCSubDirectoryType)directoryType
                              image:(id)image
                           fileName:(NSString *)fileName
                       subDirectory:(NSString *)subDirectory
                      extensionType:(NSString *)extensionType
                           callBack:(void (^)(BOOL success, NSString *filePath))callBack
{
    if (!image) return;
    
    NSString *filePath = [DCFileHelper dc_setFilePathWithDirectoryType:directoryType subDirectory:subDirectory fileName:fileName extensionType:extensionType];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = nil;
        if ([image isKindOfClass:[NSData class]]) {
            data = image;
        }else if ([image isKindOfClass:[UIImage class]]){
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        
        if (data) {
            // Can't use defaultManager another thread
            NSFileManager *fileManager = NSFileManager.new;
            BOOL ret = [fileManager createFileAtPath:filePath contents:data attributes:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (callBack) {
                    callBack(ret, filePath);
                }
            });
        }
    });
}

+ (NSString *)dc_setFilePathWithDirectoryType:(DCSubDirectoryType)subDirectoryType
                              subDirectory:(NSString *)subDirectory
                                  fileName:(NSString *)fileName
                             extensionType:(NSString *)extensionType
{
    NSString *rootDirectory=[DCFileHelper getSubDirectoryWithType:subDirectoryType];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (subDirectory) {
        rootDirectory = [rootDirectory stringByAppendingPathComponent:subDirectory];
        if (![fileManager fileExistsAtPath:rootDirectory]) {
            [fileManager createDirectoryAtPath:rootDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
        }
    }
    
    NSString *path = nil;
    if (extensionType) {
        path = [[rootDirectory stringByAppendingPathComponent:fileName] stringByAppendingPathExtension:extensionType];
    } else {
        path = [rootDirectory stringByAppendingPathComponent:fileName];
    }
    
    return path;
}

+ (NSString *)getSubDirectoryWithType:(DCSubDirectoryType)type {
    
    NSString *subDirectoryPath = nil;
    switch (type) {
        case DCSubDirectoryTypeHome:
        {
            subDirectoryPath = NSHomeDirectory();
            break;
        }
        case DCSubDirectoryTypeDocuments:
        {
            subDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            break;
        }
        case DCSubDirectoryTypeTemp:
        {
            subDirectoryPath = NSTemporaryDirectory();
            break;
        }
        case DCSubDirectoryTypeCache:
        {
            subDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            break;
        }
            
        default:
            break;
    }
    
    return subDirectoryPath;
}

@end
