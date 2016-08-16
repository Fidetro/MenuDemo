//
//  FIDMenu.m
//  cehuaDemo
//
//  Created by Fidetro on 16/7/28.
//  Copyright © 2016年 Fidetro. All rights reserved.
//

#import "FIDMenu.h"
#define GetViewWidth(view)    view.frame.size.width
#define GetViewHeight(view)   view.frame.size.height
#define GetViewX(view)        view.frame.origin.x
#define GetViewY(view)        view.frame.origin.y
@interface FIDMenu ()
/** offsetX **/
@property(nonatomic,assign,)float offsetX;
/** contentScale **/
@property(nonatomic,assign)float contentScale;
@property (nonatomic,strong)UIViewController *contentViewController;
@property (nonatomic,strong)UIViewController *leftMenuViewController;
@property (nonatomic,assign)CGFloat contentViewWidth;
@property (nonatomic,assign)CGFloat leftMenuWidth;

@end

@implementation FIDMenu
- (id)initWithContentViewController:(UIViewController *)contentViewController leftMenuViewController:(UIViewController *)leftMenuViewController{
    if ([super init]) {
        self.contentViewController = contentViewController;
        self.leftMenuViewController = leftMenuViewController;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.offsetX = 0;
    [self addChildViewController:self.contentViewController];
    [self addChildViewController:self.leftMenuViewController];
    [self.view addSubview:self.leftMenuViewController.view];

    [self.view addSubview:self.contentViewController.view];
    self.contentViewWidth = GetViewWidth(self.contentViewController.view);

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMove:)];
    [self.contentViewController.view addGestureRecognizer:pan];
  
}

- (void)panMove:(UIPanGestureRecognizer *)recognizer{
     CGRect windowFrame = [[UIScreen mainScreen]bounds];
    CGPoint translation = [recognizer translationInView:self.contentViewController.view];
     self.offsetX += translation.x;
    if (self.offsetX > 0) {
        self.offsetX = MIN(self.offsetX, windowFrame.size.width);
    }else{
        self.offsetX = 0;
    }
    
    self.contentScale = 1-( self.offsetX/2 / windowFrame.size.width);
    if (self.contentScale<0.5) {
        self.contentScale = 0.5;
    }
   

    if (recognizer.state == UIGestureRecognizerStateChanged) {
        
    
  
    if (translation.x > 0 &&self.contentScale >=0.5) {
       
        
          self.contentViewController.view.transform = CGAffineTransformMake(self.contentScale , 0, 0, self.contentScale, self.offsetX/2, 0);
    }
    else if (translation.x < 0&&self.contentScale <=1){
         self.contentViewController.view.transform = CGAffineTransformMake(self.contentScale, 0, 0, self.contentScale, self.offsetX/2, 0);
    }
    [recognizer setTranslation:CGPointZero inView:self.contentViewController.view];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded){
        if (self.offsetX >(windowFrame.size.width/4)) {
            if (self.offsetX !=(windowFrame.size.width/2)) {
            [self transformChanged];
                }
        }else if (self.offsetX <=(windowFrame.size.width/4) &&self.offsetX !=0){
            [self transformRecover];
        }
    }

}
- (void)transformChanged{

     CGRect windowFrame = [[UIScreen mainScreen]bounds];
    [UIView animateWithDuration:animationDuration animations:^{
        self.offsetX = windowFrame.size.width;
        self.contentScale = 0.5;
        self.contentViewController.view.transform = CGAffineTransformMake(0.5, 0, 0, 0.5, self.contentViewWidth/2, 0);
    }];
    UITapGestureRecognizer *tapSwipe = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSwipe:)];
    [self.contentViewController.view addGestureRecognizer:tapSwipe];
}
- (void)transformRecover{
    [UIView animateWithDuration:animationDuration animations:^{
        self.offsetX = 0;
        self.contentScale = 1;
        self.contentViewController.view.transform = CGAffineTransformIdentity;
    }];
}
- (void)tapSwipe:(UITapGestureRecognizer *)tapSwipe{


    [self transformRecover];
    [self.contentViewController.view removeGestureRecognizer:tapSwipe];
}


- (void)hideViewController:(UIViewController *)viewController
{
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
