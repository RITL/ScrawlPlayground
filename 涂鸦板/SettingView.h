//
//  SettingView.h
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/27.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^settingViewChangeColorBlock)(UIColor * lineColor);

typedef void(^settingViewChangeLineWidthChangeBlock)(CGFloat lineWidth);

@interface SettingView : UIView

/*设置block*/

-(void)settingViewChangeColorBlockHandle:(settingViewChangeColorBlock)colorChangeBlock;

-(void)settingViewChangeLineWidthBlock:(settingViewChangeLineWidthChangeBlock)lineWidthChangeBlock;


@end
