//
//  UIViewController+jisuan.m
//  RunTime交换消息（偷天换日）
//
//  Created by Meetclass on 16/10/10.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import "UIViewController+jisuan.h"
static int j = 0;
@implementation UIViewController (jisuan)


+ (void) load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(my_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        // 如果 swizzling 的是类方法, 采用如下的方式:
        // Class class = object_getClass((id)self);
        // ...
        // Method originalMethod = class_getClassMethod(class, originalSelector);
        // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
        
        //交换实现
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

#pragma mark - Method Swizzling

- (void)my_viewWillAppear:(BOOL)animated {
    [self my_viewWillAppear:animated];
    j ++;
    NSLog(@"出现了%d次", j);
}


@end
