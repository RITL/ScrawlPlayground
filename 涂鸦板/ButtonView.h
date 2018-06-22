//
//  ButtonView.h
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/26.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonPressedInButtonViewBlock)(NSInteger buttonTag);

@interface ButtonView : UIView

/*设置block*/
-(void)buttonPressedBlockHandle:(buttonPressedInButtonViewBlock)b;

@end
