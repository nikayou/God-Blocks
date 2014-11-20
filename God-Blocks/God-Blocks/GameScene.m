//
//  GameScene.m
//  God::Blocks
//
//  Created by CAILLOUX NICOLAS on 06/11/2014.
//  Copyright (c) 2014 CAILLOUX_Nicolas. All rights reserved.
//

#import "GameScene.h"

#import "Player.h"
#import "Enemy.h"

#import "GameScene.h"
#import "Utils.h"
#import "Bitmasks.h"
#import "Menu.h"

@implementation GameScene


-(void) initPlayer:(Faction)faction {
    self.player = [Player createWithFaction:faction];
    [self addChild:self.player];
}

-(id)initWithSize:(CGSize)size character:(Faction)faction{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.backgroundColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        self.physicsWorld.contactDelegate = self;
        self.inGame = YES;
        self.finished = NO;
        // borders
        [self createWalls];
        // central olympus
        SKSpriteNode * mountain = [SKSpriteNode spriteNodeWithImageNamed:@"mountain"];
        mountain.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:mountain];
        // score
        self.score = 0;
        self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Monospace"];
        self.scoreLabel.fontColor = [NSColor blackColor];
        self.scoreLabel.text = @"0";
        self.scoreLabel.position = CGPointMake(self.size.width/2,
                                          self.size.height - self.scoreLabel.fontSize);
        [self addChild:self.scoreLabel];

        // creating player and adding it to the center of the scene
        [self initPlayer:faction];
        CGPoint center = CGPointMake(self.size.width/2, self.size.height/2);
        self.player.position = center;
        // setting rotation center for enemies
        self.rotationCenter = [[SKNode alloc]init];
        self.rotationCenter.position = center;
        [self addChild:self.rotationCenter];
        // enemy
        self.exterior = [NSMutableArray array];
        self.middle = [NSMutableArray array];
        self.interior = [NSMutableArray array];
        self.nextPop = 10.0;
        }
    return self;
}

-(void)createWalls{
    // walls destruct shots that collide with them
    int halfW = self.size.width / 2.0;
    int halfH = self.size.height / 2.0;
    CGSize hSize = CGSizeMake(self.size.width+32, 8);
    CGSize vSize = CGSizeMake(8, self.size.height+32);
    SKSpriteNode * leftBorder = [SKSpriteNode spriteNodeWithColor:[NSColor blackColor] size:vSize];
    leftBorder.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:vSize];
    leftBorder.physicsBody.dynamic = NO;
    leftBorder.physicsBody.categoryBitMask = BORDER;
    leftBorder.physicsBody.contactTestBitMask = 0;
    leftBorder.physicsBody.collisionBitMask = SHOT;
    leftBorder.position = CGPointMake(-30, halfH);
    [self addChild:leftBorder];
    
    SKSpriteNode * rightBorder = [SKSpriteNode spriteNodeWithColor:[NSColor blackColor] size:vSize];
    rightBorder.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:vSize];
    rightBorder.physicsBody.categoryBitMask = BORDER;
    rightBorder.physicsBody.contactTestBitMask = 0;
    rightBorder.physicsBody.dynamic = NO;
    rightBorder.physicsBody.collisionBitMask = SHOT;
    rightBorder.position = CGPointMake(self.size.width+30, halfH);
    [self addChild:rightBorder];
    
    SKSpriteNode * topBorder = [SKSpriteNode spriteNodeWithColor:[NSColor blackColor] size:hSize];
    topBorder.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hSize];
    topBorder.physicsBody.categoryBitMask = BORDER;
    topBorder.physicsBody.collisionBitMask = SHOT;
    topBorder.physicsBody.contactTestBitMask = 0;
    topBorder.physicsBody.dynamic = NO;
    topBorder.position = CGPointMake(halfW, self.size.height+30);
    [self addChild:topBorder];
    
    SKSpriteNode * bottomBorder = [SKSpriteNode spriteNodeWithColor:[NSColor blackColor] size:hSize];
    bottomBorder.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hSize];
    bottomBorder.physicsBody.contactTestBitMask = 0;
    bottomBorder.physicsBody.categoryBitMask = BORDER;
    bottomBorder.physicsBody.dynamic = NO;
    bottomBorder.physicsBody.collisionBitMask = SHOT;
    bottomBorder.position = CGPointMake(halfW, -30);
    [self addChild:bottomBorder];
}


