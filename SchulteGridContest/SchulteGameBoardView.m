//
//  SchulteGameBoardView.m
//  SchulteGridContest
//
//  Created by 刘宇轩 on 21/04/2017.
//  Copyright © 2017 liuyuxuan. All rights reserved.
//

#import "SchulteGameBoardView.h"
#import <QuartzCore/QuartzCore.h>
#import <ChameleonFramework/Chameleon.h>

#define RIPPLE_PERCENT 0.8
IB_DESIGNABLE


typedef struct {
    int xPos;
    int yPos;
}GridPosition;




@interface SchulteGameBoardView()


// This Mask is Different than that Simple One
// It Change Everthing time
@property(nonatomic) CAShapeLayer* rippleMask;
@property(nonatomic) UIView* rippleView;
@property(nonatomic) UIView* rippleBackgroundView;



@end


@implementation SchulteGameBoardView
- (void)drawRect:(CGRect)rect {
    
    UIBezierPath* gridPath = [UIBezierPath bezierPath];
    
    
   
    for(int i = 0;i <= self.GameBoardWidth;i++){
        [gridPath moveToPoint:CGPointMake([self getSingleTileWidth] * i,0)];
        [gridPath addLineToPoint:CGPointMake([self getSingleTileWidth] * i,self.bounds.size.height)];
    }
    
    for(int i = 0;i <= self.GameBoardHeight;i++){
        [gridPath moveToPoint:CGPointMake(0, i * [self getSingleTileHeight])];
        [gridPath addLineToPoint:CGPointMake(self.bounds.size.width,i * [self getSingleTileHeight])];
    }
    
    
    
    [[UIColor blackColor]setStroke];
    [gridPath stroke];
    int counter = 0;
    
    for(int i = 0;i < self.GameBoardHeight;i++){
        for(int j = 0;j < self.GameBoardWidth;j++){
            [self ProcessAttributeStringInArray:self.randomNumberArray];
            [self.randomNumberArray[counter] drawInRect:CGRectMake([self getSingleTileWidth] * j,
                                                                   [self getSingleTileHeight] * i,
                                                                   [self getSingleTileWidth],
                                                                   [self getSingleTileHeight])];
            counter ++;
        }
    }
}

-(void)ProcessAttributeStringInArray:(NSArray*)aArray{
    NSDictionary* attributeDict = @{
                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:32],
                                    NSForegroundColorAttributeName : [UIColor flatRedColorDark]
                                    };
    for(NSMutableAttributedString* aAttributeString in aArray){
        [aAttributeString setAttributes:attributeDict
                                  range:NSMakeRange(0, [aAttributeString length])];
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
    [self setup];
    [self setNeedsDisplay];
}

#pragma mark - Utility Method

-(CGFloat)getSingleTileWidth{
    
    return self.bounds.size.width / self.GameBoardWidth;
}

-(CGFloat)getSingleTileHeight{
    return self.bounds.size.height / self.GameBoardHeight;
}

#pragma mark - Init

-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void) setup{
    self.backgroundColor = [UIColor flatWhiteColor];
   // self.layer.mask = self.rippleMask;
    
    self.rippleView.backgroundColor = [UIColor flatWatermelonColor];
    CGFloat CornerRadiusSize = [self getSingleTileWidth] * RIPPLE_PERCENT;
    CGFloat x = [self getSingleTileWidth] / 2 - CornerRadiusSize / 2;
    CGFloat y = [self getSingleTileHeight] / 2 - CornerRadiusSize / 2;
    self.rippleView.frame = CGRectMake(x,
                                       y,
                                       CornerRadiusSize,
                                       CornerRadiusSize);
    self.rippleView.layer.cornerRadius = CornerRadiusSize * 0.5;
    
    
    self.rippleBackgroundView.backgroundColor = [UIColor flatWhiteColor];
    self.rippleBackgroundView.frame = CGRectMake(0,
                                                 0,
                                                 [self getSingleTileWidth],
                                                 [self getSingleTileHeight]);
    
    self.rippleBackgroundView.alpha = 0;
    
    [self.rippleBackgroundView addSubview:self.rippleView];
    [self addSubview:self.rippleBackgroundView];
    CGFloat width = [self getSingleTileWidth];
    NSLog(@"width %f",width);
    NSLog(@"rippleView %f",self.rippleView.frame.size.width);

  
}

