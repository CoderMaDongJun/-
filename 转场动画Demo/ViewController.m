//
//  ViewController.m
//  转场动画Demo
//
//  Created by 马栋军 on 2018/8/30.
//  Copyright © 2018年 DangDangWang. All rights reserved.
//

#import "ViewController.h"
#import "DDView.h"
@interface ViewController ()
@property (strong, nonatomic) UIView *ContainerView;

@end

@implementation ViewController
- (UIView *)ContainerView
{
    if (!_ContainerView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
        view.backgroundColor = [UIColor orangeColor];
        _ContainerView = view;
    }
    return _ContainerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)showClick:(UIButton *)sender {
    
    [self.view addSubview:self.ContainerView];
    [self showTransitionView];
}

- (IBAction)hiddenClick:(UIButton *)sender {
    [self hiddenTransitionView];
}


// 转场动画 -- 显示
- (void)showTransitionView
{
    // 1.截图
    UIView *snapView = [self.ContainerView snapshotViewAfterScreenUpdates:YES];
    
    self.ContainerView.backgroundColor = [self.ContainerView.backgroundColor colorWithAlphaComponent:0];
    
    // 3.切割小块
    NSMutableArray *xArray = [NSMutableArray array];
    NSMutableArray *yArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.ContainerView.frame.size.width; i= i+10) {
        [xArray addObject:@(i)];
    }
    for (NSInteger y = 0; y < self.ContainerView.frame.size.height; y=y+10) {
        [yArray addObject:@(y)];
    }
    
    NSMutableArray *snapShots = [[NSMutableArray alloc] init];
    for (NSNumber *x in xArray) {
        for (NSNumber *y in yArray) {
            CGRect snapshotRegion = CGRectMake([x doubleValue], [y doubleValue], 10, 10);
            
            UIView *snapshot = [snapView resizableSnapshotViewFromRect:snapshotRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            snapshot.frame = snapshotRegion;
            [self.ContainerView addSubview:snapshot];
            [snapShots addObject:snapshot];
        }
    }
    
    // 4.target动画
    for (UIView *view in snapShots) {
        view.transform = CGAffineTransformMakeTranslation([self randomRange:200 offset:0], [self randomRange:200 offset:0]);
    }
    
    // 5.动画
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        for (UIView *view in snapShots) {
            view.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        for (UIView *View in snapShots) {
            [View removeFromSuperview];
        }
        self.ContainerView.backgroundColor = [self.ContainerView.backgroundColor colorWithAlphaComponent:1];

    }];
}


// 转场动画 -- 消失
- (void)hiddenTransitionView
{
    UIView *snapView = [self.ContainerView snapshotViewAfterScreenUpdates:YES];
    self.ContainerView.backgroundColor = [self.ContainerView.backgroundColor colorWithAlphaComponent:0];
    
    NSMutableArray *xArray = [NSMutableArray array];
    NSMutableArray *yArray = [NSMutableArray array];
    for (NSInteger i = 0 ; i < self.ContainerView.frame.size.width; i+=10) {
        [xArray addObject:@(i)];
    }
    for (NSInteger i = 0 ; i < self.ContainerView.frame.size.height; i+=10) {
        [yArray addObject:@(i)];
    }
    NSMutableArray *snapshots = [NSMutableArray array];
    for (NSNumber *x in xArray) {
        for (NSNumber *y in yArray) {
            CGRect rect = CGRectMake(x.floatValue, y.floatValue, 10, 10);
            UIView *snapshot = [snapView resizableSnapshotViewFromRect:rect afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            snapshot.frame = rect;
            snapshot.transform = CGAffineTransformMakeTranslation([self randomRange:100 offset:0], [self randomRange:200 offset:100]);
            [self.ContainerView addSubview:snapshot];
        
            [snapshots addObject:snapshot];
        }
    }
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        for (UIView *view in snapshots) {
            view.frame = CGRectOffset(view.frame, [self randomRange:200 offset:-100], [self randomRange:200 offset:self.view.frame.size.height * 0.5]);
        }
    } completion:^(BOOL finished) {
        for (UIView *view in snapshots) {
            [view removeFromSuperview];
        }
        [self.ContainerView removeFromSuperview];
    }];
    
}



- (CGFloat)randomRange:(NSInteger)range offset:(NSInteger)offset{
    
    return (CGFloat)(arc4random()%range + offset);
}


@end
