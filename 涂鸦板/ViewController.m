//
//  ViewController.m
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/24.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "ViewController.h"
#import "TouchEventsView.h"
#import "RenderView.h"
#import "LineManager.h"
#import "ButtonView.h"
#import "MySettingViewController.h"
#import "SettingManager.h"


#define touchFrame (CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44))

@interface ViewController ()

@property(nonatomic,strong)TouchEventsView * touchEventsView;

@property(nonatomic,strong)RenderView * renderView;

@property(nonatomic,strong)LineManager * lineManager;

@property(nonatomic,strong)SettingManager * settingManager;

@property(nonatomic,strong)ButtonView * buttonView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化线的管理者
    self.lineManager = [LineManager shareLineMangaer];
    
    //初始化设置管理者
    self.settingManager = [SettingManager shareSettingManager];
    
    //初始化触碰view
    self.touchEventsView = [[TouchEventsView alloc]initWithFrame:touchFrame];

    //初始化绘图view
    self.renderView = [[RenderView alloc]initWithFrame:touchFrame];
    
    //初始化按钮view
    self.buttonView = [[ButtonView alloc]initWithFrame:CGRectMake(0, self.touchEventsView.frame.size.height, self.view.frame.size.width, 44)];
    
    //配置导航栏的相关组件
    [self otherSetting];
    
    //避免强引用循环
    __weak __block ViewController * copy_self = self;
    
    //当开始触摸屏幕的时候
    [self.touchEventsView touchBeginEventsBlockHandle:^(CGPoint point) {
    
        //管理者创建线并且添加点为起始点
        [copy_self.lineManager addPointWithStartEvents:point WithColor:copy_self.settingManager.lineColor  Width:copy_self.settingManager.lineWidth];
        
    }];
    
    //手在触摸屏上移动的时候
    [self.touchEventsView touchMoveEventsBlockHandle:^(CGPoint point) {
       
        //管理者为最后一个线更新点
        [copy_self.lineManager addPointForLastLine:point];
        
    }];
    
    //手离开触摸屏的时候
    [self.touchEventsView touchEndEventsBlockHandle:^(CGPoint point) {
       
        //管理者为最后一个线更新点
        [copy_self.lineManager addPointForLastLine:point];
        
    }];
    
    //线的数组发生变化时
    [self.lineManager lineManagerDidChangeBlockHandle:^(NSArray *lines) {
       
        //渲染视图绘制
        [copy_self.renderView setRenderLines:lines];
        
    }];
    
    //buttonView被点击
    [self.buttonView buttonPressedBlockHandle:^(NSInteger buttonTag) {
       
        //管理者根据不同的tag值执行相应的操作
        [copy_self.lineManager lineManagerDidChangeWithTag:buttonTag];
    }];
    
    
    //设置背景颜色
    self.touchEventsView.backgroundColor = [UIColor whiteColor];
    self.renderView.backgroundColor = [UIColor clearColor];
    
    //添加
    [self.view addSubview:self.buttonView];
    [self.view addSubview:self.touchEventsView];
    [self.touchEventsView addSubview:self.renderView];
  
}

/**
 *  配置导航栏的相关组件
 */
-(void)otherSetting
{
    //添加左右两个tabBarbutton
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(toSavePicture)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(toSettingViewContoller)];
}

/**
 *  跳转页面的回调方法
 */
-(void)toSettingViewContoller
{
    //创建settingViewController对象
    MySettingViewController * mySettingViewController = [[MySettingViewController alloc]init];
    
    //跳转
    [self.navigationController pushViewController:mySettingViewController animated:YES];
    
}

/**
 *  保存当前图片(截屏)
 */
-(void)toSavePicture
{
    //创建一个基于位图的图形上下文并指定大小
    UIGraphicsBeginImageContext(self.renderView.bounds.size);
    
    //renderIncontext呈现接受者以及其子范围到指定的上下文
    [self.renderView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //返回一个基于当前图形上的上下文图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    //移除栈定基于当前位图的图形上下文
    UIGraphicsEndImageContext();
    
    //将图片保存到图片库
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
