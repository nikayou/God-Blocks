//
//  Player.h
//  God-Blocks
//
//  Created by Guest User on 09/11/14.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#ifndef God_Blocks_Player_h
#define God_Blocks_Player_h

#import <Foundation/Foundation.h>

#import <SpriteKit/SpriteKit.h>

#import "Faction.h"
#import "Shooter.h"

static int BASE_HEALTH = 50;
static int SPEED_GAIN = 240;
static int BASE_HEALING = 3.0;
static float DELAY_HEALING = 3.0;
static int BASE_SHOT_SIZE = 10;
static int BASE_SIZE = 32;

@interface Player : Shooter

@property int maxHealth;
@property int health;
@property int healingSpeed;
@property BOOL canHeal;
@property CFTimeInterval delayHeal; // can heal only after 3 seconds without being shot
@property int lives;
@property SKSpriteNode* borderNode;
@property SKSpriteNode* voidNode;
@property SKSpriteNode* colorNode;
// this is the actual speed
@property () CGVector moveSpeed;

-(void)update:(CFTimeInterval)dt;

-(void)changeSpeed:(CGVector)speed;

-(int)loseHealth:(int)amount;

+(Player*)createWithFaction:(Faction)faction;

@end

#endif
