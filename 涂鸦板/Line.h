//
//  Line.h
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/24.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//typedef void(^LineBlock)(UIBezierPath * path);

@interface Line : NSObject

/**
 *  线的颜色
 *  默认是红色
 */
@property(nonatomic,strong)UIColor * lineColor;

/**
 *  线的宽度
 *  默认宽度是2.0
 */
@property(nonatomic,assign)NSInteger width;

/**
 *  存储路径点的数组
 */
@property(nonatomic,strong,readonly)NSArray * points;

/**
 *  贝赛尔曲线
 */
@property(nonatomic,strong,readonly)UIBezierPath * path;


/**
 *  添加点
 *
 *  @param point 添加的点
 */
-(void)addPoint:(CGPoint)point;


@end
