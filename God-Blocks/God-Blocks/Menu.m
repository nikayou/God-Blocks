//
//  Menu.m
//  God-Blocks
//
//  Created by CAILLOUX NICOLAS on 17/11/2014.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#import "Menu.h"
#import "Faction.h"
#import "Color.h"
#import "GameScene.h"

@implementation Menu

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.index = 1;
        self.cursor = [SKSpriteNode spriteNodeWithColor:[NSColor blackColor] size:CGSizeMake(16,16)];
        [self addChild:self.cursor];
        self.backgroundColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        SKNode * m = [self createCharacter:MARS];
        m.position = CGPointMake(150, 500);
        [self addChild:m];
        SKNode * v = [self createCharacter:VENUS];
        v.position = CGPointMake(500, 500);
        [self addChild:v];
        SKNode * d = [self createCharacter:DIANA];
        d.position = CGPointMake(850, 500);
        [self addChild:d];
        SKNode * a = [self createCharacter:APOLLO];
        a.position = CGPointMake(150, 100);
        [self addChild:a];
        SKNode * n = [self createCharacter:NEPTUNE];
        n.position = CGPointMake(500, 100);
        [self addChild:n];
        SKNode * j = [self createCharacter:JUPITER];
        j.position = CGPointMake(850, 100);
        [self addChild:j];
        // setting help
        SKLabelNode * help = [SKLabelNode labelNodeWithFontNamed:@"Monospace"];
        help.text = @"Arrows: move. Left-click: shot";
        help.fontColor = [NSColor blackColor];
        help.position = CGPointMake(self.size.width/2, self.size.height/2-50);
        [self addChild:help];
    }
    return self;
}

-(void)keyDown:(NSEvent *)theEvent {
    NSString * keys = [theEvent charactersIgnoringModifiers];
    for (int i = 0; i < [keys length]; i++){
        int code = [keys characterAtIndex:(i)];
        switch (code) {
            case NSLeftArrowFunctionKey :
                self.index-- ;
                if (self.index == 0)
                    self.index = 1;
                break;
            case NSRightArrowFunctionKey :
                self.index++;
                if (self.index == NB_FACTIONS)
                    self.index = NB_FACTIONS - 1;
                break;
            case NSEnterCharacter :
                [self begin];
                break;
        }
    }
}

-(void)mouseDown:(NSEvent *)theEvent {
    [self begin];
}

-(void)update:(NSTimeInterval)currentTime {
    switch ((Faction)self.index) {
        case MARS:
            self.cursor.position = CGPointMake(150,450);
            break;
        case VENUS:
            self.cursor.position = CGPointMake(500,450);
            break;
        case DIANA:
            self.cursor.position = CGPointMake(850,450);
            break;
        case APOLLO:
            self.cursor.position = CGPointMake(150,50);
            break;
        case NEPTUNE:
            self.cursor.position = CGPointMake(500,50);
            break;
        case JUPITER:
            self.cursor.position = CGPointMake(850,50);
            break;
    }
}

-(void)begin {
    GameScene * scene = [[GameScene alloc]initWithSize:self.size
                                             character:(Faction)self.index];
    [self.view presentScene:scene];
}

-(SKNode*)createCharacter:(Faction)faction {
    SKLabelNode* name = [SKLabelNode labelNodeWithFontNamed:@"Monospace"];
    //NSString * nameStr = [Faction factionToString:faction];
    NSColor * color = [Color getFactionColor:faction];
    name.fontColor = color;
    name.position = CGPointMake(0, 32);
    SKLabelNode* power = [SKLabelNode labelNodeWithFontNamed:@"Monospace"];
    switch (faction) {
        case MARS :
            name.text = @"Mars";
            power.text = @"More powerful";
            break;
        case VENUS :
            name.text = @"Venus";
            power.text = @"Faster healing";
            break;
        case APOLLO :
            name.text = @"Apollo";
            power.text = @"Bigger shots";
            break;
        case DIANA:
            name.text = @"Diana";
            power.text = @"Three shots";
            break;
        case NEPTUNE :
            name.text = @"Neptune";
            power.text = @"More health";
            break;
        case JUPITER :
            name.text = @"Jupiter";
            power.text = @"Extra life";
            break;
    }
    SKNode * character = [[SKNode alloc]init];
    power.fontColor = [NSColor blackColor];
    SKSpriteNode * square = [SKSpriteNode spriteNodeWithColor:color
                                                         size:CGSizeMake(32, 32)];
    square.position = CGPointMake(0, 92);
    [character addChild:name];
    [character addChild:power];
    [character addChild:square];
    return character;
}


@end
