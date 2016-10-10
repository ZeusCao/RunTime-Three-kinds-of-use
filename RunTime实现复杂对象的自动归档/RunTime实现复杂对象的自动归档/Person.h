//
//  Person.h
//  RunTime实现复杂对象的自动归档
//
//  Created by Meetclass on 16/10/9.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+AutoEncode.h"
@interface Person : NSObject

@property(nonatomic, assign)NSInteger age;
@property(nonatomic, strong)NSString *gender;
@property(nonatomic, strong)NSString *name;

@end
