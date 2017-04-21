//
//  SchulteGridGame.m
//  SchulteGridContest
//
//  Created by 刘宇轩 on 21/04/2017.
//  Copyright © 2017 liuyuxuan. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "SchulteGridGame.h"

@interface SchulteGridGame()

@property (nonatomic) NSUInteger GameBoardWidth;
@property (nonatomic) NSUInteger GameBoardHeight;

@end


@implementation SchulteGridGame

-(NSUInteger)gameBoardGridAmount{
    return self.GameBoardWidth * self.GameBoardHeight;
}


-(void)setGameBoradWithWidth:(NSUInteger)width Height:(NSUInteger)height{
    self.GameBoardHeight = height;
    self.GameBoardWidth = width;
}


-(NSArray*)GenerateGridArrayWithDifficultyDegree:(double)degree{
    NSMutableArray* rawArray = [[NSMutableArray alloc]init];
    int totalNumber = [self gameBoardGridAmount];
    
    
    for(int i = 0;i < totalNumber;i++){
        //[rawArray addObject:[NSAttributedString stringWithFormat:@"%d",i]];
        [rawArray addObject:[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d",i]]];
    }
    
    for(int i = 0;i < totalNumber;i++){
        int swapPos = arc4random() % (totalNumber - i) + i;
        NSString* temp = rawArray[swapPos];
        rawArray[swapPos] = rawArray[i];
        rawArray[i] = temp;
    }
    
    
    return rawArray;
}

@end
