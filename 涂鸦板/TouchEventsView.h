//
//  TouchEventsView.h
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/24.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^TouchBeginEventsBlock)(CGPoint point);
typedef void(^TouchMoveEventsBlock)(CGPoint point);
typedef void(^TouchEndEventsBlock)(CGPoint point);

@interface TouchEventsView : UIView


/*设置block*/
-(void)touchBeginEventsBlockHandle:(TouchBeginEventsBlock)b;

-(void)touchMoveEventsBlockHandle:(TouchMoveEventsBlock)b;

-(void)touchEndEventsBlockHandle:(TouchEndEventsBlock)b;


@end
