//
//  LVPullDownMenuViewController.h
//  LVPullDownMenu
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LVPullDownMenuViewController : UIViewController
//用户布局使用的contentView,视图添加到contentView
@property(nonatomic, strong, readonly)UIView *contentView;

@property(nonatomic, assign)float animationTime;

//用户设置是否开启点击空白处退出或者上划退出
@property(nonatomic,assign)BOOL isSingleTapReturnOpen;
@property(nonatomic,assign)BOOL isUpSwipeReturnOpen;

- (void)subscribeReturnAnimationComplete:(void (^)(void))completeBlock;
- (void)subscribeReturnGestureRecognized:(void (^)(void))returnBlock;


- (void)appearAnimation;
- (void)disappearAnimation;

@end
