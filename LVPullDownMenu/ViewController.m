//
//  ViewController.m
//  LVPullDownMenu
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LVPullDownMenu.h"
//demo
@interface ViewController ()

@property(nonatomic, strong)LVPullDownMenu *menu;

@property(nonatomic, strong)UIView *customView;

@property(nonatomic, strong)UIButton *showButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.menu.contentView addSubview:self.customView];
    self.customView.frame = CGRectMake(0, 0, self.menu.contentView.frame.size.width, self.menu.contentView.frame.size.height/2);
    //点击空白处可退出
    [self.view addSubview:self.showButton];
    self.showButton.center = self.view.center;
    self.showButton.bounds = CGRectMake(0, 0, 100, 100);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LVPullDownMenu *)menu{
    if (!_menu) {
        _menu = [[LVPullDownMenu alloc] init];
        _menu.isUpSwipeReturnOpen = YES;
        _menu.isTapBlankReturnOpen = YES;
        _menu.animationTime = 0.4;
    }
    return _menu;
}

- (UIView *)customView{
    if (!_customView) {
        _customView = [[UIView alloc] init];
        _customView.backgroundColor = [UIColor blackColor];
    }
    return _customView;
}

- (UIButton *)showButton{
    if (!_showButton) {
        _showButton = [[UIButton alloc] init];
        [_showButton setTitle:@"SHOW" forState:UIControlStateNormal];
        [_showButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showButton setBackgroundColor:[UIColor purpleColor]];
        [_showButton addTarget:self action:@selector(showButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showButton;
}
- (void)showButtonClicked{
    [self.menu show];
}
@end
