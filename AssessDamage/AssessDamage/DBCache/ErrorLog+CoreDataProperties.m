//
//  ErrorLog+CoreDataProperties.m
//  
//
//  Created by 宋培众 on 2017/3/31.
//
//

#import "ErrorLog+CoreDataProperties.h"

@implementation ErrorLog (CoreDataProperties)

+ (NSFetchRequest<ErrorLog *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ErrorLog"];
}

@dynamic time;
@dynamic url;
@dynamic userId;
@dynamic postDicString;
@dynamic errorLog;

@end
