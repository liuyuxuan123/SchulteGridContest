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


-(NSArray*)GenerateGridArrayWithDifficultyDegree:(ContestDifficultyDegree)degree{
    NSMutableArray* rawArray = [[NSMutableArray alloc]init];
    NSMutableArray* indexArray = [[NSMutableArray alloc]init];
    
    int totalNumber = [self gameBoardGridAmount];
    
    for(int i = 0;i < totalNumber;i++){
        //[rawArray addObject:[NSAttributedString stringWithFormat:@"%d",i]];
        [rawArray addObject:[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d",i]]];
        
        [indexArray addObject:@(i)];
    }
    // Do Some Degree of Difficulty Code Here
    
    
    //NSMutableArray* complexArray = [NSMutableArray  arrayWithArray:rawArray];
    NSMutableArray* randomlyChoosedArray = [NSMutableArray array];
    
    switch (degree) {
        case Easy:
            
            break;
        case Medium:
            // Choose N numbers randomly,Convert its format(Simple Addition and Subtraction)
        {
            int difficultGridAmount = arc4random() % self.GameBoardWidth + self.GameBoardWidth;
            for(int i = 0;i < difficultGridAmount;i++){
                int selectedIndex = arc4random() % ([indexArray count] - i);
                [randomlyChoosedArray  addObject:indexArray[selectedIndex]];
                [indexArray exchangeObjectAtIndex:selectedIndex withObjectAtIndex:[indexArray  count] - 1 - i];
            }
            NSLog(@"Number of Random = %d Choosed Number = %@",difficultGridAmount,randomlyChoosedArray);
            
            
            
        }
            break;
        case Hard:
            // Choose N numbers randomly,Convert its format(Addition,Subtraction,Multiple,Divide)
            break;
            
        case Amateur:
            break;
            
        case Semi_Pro:
            break;
            
        case Professional:
            break;
            
        case Worldclass:
            break;
            
        case Legendary:
            break;
            
        default:
            break;
    }
    
    
    for(int i = 0;i < totalNumber;i++){
        int swapPos = arc4random() % (totalNumber - i) + i;
        [rawArray exchangeObjectAtIndex:i withObjectAtIndex:swapPos];
    }
    return rawArray;
}

-(instancetype)init{
    self = [super init];
    if(self){
        self.CurrentGameState = Unstart;
        self.CurrentPickedNumber = -1;
    }
    return self;
}


-(BOOL)StartGameWithNumber:(NSUInteger)n{
    if(self.CurrentGameState == Unstart){
        if(n == 0){
            self.CurrentGameState = Picking;
            self.CurrentPickedNumber = 0;
            return YES;
        }
    }
    return NO;
}
-(BOOL)PickNextStepWithNumber:(NSUInteger)n{
    if(self.CurrentGameState == Picking){
        if(n == self.CurrentPickedNumber + 1){
            self.CurrentPickedNumber ++;
            
            
            if(n == [self gameBoardGridAmount] - 1){
                self.CurrentGameState = End;
            }
            
            return YES;
        }
    }
    return NO;
}






@end
