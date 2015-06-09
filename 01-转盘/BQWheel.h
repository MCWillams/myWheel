//
//  BQWheel.h
//  01-转盘
//
//  Created by 严必庆 on 15-6-6.
//  Copyright (c) 2015年 严必庆. All rights reserved.
//
/**
 *  封装我们的大转盘
 */
#import <UIKit/UIKit.h>

@interface BQWheel : UIView
+(instancetype)wheel;
-(void)startRoatating;
@end
