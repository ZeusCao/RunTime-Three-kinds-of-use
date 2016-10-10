//
//  Dog.m
//  RunTime-消息转发
//
//  Created by Meetclass on 16/10/10.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import "Dog.h"
#import "Bird.h"

@interface Dog ()

@property(nonatomic, strong)Bird *bird;

@end

@implementation Dog

// 使用runTime实现消息转发 要实现两点
// 1.返回方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    // 先查看父类有没有该方法
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) // 父类不存在
    {
        // 获取Bird对应的方法签名
        _bird = [Bird new];
        // 获得方法签名
        signature = [_bird methodSignatureForSelector:aSelector];
    }
    return signature;
}

// 2. 实现消息转发
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    // 让bird去执行方法
    [anInvocation invokeWithTarget:_bird];
}








@end
