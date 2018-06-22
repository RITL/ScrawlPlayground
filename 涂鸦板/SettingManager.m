//
//  SettingManager.m
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/27.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "SettingManager.h"

@interface SettingManager ()

@end

@implementation SettingManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //默认黑色颜色
        _lineColor = [UIColor blackColor];
        
        //默认线的宽度为2
        _lineWidth = 2;
        
    }
    return self;
}

+(instancetype)shareSettingManager
{
    static SettingManager * settingManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        settingManager = [[SettingManager alloc]init];
        
    });
    
    return settingManager;
}


-(void)settingManagerSetColor:(UIColor *)lineColor withLineWidth:(CGFloat)lineWidth
{
    //如果存在颜色
    if (lineColor)
    {
       _lineColor = lineColor;
        
    }
    
    //如果存在线宽
    if (lineWidth > 0)
    {
        _lineWidth = lineWidth;
    }
   
}


@end
