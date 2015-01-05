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
    
    _gridArray=[NSMutableArray array];
    
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


-(void)evolveStep
{
    [self countNeighbors];
    [self updateCreatures];
    _generation++;
}

-(void)countNeighbors{
    for (int i = 0; i < [_gridArray count]; i++)
    {
        // iterate through all the columns for a given row
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            // access the creature in the cell that corresponds to the current row/column
            Creature *currentCreature = _gridArray[i][j];
            
            // remember that every creature has a 'livingNeighbors' property that we created earlier
            currentCreature.livingNeighbors = 0;
            
            // now examine every cell around the current one
            
            // go through the row on top of the current cell, the row the cell is in, and the row past the current cell
            for (int x = (i-1); x <= (i+1); x++)
            {
                // go through the column to the left of the current cell, the column the cell is in, and the column to the right of the current cell
                for (int y = (j-1); y <= (j+1); y++)
                {
                    // check that the cell we're checking isn't off the screen
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX:x andY:y];
                    
                    // skip over all cells that are off screen AND the cell that contains the creature we are currently updating
                    if (!((x == i) && (y == j)) && isIndexValid)
                    {
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive)
                        {
                            currentCreature.livingNeighbors += 1;
                        }
                    }
                }
            }
        }
    }
}
-(void)updateCreatures{
    int numAlive=0;
    for (int i = 0; i < [_gridArray count]; i++)
    {
        // iterate through all the columns for a given row
        for (int j = 0; j < [_gridArray[i] count]; j++)
        {
            // access the creature in the cell that corresponds to the current row/column
            Creature *currentCreature = _gridArray[i][j];
            
            // remember that every creature has a 'livingNeighbors' property that we created earlier
            if (currentCreature.livingNeighbors == 3)
            {
                currentCreature.isAlive=TRUE;
                numAlive+=1;
            }
            else if(currentCreature.livingNeighbors<=1)
            {
                 currentCreature.isAlive=FALSE;
            }
            else if(currentCreature.livingNeighbors==4)
            {
                currentCreature.isAlive=FALSE;
            }
        }
    }
    _totalAlive=numAlive;
    
}
- (BOOL)isIndexValidForX:(int)x andY:(int)y
{
    BOOL isIndexValid = YES;
    if(x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}

@end
