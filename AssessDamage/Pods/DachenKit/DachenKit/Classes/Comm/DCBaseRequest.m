//
//  DCBaseRequestOperator.m
//  Pods
//
//  Created by 黄登登 on 2017/2/14.
//
//

#import "DCBaseRequest.h"
#import "DCUtilsMacro.h"

@implementation DCBaseRequest

+ (instancetype)dc_defaultDCBaseRequest{
    static DCBaseRequest *DCBaseRequest_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (DCBaseRequest_ == nil) {
            DCBaseRequest_ = [[self alloc] init];
        }
    });
    return DCBaseRequest_;
}

+ (void)dc_setupBaseRequest{
    
    [XMCenter setupConfig:^(XMConfig *config) {
        config.generalHeaders = @{@"access_token": @"guest_ddee605f662b48e9867414b387dd6b13"};
        config.generalParameters = @{@"model": @"iOS",@"device":@"iPhone"};
        config.generalUserInfo = nil;
        config.callbackQueue = dispatch_get_main_queue();
        config.engine = [XMEngine sharedEngine];
#ifdef DEBUG
        config.consoleLog = YES;
#endif
    }];
    
}

+ (void)dc_sendPostRequest:(XMRequestConfigBlock)configBlock
          callBackBlock:(DCBaseRequestCallBack)callBackBlock{
    
    XMRequestConfigBlock requestBlock = ^(XMRequest *request){
        configBlock(request);
        request.httpMethod = kXMHTTPMethodPOST;
    };
    
    [self dc_sendRequest:requestBlock callBackBlock:callBackBlock];
}

+ (void)dc_sendPostJsonRequest:(XMRequestConfigBlock)configBlock
              callBackBlock:(DCBaseRequestCallBack)callBackBlock{
    
    XMRequestConfigBlock requestBlock = ^(XMRequest *request){
        configBlock(request);
        request.httpMethod = kXMHTTPMethodPOST;
        request.requestSerializerType = kXMRequestSerializerJSON;
        request.responseSerializerType = kXMResponseSerializerJSON;
    };
    
    [self dc_sendRequest:requestBlock callBackBlock:callBackBlock];
    
}

+ (void)dc_sendGetRequest:(XMRequestConfigBlock)configBlock
         callBackBlock:(DCBaseRequestCallBack)callBackBlock{
    
    XMRequestConfigBlock requestBlock = ^(XMRequest *request){
        configBlock(request);
        request.httpMethod = kXMHTTPMethodGET;
    };
    
    [self dc_sendRequest:requestBlock callBackBlock:callBackBlock];
}

+ (void)dc_sendRequest:(XMRequestConfigBlock)configBlock
      callBackBlock:(DCBaseRequestCallBack)callBackBlock{
    
    if(![[XMCenter defaultCenter] isNetworkReachable]){
        if(callBackBlock) callBackBlock(NO, @{@"resultCode":@"99999",@"resultMsg":NETWORK_FAILED}, nil);
        return;
    }
    
    [XMCenter sendRequest:configBlock onSuccess:^(id  _Nullable responseObject) {
        if(callBackBlock) callBackBlock(YES, responseObject, nil);
        // 不知道 返回 YES or NO
        [DCBaseRequest dc_defaultDCBaseRequest].errorCallBack(NO, @{@"resultCode":@"0",@"resultMsg":ERROR_FAILED},nil);
    } onFailure:^(NSError * _Nullable error) {
        if(callBackBlock) callBackBlock(NO, @{@"resultCode":@"0",@"resultMsg":ERROR_FAILED},error);
    }];
    
}

@end
