//
//  Item.m
//  God-Blocks
//
//  Created by Guest User on 09/11/14.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#import "Item.h"

@implementation Item

+(Item*)createItemOfType:(ItemType)type duration:(float)duration {
    Item * instance = [Item alloc];
    instance.duration = duration;
    instance.type = type;
    return instance;
}

+(Item*)createInstantItemOfType:(ItemType)type {
    return [Item createItemOfType:type duration:0];
}

+(Item*)createPermanentItemOfType:(ItemType)type {
    return [Item createItemOfType:type duration:-1];
}

-(void)update:(CFTimeInterval)dt {
    // apply effect
    
    // check time
    if (self.duration >= 0) {
        self.timer += dt;
        if (self.timer > self.duration) {
            // destroy
        }
    }
}


@end
