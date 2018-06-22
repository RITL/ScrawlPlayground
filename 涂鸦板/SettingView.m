//
//  SettingView.m
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/27.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "SettingView.h"

@interface SettingView ()

/**
 *  红色调节器
 */
@property (strong, nonatomic) IBOutlet UISlider *redColorSlider;

/**
 *  绿色调节器
 */
@property (strong, nonatomic) IBOutlet UISlider *greenColorSlider;

/**
 *  蓝色调节器
 */
@property (strong, nonatomic) IBOutlet UISlider *blueColorSlider;


/**
 *  线宽调节器
 */
@property (strong, nonatomic) IBOutlet UISlider *lineWidthSlider;


/**
 *  颜色预览
 */
@property (strong, nonatomic) IBOutlet UILabel *colorText;

@property(nonatomic,strong)settingViewChangeColorBlock colorChangeBlock;

@property(nonatomic,strong)settingViewChangeLineWidthChangeBlock lineWidthChangeBlock;

@end

@implementation SettingView


/*  block 的设置  */
-(void)settingViewChangeColorBlockHandle:(settingViewChangeColorBlock)colorChangeBlock
{
    self.colorChangeBlock = colorChangeBlock;
}

-(void)settingViewChangeLineWidthBlock:(settingViewChangeLineWidthChangeBlock)lineWidthChangeBlock
{
    self.lineWidthChangeBlock = lineWidthChangeBlock;
}




/**
 *  颜色调节器发生变化的回调
 *
 *  @param sender 调节器的发送者
 */
- (IBAction)colorSliderChanged:(id)sender
{
    //根据 三原色 以及 透明度 创建Color对象
    UIColor * lineColor = [UIColor colorWithRed:(self.redColorSlider.value / 255) green:(self.greenColorSlider.value / 255) blue:(self.blueColorSlider.value / 255) alpha:1];
    
    
//    NSLog(@"\nred: %ld,   green: %ld,   blue: %ld",self.redColorSlider.value,self.greenColorSlider.value,self.blueColorSlider.value);
    
    //改变预览label的颜色
    self.colorText.textColor = lineColor;
    
    //如果代码块存在
    if (self.colorChangeBlock)
    {
        self.colorChangeBlock(lineColor);
    }
}



/**
 *  线的宽度调节器发生变化的回调
 *
 *  @param sender 调节器的发送者
 */
- (IBAction)lineWidthsliderChanged:(id)sender
{
    
    //获取 线的宽度
    CGFloat lineWidth = self.lineWidthSlider.value;
    
    //如果代码块存在
    if (self.lineWidthChangeBlock)
    {
        self.lineWidthChangeBlock(lineWidth);
    }
}


@end
