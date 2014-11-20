//
//  Color.m
//  God-Blocks
//
//  Created by Guest User on 09/11/14.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Color.h"

@implementation Color

+(NSColor*)convertRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    CGFloat r = red / 255;
    CGFloat g = green / 255;
    CGFloat b = blue / 255;
    return [NSColor colorWithRed:r green:g blue:b alpha:1.0];
}

// TODO: no need to compute everytime. Maybe storing values?
+(NSColor*)getFactionColor:(Faction)faction {
    switch (faction) {
        case MARS :
            return [Color convertRed:178 green:34 blue:34 ];
        case VENUS:
            return [Color convertRed:218 green:112 blue:214 ];
        case DIANA :
            return [Color convertRed:107 green:142 blue:35 ];
        case APOLLO :
            return [Color convertRed:218 green:165 blue:32 ];
        case NEPTUNE :
            return [Color convertRed:65 green:105 blue:255 ];
        case JUPITER : 
            return [Color convertRed:50 green:50 blue:50 ];
        default :
            return [NSColor greenColor];
    }
}

@end
