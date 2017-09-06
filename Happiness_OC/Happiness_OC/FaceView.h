//
//  FaceView.h
//  Happiness_OC
//
//  Created by 赵笑楠 on 04/07/2017.
//  Copyright © 2017 赵笑楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FaceView;//前向引用

@protocol FaceViewDataSource

//V向C委托，把自身作为参数传递出去
//协议的唯一方法
- (float)smileForFaceView:(FaceView *)sender;

@end

@interface FaceView : UIView

@property (nonatomic) CGFloat scale;//对face进行缩放

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

//数据源委托,可以接受任意类的任意对象
//FaceView对数据源一无所知，数据源必须实现协议的方法
@property (nonatomic,weak) IBOutlet id <FaceViewDataSource> dataSource;

@end