-(void)didBeginContact:(SKPhysicsContact *)contact {
    if (contact.bodyA.categoryBitMask == SHOT) {
        [self checkShotCollisions:contact.bodyA with:contact.bodyB];
    } else if (contact.bodyB.categoryBitMask == SHOT) {
        [self checkShotCollisions:contact.bodyB with:contact.bodyA];
    }
}
-(void)checkShotCollisions:(SKPhysicsBody *)shot with:(SKPhysicsBody*)other {
    // a shot cannot destroy something with the same faction (collisionBitMask)
        if (shot.contactTestBitMask != other.contactTestBitMask
            && other.contactTestBitMask != -1) {
            Shot * shotNode = (Shot *)shot.node;
            switch (other.categoryBitMask) {
                case SHOT :
                    [shot.node removeFromParent];
                    [other.node removeFromParent];
                    break;
                case PLAYER :
                    [shot.node removeFromParent];
                    [(Player *)other.node loseHealth:shotNode.strength];
                    break;
                case ENEMY :
                    [shot.node removeFromParent];
                    [(Enemy *)other.node loseHealth:shotNode.strength];
                    break;
                case BORDER :
                    NSLog(@"pouet");
                    // shots are destroyed when leaving the view
                    [shot.node removeFromParent];
                    break;
            }
        }
}


-(int)addScore:(int)amount {
    self.score += amount;
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", self.score];
    return self.score;
}

-(void)mouseDown:(NSEvent *)theEvent {
    /* Called when a mouse click occurs */
    NSPoint eventPos = [theEvent locationInNode:self.player];
    self.shotDirection = CGVectorMake(eventPos.x, eventPos.y);
    self.isShooting = YES;
  }

-(void)mouseUp:(NSEvent *)theEvent{
    self.isShooting = NO;
}

-(void)mouseDragged:(NSEvent *)theEvent {
    NSPoint eventPos = [theEvent locationInNode:self.player];
    self.shotDirection = CGVectorMake(eventPos.x, eventPos.y);
}

-(void)shoot{
    int posX = BASE_SIZE / 2;
    int posY = BASE_SIZE / 2;
    if (self.shotDirection.dx < 0){
        posX *= -1;
    }
    if (self.shotDirection.dy < 0){
        posY *= -1;
    }
    CGPoint position = CGPointMake(self.player.position.x + posX,
                                   self.player.position.y + posY);
    Shot * shot = [Shot createBy:self.player from:position direction:self.shotDirection];
    [self addChild:shot];
    float dx = shot.physicsBody.velocity.dx;
    float dy = shot.physicsBody.velocity.dy;
    SKAction* shotAction = [SKAction repeatActionForever:[SKAction moveByX:dx y:dy duration:1]];
    [shot runAction:shotAction];
}

-(void)keyDown:(NSEvent *)theEvent {
    if (self.finished) {
        SKScene *scene = [Menu sceneWithSize:CGSizeMake(1024, 768)];
        [self.view presentScene:scene];
    }
    NSString * keys = [theEvent charactersIgnoringModifiers];
    for (int i = 0; i < [keys length]; i++){
        int code = [keys characterAtIndex:(i)];
        switch (code) {
            case NSLeftArrowFunctionKey :
                self.left = YES;
                break;
            case NSRightArrowFunctionKey :
                self.right = YES;
                break;
            case NSUpArrowFunctionKey :
                self.up = YES;
                break;
            case NSDownArrowFunctionKey :
                self.down = YES;
                break;
        }
    }
}


-(void)keyUp:(NSEvent *)theEvent {
    NSString * keys = [theEvent charactersIgnoringModifiers];
    for (int i = 0; i < [keys length]; i++){
        int code = [keys characterAtIndex:(i)];
        switch (code) {
            case NSLeftArrowFunctionKey :
                self.left = NO;
                break;
            case NSRightArrowFunctionKey :
                self.right = NO;
                break;
            case NSUpArrowFunctionKey :
                self.up = NO;
                break;
            case NSDownArrowFunctionKey :
                self.down = NO;
                break;
        }
    }
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    self.deltaTime = currentTime - self.lastTime;
    self.lastTime = currentTime;
    if (! self.inGame){
        return;
    }
    self.shootDelay -= self.deltaTime;
    if (self.isShooting && self.shootDelay < 0) {
        self.shootDelay = 0.2;
        [self shoot];
    }
    [self updatePlayer];
    // update enemies
    for (Enemy * e in self.exterior) {
        [e update:self.deltaTime];
    }
    for (Enemy * e in self.middle) {
         [e update:self.deltaTime];
    }
    for (Enemy * e in self.interior) {
         [e update:self.deltaTime];    }
    // creating new enemies if required
    if (currentTime >= self.nextPop) {
        // setting next enemy pop time according to the score
        self.nextPop = currentTime + [self nextEnemyPop:self.score];
        // creating enemy
        [self createEnemy];
    }
    //[self.enemy update:self.deltaTime];
}

