//
//  JoystickView.h
//  WzryYaogan
//
//  Created by mac on 2017/10/27.
//  Copyright © 2017年 zuiye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JoystickView;
@protocol JoystickViewDelegate<NSObject>
@optional

-(void)joystickView:(JoystickView*)joystickView angleChange:(CGFloat)angle;

-(void)joystickView:(JoystickView*)joystickView dragEnd:(CGFloat)angle;

@end

@interface JoystickView : UIView

/** <#description#> */
@property (nonatomic, weak) id<JoystickViewDelegate> delegate;

@end
