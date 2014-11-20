//
//  Utils.m
//  God-Blocks
//
//  Created by CAILLOUX NICOLAS on 10/11/2014.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(float)randFloatBetween:(float)min and:(float)max {
    float r = arc4random_uniform(max-min);
    return r + min;
}

+(int)randIntBetween:(int)min and:(int)max {
    int r = arc4random_uniform(max-min);
    return r + min;
}

+(float)deg2rad:(float)deg {
    return (deg / 180) * M_PI;
}

@end
