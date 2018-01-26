//
//  JoystickView.m
//  WzryYaogan
//
//  Created by mac on 2017/10/27.
//  Copyright © 2017年 zuiye. All rights reserved.
//

#import "JoystickView.h"

@interface JoystickView()

/** <#description#> */
@property (nonatomic, strong) UIView* circleView;

/** 指示视图 */
@property (nonatomic, strong) UIView* indicateView;

@end;

@implementation JoystickView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.circleView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubview:self.circleView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
}

-(void)setupViews{
    
    [self addSubview:self.indicateView];
    self.indicateView.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
    self.circleView.frame = self.bounds;
    self.circleView.layer.cornerRadius = self.frame.size.width / 2.0;
    self.circleView.layer.masksToBounds = YES;
}


#define degreesToRadian(x) (M_PI * x / 180.0)
#define radiansToDegrees(x) (180.0 * x / M_PI)
#define kIndicateViewWidth 40
-(void)handleTouches:(NSSet<UITouch *> *)touches{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    CGPoint centerPoint = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
    CGFloat distance = sqrt((point.x - centerPoint.x) * (point.x - centerPoint.x) + (point.y - centerPoint.y) * (point.y - centerPoint.y));
    CGFloat angle = [self getAngleStartPoint:centerPoint endPoint:point];
    
    if (distance > self.frame.size.width / 2.0) {
        
        //超出了边界，4个象限4种情况
    //第一象限  第二象限    第三象限    第四象限
        NSInteger factorX = 0;
        NSInteger factorY = 0;
        if (angle < M_PI_2) {
            factorX = 1;
            factorY = -1;
        }else if(angle < M_PI) {
            factorX = 1;
            factorY = -1;
        }else if(angle < M_PI * 1.5) {
            factorX = 1;
            factorY = -1;
        }else{
            factorX = 1;
            factorY = -1;
        }
        
        self.indicateView.center = CGPointMake((self.frame.size.width / 2.0) * (1 + factorX * cos(angle)), (self.frame.size.height / 2.0) * (1 + factorY * sin(angle)));
        
    }else{
        self.indicateView.center = point;
    }
    
    NSLog(@"当前角度:%f", angle);
    if (self.delegate && [self.delegate respondsToSelector:@selector(joystickView:angleChange:)]) {
        [self.delegate joystickView:self angleChange:angle];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self handleTouches:touches];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self handleTouches:touches];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.20 animations:^{
        self.indicateView.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(joystickView:dragEnd:)]) {
        [self.delegate joystickView:self dragEnd:0];
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.20 animations:^{
        self.indicateView.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(joystickView:dragEnd:)]) {
        [self.delegate joystickView:self dragEnd:0];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.indicateView) {
        [self.indicateView removeFromSuperview];
    }
    
    [self setupViews];
}

#pragma mark -
#pragma mark - private method
//求两点之间的距离   point1到point0 的
-(CGFloat)getDiffXPoint0:(CGPoint)point0 point1:(CGPoint)point1{
    
    return 0;
}

-(CGFloat)getDiffYPoint0:(CGPoint)point0 point1:(CGPoint)point1{
    
    return 0;
}

//获取两点与水平方向的夹角  （与三点钟方向的夹角）  单位：弧度
/**
          C
         **
        * *
       *  *
    A * * * B

 */
-(CGFloat)getAngleStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    //  A:startPoint
    //  C:endPoint
//    求A的角度
    CGFloat AB = ABS(endPoint.x - startPoint.x);
    CGFloat BC = ABS(endPoint.y - startPoint.y);
    CGFloat AC = sqrt(AB * AB + BC * BC);
    
    CGFloat angle = 0;//单位：弧度
    if (AC == 0) {//原点位置，这种情况不会有，只有指示圆圈超出了边界才会调用此方法计算角度
        return -1;
    }
    
    if (AB == 0) {// pi / 2  或者  pi * 3 / 2
        angle = endPoint.y > startPoint.y ? M_PI * (3 / 2.0f) : M_PI_2;
    }else if(BC == 0){
        angle = endPoint.x > startPoint.x ? 0 : M_PI;
    }else{
        angle = acos((AB * AB + AC * AC - BC * BC) / (2 * AC * AB));
        
        //第一象限  第二象限    第三象限    第四象限
        if (endPoint.x > startPoint.x && endPoint.y < startPoint.y) {
            angle += 0;
        }else if(endPoint.x < startPoint.x && endPoint.y < startPoint.y) {
            angle = M_PI - angle;
        }else if(endPoint.x < startPoint.x && endPoint.y > startPoint.y) {
            angle += M_PI;
        }else{
            angle = M_PI * 2 - angle;
        }
    }

    return angle;
}

#pragma mark -
#pragma mark - getter
-(UIView *)indicateView{
    if (!_indicateView) {
        _indicateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kIndicateViewWidth, kIndicateViewWidth)];
        _indicateView.backgroundColor = [UIColor redColor];
        
        _indicateView.layer.cornerRadius = kIndicateViewWidth / 2.0;
        _indicateView.layer.masksToBounds = YES;
    }
    
    return _indicateView;
}

-(UIView *)circleView{
    if(!_circleView){
        _circleView = [[UIView alloc] initWithFrame:(CGRectZero)];
        _circleView.backgroundColor = [UIColor purpleColor];
    }
    
    return _circleView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
