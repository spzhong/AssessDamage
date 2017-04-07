//
//  ErrorLog+CoreDataProperties.h
//  
//
//  Created by 宋培众 on 2017/3/31.
//
//

#import "ErrorLog+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ErrorLog (CoreDataProperties)

+ (NSFetchRequest<ErrorLog *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *time;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *postDicString;
@property (nullable, nonatomic, copy) NSString *errorLog;
@property (nullable, nonatomic, copy) NSString *des;


@end

NS_ASSUME_NONNULL_END
