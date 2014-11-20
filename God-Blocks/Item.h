//
//  Item.h
//  God-Blocks
//
//  Created by Guest User on 09/11/14.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ItemType {
    POWER, // shots are more powerful
    HEALING, // faster self-healing
    MULTIPLE, // multiple (3) shots
    WIDTH, // shots are wider
    HEALTH, // greater max health
    LIFE, // extra life
} ItemType;


@interface Item : NSObject

@property () ItemType type;
@property () float duration;
@property () float timer;
// if duration = 0, it is instant.
// if duration < 0, it is permanent effect.

+(Item*)createItemOfType:(ItemType)type duration:(float)duration;


@end
