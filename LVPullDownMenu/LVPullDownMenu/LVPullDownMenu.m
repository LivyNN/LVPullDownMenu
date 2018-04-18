//
//  LVPullDownMenu.m
//  LVPullDownMenu
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LVPullDownMenu.h"
#import "LVPullDownMenuWindow.h"
#import "LVPullDownMenuViewController.h"

@interface LVPullDownMenu()

@property(nonatomic, strong, readwrite)LVPullDownMenuWindow *window;

@property(nonatomic, strong, readwrite)LVPullDownMenuViewController *viewController;
@end

@implementation LVPullDownMenu
- (instancetype)init{
    self = [super init];
    if (self){
        [self subscribeBlock];
    }
    return self;
}

- (void)subscribeBlock{
    __weak LVPullDownMenu *weakSelf = self;
    [self.viewController subscribeReturnAnimationComplete:^{
        [weakSelf releaseWindow];
    }];
    
    [self.viewController subscribeReturnGestureRecognized:^{
        [weakSelf hide];
    }];
}

- (void)show{
    [self.window makeKeyAndVisible];
}
- (void)hide{
    [self.viewController disappearAnimation];
}

- (void)releaseWindow{
    [self.window resignKeyWindow];
    _window = nil;
}

- (UIView *)contentView{
    return self.viewController.contentView;
}

- (LVPullDownMenuWindow *)window{
    if (!_window) {
        _window = [[LVPullDownMenuWindow alloc] init];
        _window.rootViewController = self.viewController;
    }
    return _window;
}

- (LVPullDownMenuViewController *)viewController{
    if (!_viewController) {
        _viewController = [[LVPullDownMenuViewController alloc] init];
        _viewController.isUpSwipeReturnOpen = YES;
        _viewController.isSingleTapReturnOpen = YES;
    }
    return _viewController;
}

- (void)setIsTapBlankReturnOpen:(BOOL)isTapBlankReturnOpen{
    _isTapBlankReturnOpen = isTapBlankReturnOpen;
    self.viewController.isSingleTapReturnOpen = isTapBlankReturnOpen;
}
- (void)setIsUpSwipeReturnOpen:(BOOL)isUpSwipeReturnOpen{
    _isUpSwipeReturnOpen = isUpSwipeReturnOpen;
    self.viewController.isUpSwipeReturnOpen = isUpSwipeReturnOpen;
}
- (void)setAnimationTime:(float)animationTime{
    _animationTime = animationTime;
    self.viewController.animationTime = animationTime;
}
@end
