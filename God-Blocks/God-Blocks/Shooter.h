//
//  Shooter.h
//  God-Blocks
//
//  Created by CAILLOUX NICOLAS on 10/11/2014.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "Faction.h"

static int BASE_STRENGTH = 10;

@interface Shooter : SKNode

@property Faction faction;
@property int strength;
@property int nbShots;
@property int shotSize;


@end
