//
//  TouchEventsView.m
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/24.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import "TouchEventsView.h"
#import <Foundation/Foundation.h>


@interface TouchEventsView ()

@property(nonatomic,strong)TouchBeginEventsBlock  touchBeginEvents;
@property(nonatomic,strong)TouchMoveEventsBlock touchMoveEvents;
@property(nonatomic,strong)TouchEndEventsBlock  touchEndEvents;


@end


@implementation TouchEventsView


-(void)touchBeginEventsBlockHandle:(TouchBeginEventsBlock)b
{
    self.touchBeginEvents = b;
}

-(void)touchMoveEventsBlockHandle:(TouchMoveEventsBlock)b
{
    self.touchMoveEvents = b;
}

-(void)touchEndEventsBlockHandle:(TouchEndEventsBlock)b
{
    self.touchEndEvents = b;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //捕获点
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //运行代码块，通知VC
    if (self.touchBeginEvents)
    {
        self.touchBeginEvents(point);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //捕获点
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //运行代码块,通知VC
    if (self.touchMoveEvents)
    {
        self.touchMoveEvents(point);
    }
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //捕获点
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //运行代码块，通知VC
    if (self.touchEndEvents)
    {
        self.touchEndEvents(point);
    }

    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //捕获点
    CGPoint point = [[touches anyObject] locationInView:self];
 
    //运行代码块，通知VC
    if (self.touchEndEvents)
    {
        self.touchEndEvents(point);
    }
    
}


@end
