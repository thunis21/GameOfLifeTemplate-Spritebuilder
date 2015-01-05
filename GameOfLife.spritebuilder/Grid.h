//
//  Grid.h
//  GameOfLife
//
//  Created by Thunis Kruger on 2015/01/05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Grid : CCSprite

@property  (nonatomic,assign)int totalAlive;
@property  (nonatomic,assign)int generation;

@end
