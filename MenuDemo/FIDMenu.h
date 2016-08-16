//
//  FIDMenu.h
//  cehuaDemo
//
//  Created by Fidetro on 16/7/28.
//  Copyright © 2016年 Fidetro. All rights reserved.
//

#import <UIKit/UIKit.h>
#define animationDuration 0.5
@interface FIDMenu : UIViewController

/** offsetX **/
@property(nonatomic,assign,readonly)float offsetX;
/** contentScale **/
@property(nonatomic,assign,readonly)float contentScale;
//向右移动
- (void)transformChanged;

- (id)initWithContentViewController:(UIViewController *)contentViewController leftMenuViewController:(UIViewController *)leftMenuViewController;
@end
