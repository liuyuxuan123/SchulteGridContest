//
//  SchulteGridViewController.m
//  SchulteGridContest
//
//  Created by 刘宇轩 on 21/04/2017.
//  Copyright © 2017 liuyuxuan. All rights reserved.
//

#import "SchulteGridViewController.h"
#import "SchulteGameBoardView.h"
#import "SchulteGridGame.h"

@interface SchulteGridViewController () <SchulteGameBoardViewDelegate>

@property (weak, nonatomic) IBOutlet SchulteGameBoardView*SchulteGridGameBoard;

//@property (nonatomic) NSUInteger GridAmount;
@property (nonatomic) NSUInteger GameBoardWidth;
@property (nonatomic) NSUInteger GameBoardHeight;
@property (nonatomic) SchulteGridGame* SchulteGame;

@end

@implementation SchulteGridViewController 
#pragma mark - Property Method

-(SchulteGridGame*)SchulteGame{
    if(_SchulteGame == nil){
        _SchulteGame = [[SchulteGridGame alloc]init];
    }
    return _SchulteGame;
}

-(void)setSchulteGridGameBoard:(SchulteGameBoardView *)SchulteGridGameBoard{
    _SchulteGridGameBoard = SchulteGridGameBoard;
    UITapGestureRecognizer* SchulteGridGameBoardTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:SchulteGridGameBoard action:@selector(GameBoardTapGesture:)];
    [_SchulteGridGameBoard addGestureRecognizer:SchulteGridGameBoardTapGestureRecognizer];
}

#pragma mark - Delegate Method
-(BOOL)SchulteGameBoardView:(SchulteGameBoardView *)aView didSelectNumber:(NSUInteger)aNum {
    //[self.SchulteGame ]
    if(self.SchulteGame.CurrentGameState == Unstart){
        if([self.SchulteGame StartGameWithNumber:aNum]){
            return YES;
        }
    }else if(self.SchulteGame.CurrentGameState == Picking){
        if([self.SchulteGame PickNextStepWithNumber:aNum]){
            
            return YES;
        }
    }
    return NO;
    
}



#pragma mark - Utility Methods
-(NSUInteger) gameBoardGridAmount{
    return self.GameBoardWidth * self.GameBoardHeight;
}

#pragma mark - Set up Method
-(void) setupGameBoardWithWidth:(NSUInteger)width Height:(NSUInteger)height{
    self.GameBoardWidth = width;
    self.GameBoardHeight = height;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.SchulteGridGameBoard.delegate = self;
    
    self.GameBoardWidth = 5;
    self.GameBoardHeight = 5;
    
    [self.SchulteGridGameBoard initGameBoardWithWidth:self.GameBoardWidth Height:self.GameBoardWidth];
    
    [self.SchulteGame setGameBoradWithWidth:self.GameBoardWidth Height:self.GameBoardHeight];
    
    [self.SchulteGridGameBoard setRandomNumberArray:[self.SchulteGame GenerateGridArrayWithDifficultyDegree:Medium]];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
