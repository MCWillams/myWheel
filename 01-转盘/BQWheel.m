//
//  BQWheel.m
//  01-转盘
//
//  Created by 严必庆 on 15-6-6.
//  Copyright (c) 2015年 严必庆. All rights reserved.
//

#import "BQWheel.h"
#import "BQWheelButton.h"
@interface BQWheel()
- (IBAction)start;
@property (weak, nonatomic) IBOutlet UIImageView *rotateWheel;
/**
 *  选中按钮
 */
@property (nonatomic,weak) BQWheelButton *selectedButton;
/**
 *  displaylink 计数器
 */
@property (strong,nonatomic) CADisplayLink *link;
@end
@implementation BQWheel
/**
 *  加载xib文件
 *
 *  @return 大转盘view
 */
+(instancetype)wheel{
    return [[[NSBundle mainBundle]loadNibNamed:@"BQWheel" owner:nil options:nil] lastObject];
}
/**
 *  开始转动
 */
-(void)startRoatating{
    //1秒中刷新60次
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}
/**
 *  结束转动
 */
-(void)stop{
    [self.link invalidate];
    self.link = nil;
    
}

/**
 * displaylink 监听方法
 *
 */
-(void)update{
    self.rotateWheel.transform = CGAffineTransformRotate(self.rotateWheel.transform, M_PI_4 * 0.01);
}


/**
 *  这个方法中，属性才有值
 *  添加按钮上rotateView上
 */
-(void)awakeFromNib{
    self.rotateWheel.userInteractionEnabled = YES;
    for (int index = 0; index < 12; index++) {
        //创建button
        BQWheelButton *button = [BQWheelButton buttonWithType:UIButtonTypeCustom];
        
        //设置背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        //两套图片，从大图中切出小图
        UIImage *bigImage = [UIImage imageNamed:@"LuckyAstrology"];
        UIImage *bigPressedImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
        CGFloat smallW = bigImage.size.width / 12 * [UIScreen mainScreen].scale;
        CGFloat smallH = bigImage.size.height * [UIScreen mainScreen].scale;
        CGFloat smallX = index * smallW;
        CGFloat smallY = 0;
        CGImageRef smallImage = CGImageCreateWithImageInRect(bigImage.CGImage, CGRectMake(smallX, smallY, smallW, smallH));
        CGImageRef smallPressedImage = CGImageCreateWithImageInRect(bigPressedImage.CGImage, CGRectMake(smallX, smallY, smallW, smallH));
        [button setImage:[UIImage imageWithCGImage:smallImage] forState:UIControlStateNormal];
        [button setImage:[UIImage imageWithCGImage:smallPressedImage] forState:UIControlStateSelected];
        
        //设置button的位置
        button.bounds = CGRectMake(0, 0,68,143);
        button.layer.anchorPoint = CGPointMake(0.5, 1);
        button.layer.position = self.rotateWheel.center;
        CGFloat angle = 30 * index / 180.0 * M_PI;
        button.transform = CGAffineTransformMakeRotation(angle);
        
        //监听button点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        
        //添加button到rotateView上
        [self.rotateWheel addSubview:button];
        
        //默认选中第一张按钮
        if (index == 0) {
            button.selected = YES;
            self.selectedButton = button;
        }
    }
}

/**
 *  按钮点击处理
 *
 */
-(void)buttonClick:(BQWheelButton *)button{
    //1.之前选中按钮取消选中
    self.selectedButton.selected = NO;
    //2.当前按钮选中
    button.selected = YES;
    //3.当前按钮成为选中按钮
    self.selectedButton = button;
}

/**
 *  转动转盘按钮
 */
- (IBAction)start {
    //停止转动
    [self stop];
    //转盘禁止点击
    self.userInteractionEnabled = NO;
    //添加图层动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.toValue = @(M_PI * 6);
    animation.duration = 1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    [self.rotateWheel.layer addAnimation:animation forKey:nil];
}

#pragma mark - delegate
/**
 *  图层动画执行完调用
 */
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
        [self startRoatating];
    });
}








@end








