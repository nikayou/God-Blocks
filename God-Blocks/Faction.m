//
//  Faction.m
//  God-Blocks
//
//  Created by Guest User on 09/11/14.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Faction.h"

@implementation Factions

+(NSString*)factionToString:(Faction)faction {
    // TODO: this is really ugly but no choice
    switch(faction) {
        case MARS: return @"MARS";
        case VENUS: return @"VENUS";
        case DIANA: return @"DIANA";
        case APOLLO: return @"APOLLO";
        case NEPTUNE: return @"NEPTUNE";
        case JUPITER: return @"JUPITER";
        default: return @"JUPITER";
    }
}

+(Faction)stringToFaction:(NSString*)string {
    // TODO: this is really ugly too
    if ([string isEqualToString:@"MARS"]) {
        return MARS;
    }
    if ([string isEqualToString:@"VENUS"]) {
        return VENUS;
    }
    if ([string isEqualToString:@"DIANA"]) {
        return DIANA;
    }
    if ([string isEqualToString:@"APOLLO"]) {
        return APOLLO;
    }
    if ([string isEqualToString:@"NEPTUNE"]) {
        return NEPTUNE;
    }
    if ([string isEqualToString:@"JUPITER"]) {
        return JUPITER;
    }
    // default
    return JUPITER;
}

@end