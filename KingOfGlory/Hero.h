//
//  Hero.h
//  WzryYaogan
//
//  Created by mac on 2018/1/24.
//  Copyright © 2018年 zuiye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeroView.h"

typedef NS_ENUM(NSInteger, HeroState) {
    HeroStateMotionless = 0,
    HeroStateMoving = 1
};

@interface Hero : NSObject

@property(nonatomic) float speed;
@property(nonatomic) float angle;

@property(nonatomic) HeroState state;

/** 可移动区域 */
@property(nonatomic) CGRect moveRect;

@property(nonatomic, strong) HeroView* heroView;

-(void)move;
-(void)stop;

@end
