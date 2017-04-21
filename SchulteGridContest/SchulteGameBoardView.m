//
//  SchulteGameBoardView.m
//  SchulteGridContest
//
//  Created by 刘宇轩 on 21/04/2017.
//  Copyright © 2017 liuyuxuan. All rights reserved.
//

#import "SchulteGameBoardView.h"
IB_DESIGNABLE
@implementation SchulteGameBoardView


- (void)drawRect:(CGRect)rect {
    
    UIBezierPath* gridPath = [UIBezierPath bezierPath];
    
    
    
    for(int i = 0;i <= self.GameBoardWidth;i++){
        [gridPath moveToPoint:CGPointMake(self.bounds.origin.x + self.bounds.size.width * i / self.GameBoardWidth,self.bounds.origin.y)];
        [gridPath addLineToPoint:CGPointMake(self.bounds.origin.x + self.bounds.size.width * i / self.GameBoardWidth, self.bounds.origin.y + self.bounds.size.height)];
    }
    
    for(int i = 0;i <= self.GameBoardHeight;i++){
        [gridPath moveToPoint:CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height * i / self.GameBoardHeight)];
        [gridPath addLineToPoint:CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y + self.bounds.size.height * i / self.GameBoardHeight)];
    }
    
    
    
    [[UIColor blackColor]setStroke];
    [gridPath stroke];
    int counter = 0;
    
    for(int i = 0;i < self.GameBoardHeight;i++){
        for(int j = 0;j < self.GameBoardWidth;j++){
            [self.randomNumberArray[counter] drawInRect:CGRectMake(self.bounds.size.width / self.GameBoardWidth * j, self.bounds.size.height / self.GameBoardHeight * i, self.bounds.size.width / self.GameBoardWidth, self.bounds.size.height / self.GameBoardHeight)];
            counter ++;
        }
    }
    
    
    
    
}



-(NSUInteger) gameBoardGridAmount{
    return self.GameBoardHeight * self.GameBoardWidth;
}

-(void)setRandomNumberArray:(NSMutableArray *)randomNumberArray{
    _randomNumberArray = randomNumberArray;

    
    [self setNeedsDisplay];
}


-(void)initGameBoardWithWidth:(NSUInteger)width Height:(NSUInteger)height{
    self.GameBoardWidth = width;
    self.GameBoardHeight = height;
    
    [self setNeedsDisplay];
}






@end
