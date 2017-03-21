//
//  NSArray+DCKit.m
//  Pods
//
//  Created by 黄登登 on 2017/2/10.
//
//

#import "NSArray+DCKit.h"

@implementation NSArray (DCKit)

- (NSString *)dc_arrayToJson
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
