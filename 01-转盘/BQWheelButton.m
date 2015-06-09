//
//  BQWheelButton.m
//  01-转盘
//
//  Created by 严必庆 on 15-6-6.
//  Copyright (c) 2015年 严必庆. All rights reserved.
//

#import "BQWheelButton.h"

@implementation BQWheelButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageY = 20;
    CGFloat imageW = 40;
    CGFloat imageX = (contentRect.size.width - imageW) / 2;
    CGFloat imageH = 47;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(void)setHighlighted:(BOOL)highlighted{

}

@end