-(Enemy *)createEnemy{
    // if no place left, aborting
    if (self.exterior.count > MAX_EXTERIOR &&
        self.middle.count > MAX_MIDDLE &&
        self.interior.count > MAX_INTERIOR) {
        return nil;
    }
    SKNode * centerNode = self.rotationCenter.copy;
    Faction f = [self chooseEnemyFaction];
    int si = [Utils randIntBetween:8 and:24];
    float sp = [Utils randFloatBetween:MIN_SPEED and:MAX_SPEED];
    Enemy * instance = [Enemy createOfFaction:f
                                         size:si
                                        speed:sp
                                       center:centerNode];
    [instance changeTarget:self.player];
    [self addChild:centerNode];

      // choosing where to add the new enemy
    if (self.exterior.count <= MAX_EXTERIOR) {
        instance.position = CGPointMake(RADIUS_EXTERIOR, RADIUS_EXTERIOR);
        [self.exterior addObject:instance];
    } else if (self.middle.count <= MAX_MIDDLE) {
        instance.position = CGPointMake(RADIUS_MIDDLE, RADIUS_MIDDLE);
        [self.middle addObject:instance];
    } else if (self.interior.count <= MAX_INTERIOR) {
        instance.position = CGPointMake(RADIUS_INTERIOR, RADIUS_INTERIOR);
        [self.interior addObject:instance];
    }
   
    return instance;
}

-(void)removeEnemy:(Enemy*)who {
    [self addScore:who.maxHealth];
    [who removeFromParent];
    [who.rotationCenter removeFromParent];
    [self.exterior removeObject:who];
    [self.middle removeObject:who];
    [self.interior removeObject:who];
}

-(void)updatePlayer {
    // computing next player's speed
    float speedX = 0;
    float speedY = 0;
    if (self.left)
        speedX -= 1;
    if (self.right)
        speedX += 1;
    if (self.up)
        speedY += 1;
    if (self.down)
        speedY -= 1;
    [self.player changeSpeed:CGVectorMake(speedX, speedY)];
    // updating player
    [self.player update:self.deltaTime];
    
}

-(void)gameOver {
    [self.player removeFromParent];
    // freezing enemies
    self.inGame = NO;
    self.finished = YES;
    for (Enemy * e in self.exterior) {
        [e.parent removeAllActions ];
    }
    for (Enemy * e in self.middle) {
        [e.parent removeAllActions ];
    }
    for (Enemy * e in self.interior) {
        [e.parent removeAllActions ];
    }
    SKLabelNode * gameOver = [SKLabelNode labelNodeWithFontNamed:@"Monospace"];
    gameOver.fontColor = [NSColor blackColor];
    gameOver.text = @"You failed! Press any key";
    gameOver.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self addChild:gameOver];
}

-(void)loseLife {
    
    self.player.position = CGPointMake(self.size.width/2, self.size.height/2);
    for (Enemy * e in self.interior) {
        [e removeFromParent];
    }
    for (Enemy * e in self.middle) {
        [e removeFromParent];
    }
    for (Enemy * e in self.exterior) {
        [e removeFromParent];
    }
    self.nextPop = 5;
    /*
    self.interior = [NSArray array];
    self.middle = [NSArray array];
    self.exterior = [NSArray array]; */
    [self.interior removeAllObjects];
    [self.middle removeAllObjects];
    [self.exterior removeAllObjects];
}

-(Faction)chooseEnemyFaction{
    // choosing a faction for enemy: never the same as the player
    Faction res = JUPITER;
    do {
        res = (Faction)[Utils randIntBetween:1 and:NB_FACTIONS];
    } while (res == self.player.faction);
    return res;
}

-(CFTimeInterval)nextEnemyPop:(int)score {
   // self.nextPop = log10(log10(score+1)+1);
    // TODO: replace allthis with a nice function that computes itself
    if (score < 1){
        self.nextPop = 10;
    } else if (score < 64) {
        self.nextPop = 5.5;
    } else if (score < 192) {
        self.nextPop = 3.5;
    } else if (score < 640) {
        self.nextPop = 2;
    } else {
        self.nextPop = 1;
    }
    return [Utils randIntBetween:self.nextPop*0.9
                             and:self.nextPop*1.1];
}

@end