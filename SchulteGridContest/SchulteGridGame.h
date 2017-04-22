//
//  SchulteGridGame.h
//  SchulteGridContest
//
//  Created by 刘宇轩 on 21/04/2017.
//  Copyright © 2017 liuyuxuan. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ContestDifficultyDegree) {
    Easy,
    Medium,
    Hard,
    Amateur,
    Semi_Pro,
    Professional,
    Worldclass,
    Legendary
};

typedef NS_ENUM(NSUInteger,GameState) {
    Unstart,
    Picking,
    Terminated,
    End
    
};


@interface SchulteGridGame : NSObject
@property(nonatomic) GameState CurrentGameState;
@property(nonatomic) NSUInteger CurrentPickedNumber;
-(void) setGameBoradWithWidth:(NSUInteger)width Height:(NSUInteger)height;

-(NSArray*)GenerateGridArrayWithDifficultyDegree:(ContestDifficultyDegree)degree;

-(BOOL)StartGameWithNumber:(NSUInteger)n;
-(BOOL)PickNextStepWithNumber:(NSUInteger)n;



@end
