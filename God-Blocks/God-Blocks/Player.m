//
//  Player.m
//  God-Blocks
//
//  Created by Guest User on 09/11/14.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Player.h"
#import "Color.h"
#import "Bitmasks.h"
#import "GameScene.h"

@implementation Player


- (Player *)initWithFaction:(Faction)faction {
    self = [super init];
    CGSize s = CGSizeMake(BASE_SIZE, BASE_SIZE);
    // settings
    self.faction = faction;
    self.canHeal = YES;
    self.delayHeal = 0;
    // setting physics
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:s];
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.categoryBitMask = PLAYER;
    self.physicsBody.contactTestBitMask = faction;
    self.physicsBody.collisionBitMask = SHOT | BORDER;
    NSColor * c = [Color getFactionColor:faction];
    // setting graphics
    self.colorNode = [SKSpriteNode spriteNodeWithColor:c size:s];
    self.borderNode = [SKSpriteNode spriteNodeWithColor:[NSColor blackColor] size:CGSizeMake(BASE_SIZE*1.2, BASE_SIZE*1.2)];
    self.voidNode = [SKSpriteNode spriteNodeWithColor:[NSColor whiteColor] size:s];
    [self addChild:self.borderNode];
    [self addChild:self.voidNode];
    [self addChild:self.colorNode];
    return self;
}

- (void)update:(CFTimeInterval)dt {
    CGPoint newPosition = CGPointMake(self.position.x + (self.moveSpeed.dx * dt), self.position.y + (self.moveSpeed.dy * dt));
    self.position = newPosition;
    if (!self.canHeal) {
        self.delayHeal -= dt;
        if (self.delayHeal <= 0)
            self.canHeal = YES;
    }
    if (self.canHeal && self.health < self.maxHealth) {
        [self gainHealth:self.healingSpeed*dt];
    }
}

-(int)gainHealth:(int)amount {
    int diff = self.maxHealth - self.health;
    if (diff < amount)
        amount = diff;
    self.health += amount;
    [self showHealth];
    return self.health;
}


-(int)loseHealth:(int)amount {
    self.canHeal = NO;
    self.delayHeal = DELAY_HEALING;
    self.health -= amount;
    if (self.health <= 0)
        [self death];
    else
        [self showHealth];
    return (self.health);
}

-(void)death {
    self.lives -= 1;
    if (self.lives <= 0) {
        //TODO : this is really ugly, observers should do the trick
        [(GameScene*)self.scene gameOver];
        
    } else {
        self.health = self.maxHealth;
        [(GameScene*)self.scene loseLife];
        self.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2);
    }
}

-(int)showHealth{
    float ratio = (float)self.health / (float)self.maxHealth;
    int newSize = BASE_SIZE * ratio;
    self.colorNode.size = CGSizeMake(newSize, newSize);
    return self.health;
}


-(void)changeSpeed:(CGVector)speed {
    
    self.moveSpeed = CGVectorMake(speed.dx * SPEED_GAIN, speed.dy * SPEED_GAIN);
}

+(Player*)createWithFaction:(Faction)faction {
    Player * instance = [[Player alloc] initWithFaction:faction];
    instance.moveSpeed = CGVectorMake(0,0);
    if (faction == JUPITER) {
        instance.lives = 3;
    } else {
        instance.lives = 2;
    }
    if (faction == MARS) {
        instance.strength = BASE_STRENGTH * 1.5;
    } else {
        instance.strength = BASE_STRENGTH;
    }
    if (faction == VENUS) {
        instance.healingSpeed = BASE_HEALING;
    } else {
        instance.healingSpeed = BASE_HEALING / 1.5;
    }
    if (faction == DIANA) {
        instance.nbShots = 3;
    } else {
        instance.nbShots = 1;
    }
    if (faction == APOLLO) {
        instance.shotSize = BASE_SHOT_SIZE * 1.5;
    } else {
        instance.shotSize = BASE_SHOT_SIZE;
    }
    if (faction == NEPTUNE) {
        instance.maxHealth = BASE_HEALTH * 1.5;
    } else {
        instance.maxHealth = BASE_HEALTH;
    }
    instance.health = instance.maxHealth;
    return instance;
}

@end
