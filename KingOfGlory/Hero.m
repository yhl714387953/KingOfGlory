//
//  Hero.m
//  WzryYaogan
//
//  Created by mac on 2018/1/24.
//  Copyright © 2018年 zuiye. All rights reserved.
//

#import "Hero.h"
@interface Hero()

/** 移动定时器 */
@property (nonatomic, strong) NSTimer* moveTimer;

@end

@implementation Hero

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.heroView = [[HeroView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        self.state = HeroStateMotionless;
        self.speed = 2;
        self.angle = 0;
        self.moveTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(onMove:) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)move{
//    if (self.moveTimer) {
////        [self.moveTimer invalidate];
//    }
//    if (self.state == HeroStateMoving) {
//        return;
//    }
//
//    if (!self.moveTimer) {
//
//    }else{
//        [self.moveTimer setFireDate:[NSDate date]];
//    }
    
    self.state = HeroStateMoving;
}

-(void)onMove:(NSTimer*)timer{
    //第一象限  第二象限    第三象限    第四象限
    NSInteger factorX = 0;
    NSInteger factorY = 0;
    if (self.angle < M_PI_2) {
        factorX = 1;
        factorY = -1;
    }else if(self.angle < M_PI) {
        factorX = 1;
        factorY = -1;
    }else if(self.angle < M_PI * 1.5) {
        factorX = 1;
        factorY = -1;
    }else{
        factorX = 1;
        factorY = -1;
    }
    
    CGFloat x_change = self.speed * factorX * cos(self.angle);
    CGFloat y_change = self.speed * factorY * sin(self.angle);
    self.heroView.center = CGPointMake(self.heroView.center.x + x_change, self.heroView.center.y + y_change);
    self.heroView.transform = CGAffineTransformMakeRotation(M_PI * 2 - self.angle);
    
}

-(void)stop{
    self.state = HeroStateMotionless;
//    [self.moveTimer invalidate];
//    [self.moveTimer setFireDate:[NSDate distantFuture]];
}

-(float)speed{
    if (self.state == HeroStateMotionless) {
        return 0;
    }
    
    return 2;
}

@end
