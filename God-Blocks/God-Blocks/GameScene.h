//
//  GameScene.h
//  God-Blocks
//

//  Copyright (c) 2014 pixotters. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "Player.h"
#import "Enemy.h"
#import "Shot.h"

static int MAX_EXTERIOR = 8;
static int MAX_MIDDLE = 6;
static int MAX_INTERIOR = 4;
static int RADIUS_EXTERIOR = 256;
static int RADIUS_MIDDLE = 192;
static int RADIUS_INTERIOR = 128;

@interface GameScene : SKScene<SKPhysicsContactDelegate>

@property Player* player;
@property bool inGame;
@property bool finished;
// keeping enemies for update and generation
@property NSMutableArray * exterior; // 256
@property NSMutableArray * middle; // 192
@property NSMutableArray * interior; // 128
//
@property int score;
@property SKLabelNode * scoreLabel;
//@property SKNode* camera;
@property SKNode* rotationCenter;
@property CFTimeInterval lastTime;
@property CFTimeInterval deltaTime; // time elapsed since last update
@property bool left; // is the left key pressed?
@property bool right;
@property bool up;
@property bool down;
@property bool isShooting;
@property CGVector shotDirection;
@property CFTimeInterval shootDelay;
// enemies generation stuffs
@property CFTimeInterval nextPop; // when enemy will pop

-(id)initWithSize:(CGSize)size character:(Faction)faction;
-(int)addScore:(int)score;
-(void)removeEnemy:(Enemy*)who;
-(void)loseLife;
-(void)gameOver;

@end
