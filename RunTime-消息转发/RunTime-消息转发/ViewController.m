//
//  ViewController.m
//  RunTime-消息转发
//
//  Created by Meetclass on 16/10/10.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import "ViewController.h"
#import "Dog.h"

//#import <objc/runtime.h>
//#import <objc/message.h>
// 或者
//#import <objc/objc-runtime.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 利用runtime可以实现消息转发，可以让改类去实现其他类的方法
    // 让狗去执行鸟的方法：飞
    Dog *myDog = [[Dog alloc]init];
    [myDog performSelector:@selector(fly)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
