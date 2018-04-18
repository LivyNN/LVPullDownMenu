//
//  LVPullDownMenu.h
//  LVPullDownMenu
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LVPullDownMenu : NSObject

//在这里添加你的视图
@property(nonatomic, strong,readonly)UIView *contentView;

@property(nonatomic, assign)BOOL isUpSwipeReturnOpen;
@property(nonatomic, assign)BOOL isTapBlankReturnOpen;

//动画执行的时间
@property(nonatomic, assign, readwrite)float animationTime;

- (void)show;
- (void)hide;

@end
