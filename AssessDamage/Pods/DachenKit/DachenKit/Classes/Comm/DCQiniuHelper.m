//
//  DCQiniuHelper.m
//  Pods
//
//  Created by 黄登登 on 2017/2/10.
//
//

#import "DCQiniuHelper.h"
#import "DCURLManager.h"
#import "DCBaseRequest.h"

@implementation DCQiniuHelper

+ (NSString *)uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    NSString	*uuidString = [[uuid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return uuidString;
}

+ (NSString *)typeForImageData:(NSData *)data {
    
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
    }
    return nil;
    
}

+ (NSString	*)defaultQiNiuUrlWithPath:(NSString	*)path
{
    NSString *strHost = @"";
    NSInteger hostType = [DCURLManager dc_shareManager].hostType;
    
    switch (hostType) {
        case 1:
        case 7:
            //测试环境
            strHost = [NSString stringWithFormat:@"http://%@.test.file.dachentech.com.cn/",path];
            break;
        case 3:
        case 6:
            //开发环境
            strHost = [NSString stringWithFormat:@"http://%@.dev.file.dachentech.com.cn/",path];
            break;
        case 2:
        case 4:
        case 5:
            //生产环境
            strHost = [NSString stringWithFormat:@"http://%@.file.dachentech.com.cn/",path];
            break;
        default:
            break;
    }
    
    return strHost;
}

/**
 *七牛单获取服务器token方法
 *bucket为空间名
 */
- (void)dc_getQiniuTokenWithBucket:(NSString *)bucket
                       CallBack:(DCQNUpCompletionHandler)callBack{
    
    NSString	    *path = @"im/file/getUpToken.action";
    NSDictionary	*param = @{@"bucket":bucket};

   [DCBaseRequest dc_sendPostRequest:^(XMRequest * _Nonnull request) {
       request.url = HealthAddress(path);
   } callBackBlock:^(BOOL success, id responseObject, NSError *error) {
       if(callBack) callBack(success, responseObject, error);
   }];
    
}

/**
 *七牛通用调用方法  bucket为上传到七牛的对应空间
 *				 fileData为需要上传的文件data
 *				 fileType为需要上传的文件类型 （1代表图片  2代表语音  3代表视频 4其他）
 *		         qiniuToken为上传七牛所需token  可以根据上方法获取
 callBack为需要上传上传成功回调
 */
