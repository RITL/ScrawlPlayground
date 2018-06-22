//
//  LineManager.h
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/24.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Line.h"

typedef void(^lineManagerDidChangeBlock)(NSArray * lines);

@interface LineManager : NSObject

/**
 *  存储线的数组
 */
@property(nonatomic,strong,readonly)NSArray * lines;

/**
 *  单例方法
 *
 *  @return 返回单例
 */
+(instancetype)shareLineMangaer;


/**
 *  新添加一条线，并初始化
 *
 *  @param point 起始点
 *  @param color 线的颜色
 *  @param width 线的宽度
 */
-(void)addPointWithStartEvents:(CGPoint)point WithColor:(UIColor *)color Width:(NSInteger)width;


/**
 *  为最后一次的线更新点
 *
 *  @param point 参数点
 */
-(void)addPointForLastLine:(CGPoint)point;


/**
 *  线数组发生变化时的回调
 *
 *  @param b block
 */
-(void)lineManagerDidChangeBlockHandle:(lineManagerDidChangeBlock)b;


/**
 *  根据按钮的点击tag值进行相应的操作
 *
 *  @param tag 按钮的tag值
 */
-(void)lineManagerDidChangeWithTag:(NSInteger)tag;



@end
