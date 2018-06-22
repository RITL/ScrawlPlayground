//
//  ButtonView.m
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/26.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "ButtonView.h"

@interface ButtonView ()

@property(nonatomic,strong)UIButton * beforeButton;//返回先一步，消除一条线
@property(nonatomic,strong)UIButton * nextButton;//撤销前一步
@property(nonatomic,strong)UIButton * clearButton;//清除所有的线

@property(nonatomic,strong)buttonPressedInButtonViewBlock buttonPressedBlock;

@end

@implementation ButtonView


-(void)awakeFromNib
{
    [self myInitView];
}



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self myInitView];
    }
    return self;
}

-(void)myInitView
{
    //初始化按钮属性
    self.beforeButton = [self myButtonInitWithTitle:@"撤销" Tag:0];
    self.nextButton = [self myButtonInitWithTitle:@"恢复" Tag:1];
    self.clearButton = [self myButtonInitWithTitle:@"清除" Tag:2];
    
    //添加组件
    [self addSubview:self.beforeButton];
    [self addSubview:self.nextButton];
    [self addSubview:self.clearButton];
    
    //设置背景颜色
    self.backgroundColor = [UIColor whiteColor];
    
    //为按钮进行布局
    [self myLayoutConstrains];

}


/**
 *  自定义按钮初始化
 *
 *  @param title 按钮上的文字
 *  @param tag   按钮的tag值
 *
 *  @return 初始化按钮的地址
 */
-(UIButton *)myButtonInitWithTitle:(NSString *)title Tag:(NSInteger)tag
{
    //初始化按钮，系统类型的
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    //设置tag值
    button.tag = tag;
    
    //设置按钮上的文字
    [button setTitle:title forState:UIControlStateNormal];
    
    //取消按钮的自动布局
    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    //确定button的目标动作回调
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //返回创建好按钮的地址
    return button;
}

/**
 *  按钮被点击
 *
 *  @param button 进行目标动作回调的按钮
 */
-(void)buttonPressed:(UIButton *)button
{
    //自身的回调存在
    if (self.buttonPressedBlock)
    {
        //返回按钮的tag值
        self.buttonPressedBlock(button.tag);
    }
}

/**
 *  开始布局
 */
-(void)myLayoutConstrains
{
    //设置水平布局
    NSArray * buttonHorizatal = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-[_beforeButton]-[_nextButton(==_beforeButton)]-[_clearButton(==_beforeButton)]-|"] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_beforeButton,_nextButton,_clearButton)];
    [self addConstraints:buttonHorizatal];
    
    //设置垂直布局
    NSArray * buttonVerital1 = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-7-[_beforeButton(30)]-7-|"] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_beforeButton)];
    [self addConstraints:buttonVerital1];
    
    NSArray * buttonVerital2 = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-7-[_nextButton(30)]-7-|"] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nextButton)];
    [self addConstraints:buttonVerital2];
    
    NSArray * buttonVerital3 = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-7-[_clearButton(30)]-7-|"] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_clearButton)];
    [self addConstraints:buttonVerital3];
}


/**
 *  设置代码块功能
 *
 *  @param b tag参数代码块
 */
-(void)buttonPressedBlockHandle:(buttonPressedInButtonViewBlock)b
{
    self.buttonPressedBlock = b;
}

@end
