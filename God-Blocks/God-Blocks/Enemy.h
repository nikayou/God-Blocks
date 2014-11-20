//
//  Enemy.h
//  God-Blocks
//
//  Created by Guest User on 09/11/14.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SpriteKit/SpriteKit.h>

#import "Faction.h"
#import "Player.h"
#import "Item.h"

static float MIN_SPEED = 15.0;
static float MAX_SPEED = 90.0;

@interface Enemy : Shooter

/* health represents 2 concepts :
 - the more health he has, the bigger he is
 - the more health he has, the more score it gives
 */
@property () int health;
@property () int maxHealth;
@property () CFTimeInterval nextShot; // time remaining until next shot
@property () float rate; // minimum average time between two shots
@property Faction faction;
@property SKSpriteNode* borderNode;
@property SKSpriteNode* voidNode;
@property SKSpriteNode* colorNode;
@property SKNode* target;
@property SKNode* rotationCenter;

-(void)update:(CFTimeInterval)dt;
-(void)changeTarget:(SKNode*)tar;
-(int)loseHealth:(int)amount;
+(Enemy *)createOfFaction:(Faction)faction
                     size:(int)size
                    speed:(int)speed
                   center:(SKNode *)center;

@end
