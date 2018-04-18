//
//  LVPullDownMenuViewController.m
//  LVPullDownMenu
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LVPullDownMenuViewController.h"

@interface LVPullDownMenuViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic, strong, readwrite)UIView *contentView;

@property(nonatomic, strong, readwrite)UITapGestureRecognizer *singleTapRecognizer;
@property(nonatomic, strong, readwrite)UISwipeGestureRecognizer *swipeRecognizer;

@property(nonatomic, copy)void (^returnAnimationCompleteBlock)(void);
@property(nonatomic, copy)void (^returnGestureRecognizedBlock)(void);

@end

@implementation LVPullDownMenuViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubViews];
        [self addGestures];
    }
    return self;
}

- (void)addSubViews{
    [self.view addSubview:self.contentView];
}

- (void)addGestures{
    [self.contentView addGestureRecognizer:self.singleTapRecognizer];
    [self.contentView addGestureRecognizer:self.swipeRecognizer];
}

- (void)subscribeReturnAnimationComplete:(void (^)(void))completeBlock{
    self.returnAnimationCompleteBlock = completeBlock;
}
- (void)subscribeReturnGestureRecognized:(void (^)(void))returnBlock{
    self.returnGestureRecognizedBlock = returnBlock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.contentView.frame = self.view.frame;
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self adjustInitialPosition];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self appearAnimation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (gestureRecognizer == self.singleTapRecognizer) {
        if (self.isSingleTapReturnOpen) {
            if (touch.view == self.contentView) {
                return YES;
            }else{
                return NO;
            }
        }else{
            return NO;
        }
    }else if(gestureRecognizer == self.swipeRecognizer){
        if (self.isUpSwipeReturnOpen) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}


- (void)adjustInitialPosition{
    if (self.contentView.center.y>0) {
        CGPoint viewCenter = self.contentView.center;
        viewCenter.y -= self.contentView.frame.size.height;
        self.contentView.center = viewCenter;
    }
}

- (void)appearAnimation{
    if (self.contentView.center.y<0) {
        __weak LVPullDownMenuViewController *weakSelf = self;
        CGPoint viewCenter = self.contentView.center;
        viewCenter.y += self.contentView.frame.size.height;
        //系统优化，可以不使用weak
        [UIView animateWithDuration:self.animationTime>0?self.animationTime:0.3 animations:^{
            weakSelf.contentView.center = viewCenter;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)disappearAnimation{
    if (self.contentView.center.y>0) {
        CGPoint viewCenter = self.contentView.center;
        viewCenter.y -= self.contentView.frame.size.height;
        //系统优化，可以不使用weak
        __weak LVPullDownMenuViewController *weakSelf = self;
        [UIView animateWithDuration:self.animationTime>0?self.animationTime:0.3 animations:^{
            weakSelf.contentView.center = viewCenter;
        } completion:^(BOOL finished) {
            if (weakSelf.returnAnimationCompleteBlock) {
                weakSelf.returnAnimationCompleteBlock();
            }
        }];
    }
}

- (void)returnGestureRecognized{
    if (self.returnGestureRecognizedBlock) {
        self.returnGestureRecognizedBlock();
    }
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UITapGestureRecognizer *)singleTapRecognizer{
    if (!_singleTapRecognizer) {
        _singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnGestureRecognized)];
        _singleTapRecognizer.delegate = self;
        
    }
    return _singleTapRecognizer;
}
- (UISwipeGestureRecognizer *)swipeRecognizer{
    if (!_swipeRecognizer) {
        _swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(returnGestureRecognized)];
        [_swipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
        _swipeRecognizer.delegate = self;
    }
    return _swipeRecognizer;
}

@end
