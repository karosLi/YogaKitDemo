//
//  ViewController.m
//  YOGADemo
//
//  Created by karos li on 2018/1/19.
//  Copyright © 2018年 karos. All rights reserved.
//

#import "ViewController.h"
#import <YogaKit/YGLayout.h>
#import <YogaKit/UIView+Yoga.h>

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *disappearingView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.alignItems = YGJustifySpaceBetween;
    }];
    
    self.contentView = [UIView new];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentView.layer.borderWidth = 1.0;
    [self.contentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(self.view.bounds.size.width);
        layout.height = YGPointValue(300);
        layout.flexDirection = YGFlexDirectionRow;
        layout.justifyContent = YGJustifyCenter;
        layout.paddingHorizontal = YGPointValue(25);
    }];
    [self.view addSubview:self.contentView];
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [redView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.flexShrink = 1;
    }];
    [self.contentView addSubview:redView];
    
    self.disappearingView = [UIView new];
    self.disappearingView.backgroundColor = [UIColor blueColor];
    [self.disappearingView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
//        layout.width = YGPercentValue(40);
//        layout.flexShrink = 1;
    }];
    [self.contentView addSubview:self.disappearingView];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.button setTitle:@"Add Blue View" forState:UIControlStateSelected];
    [self.button setTitle:@"Remove Blue View" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonWasTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.button configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.height = YGPointValue(300);
        layout.width = YGPointValue(300);
        layout.alignSelf = YGAlignCenter;
    }];
    [self.view addSubview:self.button];
    
    [self.view.yoga applyLayoutPreservingOrigin:NO];
}

- (void)buttonWasTapped {
    self.button.selected = !self.button.selected;
    self.button.userInteractionEnabled = NO;
    
    self.disappearingView.yoga.isIncludedInLayout = !self.disappearingView.yoga.isIncludedInLayout;
    self.disappearingView.hidden = !self.disappearingView.hidden;
    
    [self.contentView.yoga applyLayoutPreservingOrigin:YES];
//     [self.view.yoga applyLayoutPreservingOrigin:NO];
    self.button.userInteractionEnabled = YES;
}

@end
