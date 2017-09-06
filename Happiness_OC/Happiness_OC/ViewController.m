//
//  ViewController.m
//  Happiness_OC
//
//  Created by 赵笑楠 on 04/07/2017.
//  Copyright © 2017 赵笑楠. All rights reserved.
//

#import "ViewController.h"
#import "FaceView.h"

@interface ViewController () <FaceViewDataSource>//设为FaceView的私有委托源
//create a Outlet to FaceView，then go to storyBoard and drag one out
@property (nonatomic,weak) IBOutlet FaceView *faceView;
@end

@implementation ViewController

@synthesize happiness = _happiness;
@synthesize faceView = _faceView;


//链接，每次model改变，都重新绘制view
- (void)setHappiness:(int)happiness
{
    _happiness = happiness;
    
    //重新绘制。never！！！直接调用drawRECT
    [self.faceView setNeedsDisplay];
}

- (void)setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    //添加手势识别器,缩放，由faceView实现
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
    
    //添加手势识别器，改变笑脸，由控制器实现
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHapinessGestrue:)]];
    
    //将数据源委托设置为控制器
    self.faceView.dataSource = self;
}


- (float)smileForFaceView:(FaceView *)sender
{
    return (self.happiness - 50) / 50.0;//happiness(0~100),smial(-1~1)
}


- (void)handleHapinessGestrue:(UIPanGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged)||
       (gesture.state == UIGestureRecognizerStateEnded))
    {
        CGPoint translation = [gesture translationInView:self.faceView];
        self.happiness -= translation.y / 2.0;
        
        //计算单词增量
        [gesture setTranslation:CGPointZero inView:self.faceView];
        
        
        
    }
}



@end
