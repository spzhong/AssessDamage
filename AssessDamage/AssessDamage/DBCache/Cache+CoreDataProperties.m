//
//  Cache+CoreDataProperties.m
//  
//
//  Created by 宋培众 on 2017/3/21.
//
//

#import "Cache+CoreDataProperties.h"

@implementation Cache (CoreDataProperties)

+ (NSFetchRequest<Cache *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Cache"];
}

@dynamic time;
@dynamic userId;
@dynamic cacheUrl;
@dynamic jsonData;

@end