-(void)dc_qiNiuCommonlyWithBucket:(NSString *)bucket
                      withData:(NSData *)fileData
                      withType:(NSString *)fileType
                    qiniuToken:(NSString *)qiniuToken
                   qiniuDoMain:(NSString *)qiniuDoMain
                      callBack:(DCQNUpCompletionHandler)callBack{
    
    //服务端获取的token
    NSString	*upToken = qiniuToken;
    NSString	*domain = qiniuDoMain;
    
    //生成唯一的uuid成为对应的上传key
    NSString	*uuidKey = [[DCQiniuHelper uuidString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //上传到七牛服务器
    self.upManager = [[QNUploadManager	alloc]init];
    [self.upManager putData:fileData key:uuidKey token:upToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if (resp[@"key"]) {
            //上传成功获取到的七牛url（由key和指定的地址拼接而成）
            NSString	*url;
            if (domain && domain.length > 0) {
                url = [NSString stringWithFormat:@"%@%@",domain,resp[@"key"]];
            }else{
                url = [NSString stringWithFormat:@"%@%@",[DCQiniuHelper defaultQiNiuUrlWithPath:bucket],resp[@"key"]];
            }
            NSMutableDictionary	*callBackDict = [[NSMutableDictionary	alloc]init];
            [callBackDict setValue:url forKey:@"url"];
            [callBackDict setValue:uuidKey forKey:@"uuidKey"];
            if ([fileType integerValue] == qiNiuTypeImage) {//图片回调
                UIImage *image = [UIImage imageWithData:fileData];
                CGSize	size = image.size;
                int width = ceilf(size.width*1.0);
                int height = ceilf(size.height*1.0);
                NSString	*kindImage = [DCQiniuHelper typeForImageData:fileData];
                [callBackDict setValue:[NSString stringWithFormat:@"%d",width] forKey:@"imageWidth"];
                [callBackDict setValue:[NSString stringWithFormat:@"%d",height] forKey:@"imageHeight"];
                [callBackDict setValue:kindImage forKey:@"format"];
                [callBackDict setValue:key forKey:@"key"];
            }else{
                [callBackDict setValue:key forKey:@"key"];
            }
            callBack(YES,callBackDict,nil);
        }else{
            callBack(NO,nil,nil);
        }
    } option:nil];
    
}


/**
 *七牛上传获取上传进度方法  bucket为上传到七牛的对应空间
 *				 fileData为需要上传的文件data
 *				 fileType为需要上传的文件类型 （1代表图片  2代表语音  3代表视频 4其他）
 qiniuToken为上传七牛所需token  可以根据上方法获取
 *				 callBack为需要上传上传成功回调
 *				 progressCallBack为上传进度回调
 */
-(void)dc_qiuNiuUpWithProgressWithBucket:(NSString	*)bucket
                             fileData:(NSData *)fileData
                             fileType:(NSString	*)fileType
                           qiniuToken:(NSString *)qiniuToken
                          qiniuDoMain:(NSString *)qiniuDoMain
                             callBack:(DCQNUpCompletionHandler)callBack
                     progressCallBack:(DCQNProgressCallBack)progressCallBack{
    
    //服务端获取的token
    NSString	*upToken = qiniuToken;
    NSString	*domain = qiniuDoMain;
    
    //生成唯一的uuid成为对应的上传key
    NSString	*uuidKey = [[DCQiniuHelper uuidString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    // 第二步 上传到七牛服务器
    self.upManager = [[QNUploadManager	alloc]init];
    
    //这一步是上传进度回调
    QNUploadOption *opt = [[QNUploadOption alloc]initWithMime:nil progressHandler:^(NSString *key, float percent) {
        progressCallBack(key,percent);
    } params:nil checkCrc:NO cancellationSignal:^BOOL(){
        return self.cancelled;
    }];
    
    //上传是否成功 回调
    [self.upManager putData:fileData key:uuidKey token:upToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if (resp[@"key"] && info.ok) {
            //上传成功获取到的七牛url（由key和指定的地址拼接而成）
            NSString	*url;
            
            if (domain && domain.length > 0) {
                url = [NSString stringWithFormat:@"%@%@",domain,resp[@"key"]];
            }else{
                url = [NSString stringWithFormat:@"%@%@",[DCQiniuHelper	defaultQiNiuUrlWithPath:bucket],resp[@"key"]];
            }
            NSMutableDictionary	*callBackDict = [[NSMutableDictionary	alloc]init];
            [callBackDict setValue:url forKey:@"url"];
            [callBackDict setValue:uuidKey forKey:@"uuidKey"];
            
            if ([fileType integerValue] == qiNiuTypeImage) {//图片回调
                UIImage *image = [UIImage imageWithData:fileData];
                CGSize	size = image.size;
                int width = ceilf(size.width*1.0);
                int height = ceilf(size.height*1.0);
                NSString	*kindImage = [DCQiniuHelper typeForImageData:fileData];
                [callBackDict setValue:[NSString stringWithFormat:@"%d",width] forKey:@"imageWidth"];
                [callBackDict setValue:[NSString stringWithFormat:@"%d",height] forKey:@"imageHeight"];
                [callBackDict setValue:kindImage forKey:@"format"];
                [callBackDict setValue:key forKey:@"key"];
            }else{
                [callBackDict setValue:key forKey:@"key"];
            }
            
            callBack(YES,callBackDict,nil);
        }else{
            NSDictionary  *resp = @{@"key":key};
            callBack(NO,resp,nil);
        }
    } option:opt];
    
}

@end
