//
//  UIControl+Calculate.m
//  RunTime交换消息（偷天换日）
//
//  Created by Meetclass on 16/10/10.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import "UIControl+Calculate.h"

static int i = 0; // 定义全局变量计算button被点击的次数

@implementation UIControl (Calculate)

/**
 *  Swizzling应该只在load方法中使用
 oc会在运行时自动调用每个类的两个方法，+load 会在类初始化加载的时候调用；+initialize方法会在程序调用类的第一个实例或者类方法的时候调用。这两个方法都是可选的，只会在实现的时候才去调用。由于method swizzling会影响到全局的状态，因此最小化竞争条件的出现变得很重要，+load方法能够确保在类的初始化时候调用，这能够保证改变应用行为的一致性，而+initialize在执行时并不提供这种保证，实际上，如果没有直接给这个类发送消息，该方法可能都不会调用到。
 */
+ (void)load
{
    
    /**
     *  Swizzling应该只在dispatch_once中完成
       由于swizzling会改变全局状态，所以我们需要在运行时采取一些预防措施。原子性就是其中的一种预防措施，因为它能保证不管有多少个线程，代码只会执行一次。GCD的dispatch_once 能够满足这种需求，因此在method swizzling应该将其作为最佳的实践方式
     */
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method1 = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
        Method method2 = class_getInstanceMethod([self class], @selector(calculate));
        // 如果交换的是+号方法（类方法）写成：
//        Method method1 = class_getInstanceMethod(object_getClass((id)self), @selector(sendAction:to:forEvent:));
//        Method method2 = class_getInstanceMethod(object_getClass((id)self), @selector(calculate));
        
        // 交换两个方法的实现
        method_exchangeImplementations(method1, method2);
    });
    
}

#pragma mark --- 用于交换button点击事件的方法 ---
- (void)calculate
{
    [self calculate]; // 不会造成死循环、栈溢出，因为此时该方法已经和button点击事件的方法做了交换
    i ++;
    NSLog(@"已经点击了%d次",i);
}


@end
