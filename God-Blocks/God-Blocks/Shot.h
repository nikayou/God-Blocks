//
//  Shot.h
//  God-Blocks
//
//  Created by Guest User on 09/11/14.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#ifndef God_Blocks_Shot_h
#define God_Blocks_Shot_h


#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Faction.h"
#import "Shooter.h"

@interface Shot : SKNode

// shots do not harm the same faction as the sender
@property Faction faction;
@property int strength;
@property SKSpriteNode * graphics;

+(Shot *)createBy:(Shooter*)who
        direction:(CGVector)direction;
+(Shot *)createBy:(Shooter*)who
             from:(CGPoint)from
        direction:(CGVector)direction;
@end 

#endif
