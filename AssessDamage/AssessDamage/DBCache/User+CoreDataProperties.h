//
//  User+CoreDataProperties.h
//  
//
//  Created by 宋培众 on 2017/4/6.
//
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *cityId;
@property (nullable, nonatomic, copy) NSString *token;
@property (nullable, nonatomic, copy) NSString *userType;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSString *enterpriseId;
@property (nullable, nonatomic, copy) NSString *enterpriseName;
@property (nullable, nonatomic, copy) NSString *cityName;
@property (nullable, nonatomic, copy) NSString *regionId;
@property (nullable, nonatomic, copy) NSString *regionName;

@end

NS_ASSUME_NONNULL_END
