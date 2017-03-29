//
//  BaseM.m
//  AssessDamage
//
//  Created by qj0714 on 17/3/19.
//  Copyright © 2017年 damage. All rights reserved.
//

#import "BaseM.h"
#import <objc/runtime.h>
#import "NSObject+Property.h"
#import "XMNetworking.h"
#import "Cache+CoreDataClass.h"


@implementation BaseM

//获取数据
-(void)getData:(NSString *)url withPostDic:(NSMutableDictionary *)dic
                            isReadFromCache:(BOOL)isCache
                            withBlock:(FinishedGetData)back{
    //进行网络请求
    NSDictionary *config = [Tool readConfigWithKey:url];
    NSString *className = config[@"model"];
    BOOL isNeedCache = [config[@"isNeedCache"] boolValue];
    //配置是否需要缓存
    if (!isNeedCache) {
        [self readDataFromNetWork:url withPostDic:dic isisNeedCache:NO withBlock:^(BOOL success, id rep) {
            back(success,rep);
        } withClassName:className];
    }else{
        //是否读取缓存
        if (isCache) {
            //从数据库中读取数据
            Cache *cache = (Cache *)[CoreData selcet_OneData:@"Cache" withWhere_id:[NSString stringWithFormat:@"userId='%@' and cacheUrl='%@'",@"song3",url]];
            if (cache) {
                NSString *jsonString = cache.jsonData;
                [self createModel:className withDic:[Tool dictionaryWithJsonString:jsonString]];
            }else{
                //从服务器上拿去数据
                [self readDataFromNetWork:url withPostDic:dic isisNeedCache:YES withBlock:^(BOOL success, id rep) {
                    back(success,rep);
                }withClassName:className];
            }
        }else{//从服务器上拉去数据
            [self readDataFromNetWork:url withPostDic:dic isisNeedCache:YES withBlock:^(BOOL success, id rep) {
                back(success,rep);
            }withClassName:className];
        }
    }
    
}


//从网络上拉去数据
-(void)readDataFromNetWork:(NSString *)url withPostDic:(NSMutableDictionary *)dic
           isisNeedCache:(BOOL)isCache
                 withBlock:(FinishedGetData)back
             withClassName:(NSString *)className{
    //发送网络的请求
    [DCBaseRequest dc_setupBaseRequest];
    [DCBaseRequest dc_sendPostRequest:^(XMRequest *request) {
        request.url = url;
        request.parameters = dic;
    } callBackBlock:^(BOOL success, id responseObject, NSError *error) {
        
        success = YES;
        responseObject = [NSArray arrayWithObjects:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"123",@"pId",@"位置",@"key", nil], nil];
         
        //成功
        if (success) {
            id req = responseObject;
            //需要缓存
            if (isCache) {
                Cache *cache = (Cache *)[CoreData creat_coredata:@"Cache" withWhere_id:[NSString stringWithFormat:@"userId='%@' and cacheUrl='%@'",@"song3",url]];
                cache.userId = @"song3";
                cache.cacheUrl = url;
                cache.jsonData = [Tool dictionaryToJson:req];
                cache.time = [NSDate date];
                [CoreData save_coredata];
            }
            //创建model
            id object = [self createModel:className withDic:req];
            back(false,object);
        }else{
            back(false,nil);
        }
        
    }];
    
}



-(id)createModel:(NSString*)className withDic:(id)reqDic{
    
    Class c = NSClassFromString(className);
    if (c==NULL) {
        NSLog(@"数据模型转化失败--没有对应的model，就直接返回字典了");
        return reqDic;
    }
    if ([reqDic isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        for (NSMutableDictionary *dic in reqDic) {
            id<BaseMDelagete> model = [[c alloc] init];
            if ([model respondsToSelector:@selector(createModel:)]) {
                [model createModel:dic];
                [array addObject:model];
            }
        }
        return array;
    }else if ([reqDic isKindOfClass:[NSDictionary class]]){
        id<BaseMDelagete> model = [[c alloc] init];
        if ([model respondsToSelector:@selector(createModel:)]) {
            [model createModel:reqDic];
            return model;
        }
    }else{
        //其它类型的string
        NSLog(@"注意此时的数据结果可能有问题，导致数据异常");
        return reqDic;
    } 
    return nil;
}


//释放model
-(void)freeModel{
    NSArray *array = [self getAllProperties];
    for (NSString *propertyName in array) {
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if ([propertyValue isKindOfClass:[NSArray class]]) {
            [propertyValue removeAllObjects];
        }
        propertyValue = nil;
    }
}


//清空缓存
+(void)clearCache:(NSString *)className{
    //清空缓存
    Cache *cache = (Cache *)[CoreData selcet_OneData:@"Cache" withWhere_id:[NSString stringWithFormat:@"userId='%@' and model='%@'",CurrUser.userId,className]];
    if (cache) {
        [CoreData delete_Data:cache];
        [CoreData save_coredata];
    }else{
        NSLog(@"清空缓存异常了啊！！！");
    }
}




@end
