//
//  RenderView.m
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/24.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "RenderView.h"
#import "LineManager.h"

@interface RenderView ()

@property(nonatomic,strong)NSArray * lines;

@end

@implementation RenderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lines = [NSArray array];
    }
    return self;
}



/**
 *  设置线的数组
 *
 *  @param array 参数line数组
 */
-(void)setRenderLines:(NSArray *)array
{
    self.lines = array;
    
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    
    for (Line * line in self.lines)
    {
        UIBezierPath * path = line.path;
    
        //设置宽度
        path.lineWidth = line.width;
    
        //设置颜色
        [line.lineColor setStroke];
        
        //根据贝赛尔曲线进行绘图
        [path stroke];
    }
    
}


@end
