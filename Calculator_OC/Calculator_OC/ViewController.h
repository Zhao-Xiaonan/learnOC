//
//  ViewController.h
//  Calculator_OC
//
//  Created by 赵笑楠 on 27/06/2017.
//  Copyright © 2017 赵笑楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//因为是在视图里的，已经有strong指向他了，这里用weak就可以了。通常都是用weak
@property (weak, nonatomic) IBOutlet UILabel *display;


@end

