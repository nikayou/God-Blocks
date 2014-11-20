//
//  Utils.h
//  God-Blocks
//
//  Created by CAILLOUX NICOLAS on 10/11/2014.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#ifndef UTILS_H
#define UTILS_H

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(float)randFloatBetween:(float)min and:(float)max;
+(int)randIntBetween:(int)min and:(int)max;
+(float)deg2rad:(float)deg;

@end

#endif