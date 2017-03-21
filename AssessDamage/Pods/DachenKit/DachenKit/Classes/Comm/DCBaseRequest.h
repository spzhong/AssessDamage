//
//  DCBaseRequestOperator.h
//  Pods
//
//  Created by 黄登登 on 2017/2/14.
//
//

#import <Foundation/Foundation.h>
#import "XMNetworking.h"

#define kDCDefaultTimeout   15.0f
#define ERROR_FAILED         @"网络异常,请稍后再试"
#define NETWORK_FAILED       @"网络异常，请检查您的网络设置"

typedef void (^DCBaseRequestCallBack)(BOOL success,id responseObject,NSError *error);

@interface DCBaseRequest : NSObject

@property(nonatomic,strong) DCBaseRequestCallBack errorCallBack;

+ (instancetype)dc_defaultDCBaseRequest;

+ (void)dc_setupBaseRequest;

+ (void)dc_sendPostRequest:(XMRequestConfigBlock)configBlock
          callBackBlock:(DCBaseRequestCallBack)callBackBlock;

+ (void)dc_sendPostJsonRequest:(XMRequestConfigBlock)configBlock
              callBackBlock:(DCBaseRequestCallBack)callBackBlock;

+ (void)dc_sendGetRequest:(XMRequestConfigBlock)configBlock
         callBackBlock:(DCBaseRequestCallBack)callBackBlock;

+ (void)dc_sendRequest:(XMRequestConfigBlock)configBlock
      callBackBlock:(DCBaseRequestCallBack)callBackBlock;

@end
