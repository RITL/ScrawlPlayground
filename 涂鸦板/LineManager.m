//
//  LineManager.m
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/24.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "LineManager.h"

@interface LineManager ()

@property(nonatomic,strong)NSMutableArray * linesArray;
@property(nonatomic,strong)NSMutableArray * deleteLinesArray;
@property(nonatomic,strong)lineManagerDidChangeBlock lineManagerDidChange;

@end


@implementation LineManager


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //初始化可变数组
        self.linesArray = [NSMutableArray array];
        self.deleteLinesArray = [NSMutableArray array];
    }
    return self;
}




+(instancetype)shareLineMangaer
{
    static LineManager * lineManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lineManager = [[LineManager alloc]init];
    });
    
    return lineManager;
}




-(void)addPointWithStartEvents:(CGPoint)point WithColor:(UIColor *)color Width:(NSInteger)width
{
    //创建一条线
    Line * line = [[Line alloc]init];
    
    //设置属性
    [line addPoint:point];
    line.lineColor = color;
    line.width = width;
    
    //添加到数组
    [self.linesArray addObject:line];
    
    //运行代码块通知VC
    if (self.lineManagerDidChange)
    {
        self.lineManagerDidChange(self.linesArray);
    }
    
}




-(void)addPointForLastLine:(CGPoint)point
{
    //获取最后一条线
    Line * line = [self.linesArray lastObject];
    
    //增加点
    [line addPoint:point];
    
    //运行代码块，通知VC
    if (self.lineManagerDidChange)
    {
        self.lineManagerDidChange(self.linesArray);
    }
}


-(void)lineManagerDidChangeBlockHandle:(lineManagerDidChangeBlock)b
{
    self.lineManagerDidChange = b;
}

/**
 *  删除前一根线
 */
-(void)beforeButtonToDeleteLine
{
    //如果线数组中的线存在线
    if (self.linesArray.count > 0)
    {
        //取出最后一根线
        Line * line = [self.linesArray lastObject];
        
        //缓存数组中添加
        [self.deleteLinesArray addObject:line];
        
        //从线数组中删除线
        [self.linesArray removeLastObject];
        
        //返回修改后的数组
        if (self.lineManagerDidChange)
        {
            self.lineManagerDidChange(self.linesArray);
        }
       
    }

}


/**
 *  恢复被删除的线
 */
-(void)nextButtonToRecoveryLine
{
    //如果删除线数组中存在线
    if (self.deleteLinesArray.count > 0)
    {
        //取出最后一根线
        Line * line = [self.deleteLinesArray lastObject];
        
        //将线加到线数组中
        [self.linesArray addObject:line];
        
        //删除缓存数组中的线
        [self.deleteLinesArray removeLastObject];
        
        //返回修改后的数组
        if (self.lineManagerDidChange)
        {
            self.lineManagerDidChange(self.linesArray);
        }
        
    }
}



/**
 *  删除所有储存的线
 */
-(void)clearButtonToRemoveLine
{
    //清空数组
    [self.linesArray removeAllObjects];
    [self.deleteLinesArray removeAllObjects];
    
    //返回修改后的数组
    if (self.lineManagerDidChange)
    {
        self.lineManagerDidChange(self.linesArray);
    }
    
}


-(void)lineManagerDidChangeWithTag:(NSInteger)tag
{
    //根据tag值进行相应的操作
    switch (tag) {
        case 0://撤销键
            [self beforeButtonToDeleteLine];
            break;
        case 1://恢复键
            [self nextButtonToRecoveryLine];
            break;
        case 2://清除键
            [self clearButtonToRemoveLine];
            break;
        default:
            break;
    }
}


@end
