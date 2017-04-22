//
//  SchulteGameBoardView.h
//  SchulteGridContest
//
//  Created by 刘宇轩 on 21/04/2017.
//  Copyright © 2017 liuyuxuan. All rights reserved.
//

#import <UIKit/UIKit.h>



@class SchulteGameBoardView;

@protocol SchulteGameBoardViewDelegate <NSObject>

-(BOOL)SchulteGameBoardView:(SchulteGameBoardView*)aView
            didSelectNumber:(NSUInteger)aNum;
@end



@interface SchulteGameBoardView : UIView



@property(nonatomic)IBInspectable NSUInteger GameBoardWidth;
@property(nonatomic)IBInspectable NSUInteger GameBoardHeight;
@property(nonatomic) NSMutableArray* randomNumberArray;
@property(nonatomic) id<SchulteGameBoardViewDelegate> delegate;





-(void)initGameBoardWithWidth:(NSUInteger)width Height:(NSUInteger)height;




@end
