//
//  Grid.m
//  GameOfLife
//
//  Created by Thunis Kruger on 2015/01/05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"


static const int GRID_ROWS=8;
static const int GRID_COLUMNS=10;

@implementation Grid
{
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

-(void)onEnter
{
    [super onEnter];
    
    [self setupGrid];
    
    self.userInteractionEnabled=YES;
}

-(void)setupGrid
{
    _cellWidth=self.contentSize.width/GRID_COLUMNS ;
    _cellHeight=self.contentSize.height/GRID_ROWS;
    
    float x=0;
    float y=0;
    
    
    for(int i=0;i<GRID_ROWS;i++){
        _gridArray[i]=[NSMutableArray array];
        x=0;
        
        for(int j=0;j<GRID_COLUMNS;j++){
            Creature *creature=[[Creature alloc] initCreature];
            creature.anchorPoint=ccp(0,0);
            creature.position=ccp(x,y);
            [self addChild:creature];
            _gridArray[i][j]=creature;
            creature.isAlive=YES;
            x+=_cellWidth;
        
    }
        y+=_cellHeight;
        
    }
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    //get the x,y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
    
    //get the Creature at that location
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    //invert it's state - kill it if it's alive, bring it to life if it's dead.
    creature.isAlive = !creature.isAlive;
}

-(Creature*)creatureForTouchPosition:(CGPoint)touchPosition
{
    int row=touchPosition.y/_cellHeight;
    int col=touchPosition.x/_cellWidth;
    return _gridArray[row][col];
}
@end
