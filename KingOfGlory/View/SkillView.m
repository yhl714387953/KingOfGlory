//
//  SkillView.m
//  WzryYaogan
//
//  Created by mac on 2017/12/21.
//  Copyright © 2017年 zuiye. All rights reserved.
//

#import "SkillView.h"

@interface SkillView()

/** 普通攻击 */
@property (nonatomic, strong) UIButton* attackButton;

/** 第一技能 */
@property (nonatomic, strong) UIButton* firstButton;

/** 第二技能 */
@property (nonatomic, strong) UIButton* secondButton;

/** 第三技能 */
@property (nonatomic, strong) UIButton* thirdButton;

@end

@implementation SkillView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configureView];
    }
    
    return self;
}

-(void)configureView{
    
    [self addSubview:self.firstButton];
    [self addSubview:self.secondButton];
    [self addSubview:self.thirdButton];
    [self addSubview:self.attackButton];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //右下角扇形展开
    self.thirdButton.frame = CGRectMake(self.frame.size.width - 50, 0, 50, 50);
    self.secondButton.frame = CGRectMake(self.frame.size.width - 100, self.frame.size.height - 110, 50, 50);
    self.firstButton.frame = CGRectMake(0, self.frame.size.height - 50, 50, 50);
    self.attackButton.frame = CGRectMake(self.frame.size.width - 90, self.frame.size.height - 90, 80, 80);
    
    CGFloat radius = 100;
    self.firstButton.center = CGPointMake(0, radius);
    self.thirdButton.center = CGPointMake(radius, 0);
    self.secondButton.center = CGPointMake(radius * (1 - cos(M_PI_4)), radius * (1 - sin(M_PI_4)));
    
}

-(UIButton *)attackButton{
    if (!_attackButton) {
        _attackButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _attackButton.tag = 0;
        _attackButton.backgroundColor = [UIColor lightGrayColor];
        _attackButton.layer.cornerRadius = 40;
        _attackButton.layer.masksToBounds = YES;
        _attackButton.backgroundColor = [UIColor lightGrayColor];
        [_attackButton setTitle:@"普攻" forState:(UIControlStateNormal)];
        [_attackButton addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    return _attackButton;
}

-(UIButton *)firstButton{
    if (!_firstButton) {
        _firstButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _firstButton.tag = 1;
        _firstButton.backgroundColor = [UIColor lightGrayColor];
        _firstButton.layer.cornerRadius = 25;
        _firstButton.layer.masksToBounds = YES;
        _firstButton.backgroundColor = [UIColor lightGrayColor];
        [_firstButton setTitle:@"一技" forState:(UIControlStateNormal)];
        [_firstButton addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    return _firstButton;
}

-(UIButton *)secondButton{
    if (!_secondButton) {
        _secondButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _secondButton.tag = 2;
        _secondButton.backgroundColor = [UIColor lightGrayColor];
        _secondButton.layer.cornerRadius = 25;
        _secondButton.layer.masksToBounds = YES;
        _secondButton.backgroundColor = [UIColor lightGrayColor];
        [_secondButton setTitle:@"二技" forState:(UIControlStateNormal)];
        [_secondButton addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    return _secondButton;
}

-(UIButton *)thirdButton{
    if (!_thirdButton) {
        _thirdButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _thirdButton.tag = 3;
        _thirdButton.backgroundColor = [UIColor lightGrayColor];
        _thirdButton.layer.cornerRadius = 25;
        _thirdButton.layer.masksToBounds = YES;
        _thirdButton.backgroundColor = [UIColor lightGrayColor];
        [_thirdButton setTitle:@"大招" forState:(UIControlStateNormal)];
        [_thirdButton addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    return _thirdButton;
}

-(void)clicked:(UIButton*)sender{

    NSString* title = @"";
    
    switch (sender.tag) {
        case 1:
            title = @"荼毒";
            break;
        case 2:
            title = @"闪现";
            break;
            
        case 3:
            title = @"必杀";
            break;
            
        default:
            title = @"普通攻击";
            
            break;
    }
    
    NSLog(@"%@", title);
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL inside = [super pointInside:point withEvent:event];
    
    if (!inside) {
        CGPoint tempPoint = [self convertPoint:point toView:self];//将屏幕上的点转换到自己本身上
        for (UIView* view in self.subviews) {//遍历subViews
            if (CGRectContainsPoint(view.frame, tempPoint)) {//如果这个self上的这个点包含在子视图的frame内，就认为可以响应这个点击事件, 执行下面的代码
                inside = [view pointInside:[self convertPoint:point toView:view] withEvent:event];
                break;
            }
        }
        
    }
    
    return inside;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
