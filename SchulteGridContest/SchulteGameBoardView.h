//
//  SchulteGameBoardView.h
//  SchulteGridContest
//
//  Created by 刘宇轩 on 21/04/2017.
//  Copyright © 2017 liuyuxuan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SchulteGameBoardView : UIView



@property(nonatomic)IBInspectable NSUInteger GameBoardWidth;
@property(nonatomic)IBInspectable NSUInteger GameBoardHeight;
@property(nonatomic) NSMutableArray* randomNumberArray;


-(void)initGameBoardWithWidth:(NSUInteger)width Height:(NSUInteger)height;




@end
