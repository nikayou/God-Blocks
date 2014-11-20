//
//  Shot.m
//  God-Blocks
//
//  Created by Guest User on 09/11/14.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Shot.h"
#import "Color.h"
#import "Bitmasks.h"

@implementation Shot

-(Shot*)init{
    self = [super init];
    self.graphics = [[SKSpriteNode alloc]init];
    return self;
}

+(Shot *)createBy:(Shooter*)who direction:(CGVector)direction{
    Shot * instance = [[Shot alloc] init];
    instance.faction = who.faction;
    instance.strength = who.strength;
    instance.graphics.color = [Color getFactionColor:who.faction];
    CGSize size = CGSizeMake(who.shotSize, who.shotSize);
    instance.graphics.size = size;
    instance.position = who.position;
    // setting physics
    instance.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
    instance.physicsBody.categoryBitMask = SHOT;
    instance.physicsBody.collisionBitMask = PLAYER | ENEMY | SHOT | BORDER;
    instance.physicsBody.contactTestBitMask = instance.faction;
    //instance.physicsBody.dynamic = NO;
    // setting movement
    SKAction * move = [SKAction moveBy:direction duration:0.5];
    [instance runAction:[SKAction repeatActionForever:move]];
    [instance addChild:instance.graphics];
    return instance;
}

+(Shot *)createBy:(Shooter*)who from:(CGPoint)from
        direction:(CGVector)direction{
    Shot * instance = [Shot createBy:who direction:direction];
    instance.position = from;
    return instance;
}


@end
