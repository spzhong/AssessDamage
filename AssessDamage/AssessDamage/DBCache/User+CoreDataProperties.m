//
//  User+CoreDataProperties.m
//  
//
//  Created by 宋培众 on 2017/3/21.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic name;
@dynamic userId;

@end
