//
//  NSTimer+PauseTimerEMDT.m
//  BitesOfCities
//
//  Created by jimple on 14-4-3.
//  Copyright (c) 2014年 __Eventor__. All rights reserved.
//

#import "NSTimer+PauseTimerEMDT.h"

@implementation NSTimer (PauseTimer)

-(void)pauseTimer
{
    if (![self isValid])
    {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid])
    {
        return ;
    }
    
    [self setFireDate:[NSDate date]];
}


@end
