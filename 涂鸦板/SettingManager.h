//
//  SettingManager.h
//  涂鸦板
//
//  Created by YueXiaoWen on 15/9/27.
//  Copyright (c) 2015年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SettingManager : NSObject

@property(nonatomic,strong,readonly)UIColor * lineColor;

@property(nonatomic,assign,readonly)CGFloat lineWidth;

-(void)settingManagerSetColor:(UIColor *)lineColor withLineWidth:(CGFloat)lineWidth;

+(instancetype)shareSettingManager;

@end