-(UIView*)rippleView{
    if(_rippleView == nil){
        _rippleView = [[UIView alloc]init];
    }
    return _rippleView;
}

-(UIView*)rippleBackgroundView{
    if(_rippleBackgroundView == nil){
        _rippleBackgroundView = [[UIView alloc]init];
    }
    return _rippleBackgroundView;
}

#pragma mark - Tap 

-(NSValue*)getGridPositionAtPoint:(CGPoint)tapPoint{
    
    GridPosition tapPos;
    
    tapPos.xPos = tapPoint.x / [self getSingleTileWidth];
    tapPos.yPos = tapPoint.y / [self getSingleTileHeight];
    
    return [NSValue value:&tapPos
             withObjCType:@encode(GridPosition)];
    
}

-(CGRect)getGridFrameAtGridPosition:(NSValue*)gridPosition{
    
    GridPosition pos;
    [gridPosition getValue:&pos];
    return CGRectMake(pos.xPos * [self getSingleTileWidth],
                      pos.yPos * [self getSingleTileHeight],
                      [self getSingleTileWidth],
                      [self getSingleTileHeight]);
    
}
-(CGPoint)getGridCenterAtGridPosition:(NSValue*)gridPosition{
    GridPosition pos;
    [gridPosition  getValue:&pos];
    
   
    return CGPointMake(pos.xPos * [self getSingleTileWidth] + 0.5 * [self getSingleTileWidth],
                       pos.yPos * [self getSingleTileHeight] + 0.5 * [self getSingleTileHeight]);
    
}


-(void)GameBoardTapGesture:(UITapGestureRecognizer*)recognizer{
    CGPoint touchDownPoint = [recognizer locationInView:self];
    NSValue* tapPos = [self getGridPositionAtPoint:touchDownPoint];
    
    GridPosition tapPosition;
    [tapPos getValue:&tapPosition];
    
    NSLog(@"Tap Position : %d %d",tapPosition.xPos,tapPosition.yPos);
    
//    self.rippleMask = [CAShapeLayer layer];
//    self.rippleMask.path = [UIBezierPath bezierPathWithRoundedRect:[self getGridFrameAtGridPosition:tapPos]
//                                                      cornerRadius:0].CGPath;
//    
//    self.layer.mask = self.rippleMask;
    
    self.rippleMask = [CAShapeLayer layer];
    self.rippleMask.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, [self getSingleTileWidth], [self getSingleTileHeight])
                                                      cornerRadius:0].CGPath;
    self.rippleBackgroundView.layer.mask = self.rippleMask;
    
    self.rippleBackgroundView.center = [self getGridCenterAtGridPosition:tapPos];
    //self.rippleView
    CGPoint centerPositionInRippleBackGroundView = CGPointMake(touchDownPoint.x - tapPosition.xPos * [self getSingleTileWidth], touchDownPoint.y - tapPosition.yPos * [self getSingleTileHeight]);
    self.rippleView.center = centerPositionInRippleBackGroundView;
    
    
    NSUInteger aNum = tapPosition.yPos * [self GameBoardWidth] +  tapPosition.xPos;
    NSLog(@"tapedIndex = %d",aNum);
    
    NSString* aString = [self.randomNumberArray[aNum] string];
    
    if([self.delegate SchulteGameBoardView:self didSelectNumber: [aString intValue]]){
        self.rippleView.backgroundColor = [UIColor flatGreenColorDark];
    }else{
        self.rippleView.backgroundColor = [UIColor flatWatermelonColor];
    }
    
    
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.rippleBackgroundView.alpha = 1;
                     } completion:nil];
    
    self.rippleView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.rippleView.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL success){
                         [UIView animateWithDuration:0.4
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut animations:^{
                                                 self.rippleBackgroundView.alpha = 0;
                                             } completion:nil];
                     }];
}


-(void)layoutSubviews{
    [super layoutSubviews];
}




@end
