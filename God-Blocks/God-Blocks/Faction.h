//
//  Faction.h
//  God-Blocks
//
//  Created by Guest User on 09/11/14.
//  Copyright (c) 2014 pixotters. All rights reserved.
//

#ifndef God_Blocks_Faction_h
#define God_Blocks_Faction_h

#import <Foundation/Foundation.h>

typedef enum {
    MARS = 1,
    VENUS,
    DIANA,
    APOLLO,
    NEPTUNE,
    JUPITER,
    NB_FACTIONS
} Faction;

@interface Factions : NSObject

+(NSString*)factionToString:(Faction)faction;

+(Faction)stringToFaction:(NSString*)string;
@end

#endif
