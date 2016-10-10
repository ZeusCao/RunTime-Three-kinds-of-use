//
//  NSObject+AutoEncode.m
//  RunTime实现复杂对象的自动归档
//
//  Created by Meetclass on 16/10/8.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import "NSObject+AutoEncode.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation NSObject (AutoEncode)

#pragma mark --- 归档 ---
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // 1.获取类中所有的实例变量，实例变量列表
    unsigned int count = 0;
    // 2.定义Ivar，copy
    Ivar *ivarArray = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        // 获取实例变量
        Ivar ivar = ivarArray[i];
        // 获取实例变量对应的名字
        const char *nameUTF = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:nameUTF];
        // 通过name获取对应变量的值
        id value = [self valueForKey:name];
        // 编码
        [aCoder encodeObject:value forKey:name];
    }
    // 因为是copy出来的，释放
    free(ivarArray);
}

#pragma mark --- 反归档 ---
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    // 在类目中如果想调用父类的方法不能用super要用self
    //self = [self initWithCoder:aDecoder];   // 这行代码坑爹至极，谁用谁知道！
    self = [self init];
    if (self) {
        // 1.获取实例变量列表
        unsigned int count = 0;
        Ivar *ivarArray = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            // 2.获取实例变量
            Ivar ivar = ivarArray[i];
            // 3.获取实例变量对应的名字
            const char *nameUTF = ivar_getName(ivar);
            NSString *name = [NSString stringWithUTF8String:nameUTF];
            // 4.通过name获取对应的值
            id value = [aDecoder decodeObjectForKey:name];
            // KVC给变量赋值
            [self setValue:value forKey:name];
        }
         // 释放
        free(ivarArray);
    }
    return self;
}


@end
