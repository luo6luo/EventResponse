//
//  TestView.m
//  EventResponseDemo
//
//  Created by dundun on 2018/5/30.
//  Copyright © 2018年 dundun. All rights reserved.
//

#import "TestView.h"

@interface TestView()

@end

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)color index:(NSInteger)index
{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.backgroundColor = color;
    }
    return self;
}

# pragma mark - 触摸事件

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 一根或者多根手指开始触摸
    [[touches allObjects] enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITouch *touch = obj;
        NSLog(@"开始触摸：(%.2f, %.2f)", [touch locationInView:self].x, [touch locationInView:self].y);
    }];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 一根或者多根手机在屏幕上移动，只要移动就会触发
    [[touches allObjects] enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITouch *touch = obj;
        NSLog(@"触摸移动点：(%.2f, %.2f)", [touch locationInView:self].x, [touch locationInView:self].y);
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 一根或者多根手指离开屏幕
    [[touches allObjects] enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITouch *touch = obj;
        NSLog(@"结束触摸：(%.2f, %.2f)", [touch locationInView:self].x, [touch locationInView:self].y);
    }];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 结束触摸前，由系统强制退出或者来电，事件会被取消
    [[touches allObjects] enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITouch *touch = obj;
        NSLog(@"取消触摸：(%.2f, %.2f)", [touch locationInView:self].x, [touch locationInView:self].y);
    }];
}

- (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches
{
    // 预估触摸特性
    [[touches allObjects] enumerateObjectsUsingBlock:^(UITouch * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITouch *touch = obj;
        NSLog(@"预估触摸：%ld",touch.estimatedProperties);
    }];
}

# pragma mark - Hit test

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 判断是否能够接收事件
    if (!self.userInteractionEnabled || self.hidden || self.alpha < 0.01) {
        return nil;
    }
    
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    
    int subviewsCount = (int)self.subviews.count;
    for (int i = subviewsCount - 1; i >= 0; i--) {
        UIView *subview = self.subviews[i];
        // 判断是哪个视图
        // 高度 --> 灰：500、红色：100、绿色：200、白色：70、橘色：50
        NSLog(@"height:%.2f", subview.frame.size.height);
        
        // 转换坐标，将窗口上的坐标转换为子控件在父视图上的坐标
        CGPoint subviewPoint = [self convertPoint:point toView:subview];
        subview = [subview hitTest:subviewPoint withEvent:event];
        if (subview) {
            return subview;
        }
    }
    return self;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    // 如果控件不想被作为最佳接收事件者，可以直接认为触摸点不在自己身上，返回NO。默认是返回YES
//    return YES;
//}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

# pragma mark - 加速计事件

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

# pragma mark - 远程控制事件

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    
}

@end
