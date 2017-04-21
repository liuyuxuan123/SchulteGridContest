//
//  SchulteGridGame.h
//  SchulteGridContest
//
//  Created by 刘宇轩 on 21/04/2017.
//  Copyright © 2017 liuyuxuan. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface SchulteGridGame : NSObject

-(void) setGameBoradWithWidth:(NSUInteger)width Height:(NSUInteger)height;

-(NSArray*)GenerateGridArrayWithDifficultyDegree:(double)degree;

@end
