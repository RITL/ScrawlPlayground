//
//  Line.m
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/24.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "Line.h"

@interface Line ()

/**
 *  延展中点的数组
 */
@property(nonatomic,strong)NSMutableArray * mPoints;

@end

@implementation Line


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //初始化数组
        self.mPoints = [NSMutableArray array];
        
        //默认为红色
        self.lineColor = [UIColor redColor];
        
        //默认大小为2.0
        self.width = 2.0;
    }
    return self;
}




/**
 *  为线中添加点
 *
 *  @param point 添加的点
 */
-(void)addPoint:(CGPoint)point
{
    //转成NSValue类型的对象
    NSValue * value = [NSValue valueWithCGPoint:point];
    
    //添加到数组
    [self.mPoints addObject:value];
}




/**
 *  重写点数组的get方法
 *
 *  @return 返回点的数组
 */
-(NSArray *)points
{
    return [NSArray arrayWithArray:self.mPoints];
}





/**
 *  重写 贝赛尔曲线的get方法
 *
 *  @return 返回线的贝赛尔曲线
 */
-(UIBezierPath *)path
{
    
    //创建一个贝赛尔曲线
    UIBezierPath * pathTemp = [UIBezierPath bezierPath];
    
    //首先移动到第一个点
    [pathTemp moveToPoint:[self.mPoints[0] CGPointValue]];
    
    for (int i = 1 ;i < self.mPoints.count; i++)
    {
        //转成普通的点
        CGPoint point = [self.mPoints[i] CGPointValue];
        
        //贝赛尔曲线添加点
        [pathTemp addLineToPoint:point];
    }
    return pathTemp;
}



@end
