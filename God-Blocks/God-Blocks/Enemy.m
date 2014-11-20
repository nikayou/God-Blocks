//
//  Enemy.m
//  God-Blocks
//
//  Created by Guest User on 09/11/14.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#import "Enemy.h"
#import "Color.h"
#import "Shot.h"
#import "Utils.h"
#import "Bitmasks.h"
#import "GameScene.h"

@implementation Enemy


-(Enemy *)initWithFaction:(Faction)faction size:(int)size{
    self = [super init];
    self.faction = faction;
    self.shotSize = size/2;
    self.strength = BASE_STRENGTH;
    // setting graphics
    CGSize ssize = CGSizeMake(size, size);
    self.colorNode = [SKSpriteNode spriteNodeWithColor:[Color getFactionColor:faction] size:ssize];
    self.borderNode = [SKSpriteNode spriteNodeWithColor:[NSColor blackColor] size:CGSizeMake(size * 1.2, size * 1.2)];
    self.voidNode = [SKSpriteNode spriteNodeWithColor:[NSColor whiteColor] size:ssize];
    [self addChild:self.borderNode];
    [self addChild:self.voidNode];
    [self addChild:self.colorNode];
    // setting stats
    self.health = size * 1.5;
    self.maxHealth = self.health;
    // setting physics
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ssize];
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = ENEMY;
    self.physicsBody.collisionBitMask = SHOT | PLAYER;
    self.physicsBody.contactTestBitMask = faction;
    return self;
}

-(void)update:(CFTimeInterval)dt {
    self.nextShot -= dt;
    // shooting
    if (self.nextShot <= 0){
        [self shoot];
        self.nextShot = self.rate;
    }
    // moving
}

-(void)changeTarget:(SKNode*)tar {
    self.target = tar;
}

-(int)loseHealth:(int)amount {
    self.health -= amount;
    if (self.health <= 0) {
        [self death];
    }
    // updating health "gauge"
    float ratio = (float)self.health / (float)self.maxHealth;
    int newSize = self.colorNode.size.width * ratio;
    self.colorNode.size = CGSizeMake(newSize, newSize);
    // when an enemy loses health, itsspeed changes
    float randSpeed = self.speed * 0.8;
    [self changeSpeed:randSpeed];
    return self.health;
}

-(void)changeSpeed:(float)amount {
    self.speed = amount;
    [self.rotationCenter removeAllActions];
    SKAction* rotation = [SKAction repeatActionForever:[SKAction rotateByAngle:[Utils deg2rad:self.speed] duration:1]];
    [self.rotationCenter runAction:rotation];
    
}

-(void)death {
    //TODO : this is really ugly, observers should do the trick
    [(GameScene*)self.scene removeEnemy:self];
}

-(void)shoot{
    CGPoint targetPos = self.target.position;
    CGPoint origin = [self.parent convertPoint:self.position toNode:self.scene];
    float speedRand = [Utils randFloatBetween:0.4 and:1.2];
    int x = targetPos.x - origin.x;
    int y = targetPos.y - origin.y;
    CGVector direction = CGVectorMake(x*speedRand, y*speedRand);
    Shot * shot = [Shot createBy:self from:origin direction:direction];
    [self.rotationCenter.parent addChild:shot];
}

+(Enemy *)createOfFaction:(Faction)faction
                     size:(int)size
                    speed:(int)speed
                   center:(SKNode*)center
{
    Enemy * instance = [[Enemy alloc] initWithFaction:faction size:size];
    // setting AI
    instance.rate = size * 0.2;
    instance.nextShot = instance.rate * 2;
    instance.rotationCenter = center;
    [instance.rotationCenter addChild:instance];
    [instance changeSpeed:speed];
    return instance;
}

@end
