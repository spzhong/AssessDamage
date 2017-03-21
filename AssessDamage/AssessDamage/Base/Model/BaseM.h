//
//  BaseM.h
//  AssessDamage
//
//  Created by qj0714 on 17/3/19.
//  Copyright © 2017年 damage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCBaseRequest.h"


typedef void(^FinishedGetData)(BOOL success,id rep);

@protocol BaseMDelagete <NSObject>

//创建model
-(void)createModel:(NSMutableDictionary *)dic;


@end



@interface BaseM : NSObject

//抽象出来的共属性
@property(nonatomic,retain)NSString *mId;//id
@property(nonatomic,retain)NSMutableArray<BaseM *> *subModelArray;//数组


//获取数据
-(void)getData:(NSString *)url withPostDic:(NSMutableDictionary *)dic
                            isReadFromCache:(BOOL)isCache
                        withBlock:(FinishedGetData)back;


//释放model
-(void)freeModel;






@end
