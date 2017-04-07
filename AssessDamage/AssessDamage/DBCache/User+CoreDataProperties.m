//
//  User+CoreDataProperties.m
//  
//
//  Created by 宋培众 on 2017/4/6.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic name;
@dynamic userId;
@dynamic cityId;
@dynamic token;
@dynamic userType;
@dynamic phone;
@dynamic enterpriseId;
@dynamic enterpriseName;
@dynamic cityName;
@dynamic regionId;
@dynamic regionName;

@end
