//
//  ViewController.m
//  WzryYaogan
//
//  Created by mac on 2017/10/27.
//  Copyright © 2017年 zuiye. All rights reserved.
//

#import "ViewController.h"
#import "JoystickView.h"
#import "Masonry.h"
#import "SkillView.h"
#import "Hero.h"

@interface ViewController ()<JoystickViewDelegate>

/** <#description#> */
@property (nonatomic, strong) Hero* hero;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JoystickView* joyview = [[JoystickView alloc] initWithFrame:CGRectMake(30, self.view.frame.size.width - 120, 80, 80)];
    [self.view addSubview:joyview];
    joyview.delegate = self;
    
    [joyview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.width.mas_equalTo(@120);
        make.height.mas_equalTo(@120);
    }];
    
    SkillView* skillView = [[SkillView alloc] initWithFrame:(CGRectZero)];
    [self.view addSubview:skillView];
    
    [skillView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        
        make.width.mas_equalTo(@(150));
        make.height.mas_equalTo(@(150));
    }];
    
    self.hero = [[Hero alloc] init];
    [self.view addSubview:self.hero.heroView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.hero.heroView.center = CGPointMake(self.view.frame.size.width / 2.0f, self.view.frame.size.height / 2.0f);
}

#pragma mark -
#pragma mark - JoystickViewDelegate
-(void)joystickView:(JoystickView *)joystickView angleChange:(CGFloat)angle{
    self.hero.angle = angle;
    [self.hero move];
}

-(void)joystickView:(JoystickView *)joystickView dragEnd:(CGFloat)angle{
    [self.hero stop];
}

#pragma mark - 屏幕旋转
-(BOOL)shouldAutorotate{
    
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscapeRight;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    
    return UIInterfaceOrientationLandscapeRight;
}

-(BOOL)prefersStatusBarHidden{
    
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
