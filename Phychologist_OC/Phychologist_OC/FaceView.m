//
//  FaceView.m
//  Happiness_OC
//
//  Created by 赵笑楠 on 04/07/2017.
//  Copyright © 2017 赵笑楠. All rights reserved.
//

#import "FaceView.h"

#define DEFAULT_SCALE 0.90
#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_R 0.10
#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_S 0.25

@implementation FaceView

@synthesize scale = _scale;
@synthesize dataSource = _dataSource;

- (CGFloat)scale
{
    if(!_scale){
        return DEFAULT_SCALE;
    }
    else{
        return _scale;
    }
}

- (void)setScale:(CGFloat)scale
{
    if(scale != _scale){
        _scale = scale;
        [self setNeedsDisplay];//有人缩放，重绘
    }
}

//Controller调用，执行处理器
- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged)||
       (gesture.state == UIGestureRecognizerStateEnded))
    {
        self.scale *= gesture.scale;
        gesture.scale = 1;
    }
}

- (void)setup
{
    //有人更改了边框，边界会变化，调用drawRECT，重画（而不是拉伸）
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
    [super awakeFromNib];
}

//当faceView跳出storyBoard时，没有调用initWithFrame
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        [self setup];
    }
    return self;
    
}

- (void)drawCircleAtPoint:(CGPoint)p
               withRadius:(CGFloat)radius
                inContext:(CGContextRef)context
{
    //推送环境
    UIGraphicsPushContext(context);
    
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
    CGContextStrokePath(context);//描边
    
    //弹出环境，不会破坏调用函数的环境
    UIGraphicsPopContext();
}

// Only override drawRect: if you perform custom drawing.
// An empty implementat ion adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //环境配置
    CGContextRef context = UIGraphicsGetCurrentContext();
   
    //draw face:a big circle
    CGPoint midPoint; //中点
    midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat size;
    size = self.bounds.size.width / 2;
    if(self.bounds.size.height < self.bounds.size.width)
        size = self.bounds.size.height / 2;
    size *= self.scale;
    
    CGContextSetLineWidth(context, 5.0);//线条粗细
    [[UIColor blueColor] setStroke];//描边颜色
    
    [self drawCircleAtPoint:midPoint withRadius:size inContext:context];
    
    //draw eye:two small circle
    CGPoint eyePoint;
    eyePoint.x = midPoint.x - size * EYE_H;
    eyePoint.y = midPoint.y - size * EYE_V;
    [self drawCircleAtPoint:eyePoint withRadius:size * EYE_R inContext:context];
    
    eyePoint.x = midPoint.x + size * EYE_H;
    [self drawCircleAtPoint:eyePoint withRadius:size * EYE_R inContext:context];
    
    //no nose
    //draw mouth
    CGPoint mouthStart;
    mouthStart.x = midPoint.x - size * MOUTH_H;
    mouthStart.y = midPoint.y + size * MOUTH_V;
    CGPoint mouthEnd = mouthStart;
    mouthEnd.x = midPoint.x + size * MOUTH_H;
    CGPoint mouthCP1 = mouthStart;
    mouthCP1.x += 2/3 * size * MOUTH_H;
    CGPoint mouthCP2 = mouthEnd;
    mouthCP1.x -= 2/3 * size * MOUTH_H;

    //向数据源索取微笑值
    float smile = [self.dataSource smileForFaceView:self];
    NSLog(@"%f",smile);
    if(smile > 1) smile = 1;
    if(smile < -1) smile = -1;
    
    CGFloat smileOffset = MOUTH_S * size * smile;
    mouthCP1.y += smileOffset;
    mouthCP2.y += smileOffset;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP1.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y);
    CGContextStrokePath(context);

}


@end
