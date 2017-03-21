//
//  Cache+CoreDataProperties.h
//  
//
//  Created by 宋培众 on 2017/3/21.
//
//

#import "Cache+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Cache (CoreDataProperties)

+ (NSFetchRequest<Cache *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) NSString *userId;
@property (nullable, nonatomic, retain) NSString *cacheUrl;
@property (nullable, nonatomic, retain) NSString *jsonData;

@end

NS_ASSUME_NONNULL_END
