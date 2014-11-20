//
//  Color.h
//  God-Blocks
//
//  Created by Guest User on 09/11/14.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#ifndef God_Blocks_Color_h
#define God_Blocks_Color_h

#import "Faction.h"

#import <SpriteKit/SpriteKit.h>

@interface Color : NSObject

+(NSColor*)convertRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

+(NSColor*)getFactionColor:(Faction)faction;

@end

#endif
