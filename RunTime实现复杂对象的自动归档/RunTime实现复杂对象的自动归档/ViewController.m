//
//  ViewController.m
//  RunTime实现复杂对象的自动归档
//
//  Created by Meetclass on 16/10/8.
//  Copyright © 2016年 Zeus. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  利用RunTime可以完成对复杂对象的归档
     */
    // 归档
    [self archiverModel];
    // 反归档
    [self unAchiverModel];
    
}

#pragma mark --- 归档 ---
- (void)archiverModel
{
    Person *p1 = [[Person alloc]init];
    p1.age = 18;
    p1.name = @"嘿嘿嘿";
    p1.gender = @"男";
    
    // 在沙盒docu路径下创建文件夹存储model
    // 获取document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"Person.txt"];
    NSFileManager *manager = [NSFileManager defaultManager];
    // 如果改路径不存在，则创建该路径
    if (![manager fileExistsAtPath:filePath]) {
        [manager createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    NSMutableData *data = [NSMutableData data];
    // 创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:p1 forKey:@"p1"];
    
    // 归档完成后必须写
    [archiver finishEncoding];
    
    //归档完成之后将数据写入文件夹
    
    BOOL flag = [data writeToFile:filePath atomically:YES];
    if (flag == YES) {
        NSLog(@"写入成功");
    }
    NSLog(@"%@",filePath);
    //NSLog(@"%@",data);

}


#pragma mark --- 反归档 ---
- (void)unAchiverModel
{
    // 找到存放model的文件夹路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"Person.txt"];
    // 接受该路径下的data
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    // 创建反归档的对象
    NSKeyedUnarchiver *unAchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    // 接受反归档后的对象
    Person *person1 = [unAchiver decodeObjectForKey:@"p1"];
    NSLog(@"%ld, %@, %@",person1.age, person1.gender,person1.name);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
