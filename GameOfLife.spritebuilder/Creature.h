//
//  Creature.h
//  GameOfLife
//
//  Created by Thunis Kruger on 2015/01/05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite

@property (nonatomic,assign)BOOL isAlive;

@property (nonatomic,assign)NSInteger livingNeighbors;

-(id)initCreature;


@end
