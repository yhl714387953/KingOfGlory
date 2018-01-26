//
//  HeroView.m
//  WzryYaogan
//
//  Created by mac on 2018/1/24.
//  Copyright © 2018年 zuiye. All rights reserved.
//

#import "HeroView.h"

@implementation HeroView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [[UIColor redColor] set];
    CGFloat space = 10;
    CGFloat x = space;
    CGFloat y = space;
    CGFloat width = rect.size.width - x * 2;
    CGFloat height = rect.size.height - y * 2;
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, width, height) cornerRadius:width / 2.0f];
    UIBezierPath* trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(rect.size.width / 2.0, space)];
    [trianglePath addLineToPoint:CGPointMake(rect.size.width, rect.size.height / 2.0)];
    [trianglePath addLineToPoint:CGPointMake(rect.size.width / 2.0, rect.size.height - space)];
    [trianglePath closePath];//闭合曲线
    trianglePath.usesEvenOddFillRule = NO;//求合集
    [trianglePath appendPath:path];
    [trianglePath fill];
    
}

@end
