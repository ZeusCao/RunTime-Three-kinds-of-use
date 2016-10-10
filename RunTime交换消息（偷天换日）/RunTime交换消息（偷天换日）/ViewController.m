//
//  ViewController.m
//  RunTime交换消息（偷天换日）
//
//  Created by Meetclass on 16/10/10.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/**
 *  注意事项
 通常认为Swizzling是一个比较危险的技术，容易产生不可预料的行为和无法预见的后果，但只要遵循以下几个注意事项，其实method swizzlin还是相对安全的。
 总是调用一个方法的原始实现(除非你有足够好的理由不这么做):API提供了输入和输出的约定，但其中的实现却是黑盒。Swizzling 一个方法但不去调用其原始实现，可能造成私有状态的底层假设被打破，影响程序的其它部分。
 避免冲突: 给category方法加前缀，确保不会跟其它依赖的代码产生冲突。
 知道到底发生啥了：简单的复制粘贴swizzling 代码，而不清楚其如何工作不仅非常危险，而且浪费了好多深入学习objective-c运行时的机会，可以通过查看 Objective-C Runtime Reference 和<objc/runtime.h>头文件了解其中的一些来龙去脉。
 小心的处理：不管你在swizzling Foundation、UIKit或者其它内建framework方法时多么的充满自信，必须清楚在下一个版本这些可能都改变了，所以为了不出差错，还是需要多花点心思的。
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**  举例1：
         当我们要统计每个程序中所有button点击的次数，我们可以在UIControl的类目里使用method swizzling（方法交换),将点击button的系统方法和自定义的计算方法交换  
    */
    
    
    
    
    /**  举例2：
         记录一个iOS应用里每个view controller显示的次数
     */

    
    
}


// **********************************************  例1 **********************************************

#pragma mark --- 大button的点击事件
- (IBAction)bigAction:(id)sender {
    
    NSLog(@"大大大大大大大大");
}

#pragma mark --- 小Button的点击事件 ---
- (IBAction)littleAction:(id)sender {
    
    NSLog(@"小小小小小小小小");
}



// **********************************************  例2 **********************************************



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
