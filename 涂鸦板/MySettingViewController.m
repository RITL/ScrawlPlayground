//
//  MySettingViewController.m
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/27.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "MySettingViewController.h"
#import "SettingView.h"
#import "SettingManager.h"

@interface MySettingViewController ()

@property(nonatomic,strong)SettingView * settingView;

@property(nonatomic,strong)SettingManager * settingManager;

@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取单例
    self.settingManager = [SettingManager shareSettingManager];
    
    //初始化setting对象
    self.settingView = [[[NSBundle mainBundle] loadNibNamed:@"SettingView" owner:nil options:nil] lastObject];
    
    //设置frame
    self.settingView.frame = self.view.frame;
    
    
    //避免强引用循环
    __block __weak MySettingViewController * copy_self = self;
    
    
    
    //如果颜色调色器发生变化
    [self.settingView settingViewChangeColorBlockHandle:^(UIColor *lineColor)
    {
        //为设置管理者设置颜色
        [copy_self.settingManager settingManagerSetColor:lineColor withLineWidth:-1];

        
    }];
    
    //如果线宽调节器发生变化
    [self.settingView settingViewChangeLineWidthBlock:^(CGFloat lineWidth) {
       
        //为设置管理者设置线宽
        [copy_self.settingManager settingManagerSetColor:nil withLineWidth:lineWidth];
    }];
    
    //添加组件
    [self.view addSubview:self.settingView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
