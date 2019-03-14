//
//  ViewController.m
//  Runtime应用：关联对象
//
//  Created by Dxc_iOS on 2019/3/12.
//  Copyright © 2019 CJKT. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Category.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//  Category添加属性  （RunTime关联对象方法）
//    RunTime给系统的类添加属性，首先需要了解对象与属性的关系。我们通过之前的学习知道，对象一开始初始化的时候其属性为nil，给属性赋值其实就是让属性指向一块存储内容的内存，使这个对象的属性跟这块内存产生一种关联。

//    那么如果想动态的添加属性，其实就是动态的产生某种关联就好了。而想要给系统的类添加属性，只能通过分类。
    
    
// 示例：  给 NSObject添加name属性
//   步骤：
//   1. 创建NSObject的分类
//    2..h文件导入头文件#import <objc/runtime.h>
//       使用@property给分类添加属性 ： @property(nonatomic,copy)NSString *name;
//3..m文件
//    -(void)setName:(NSString *)name
//    {
//        objc_setAssociatedObject(self, @"name",name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    -(NSString *)name
//    {
//        return objc_getAssociatedObject(self, @"name");
//    }
/**
 1.动态添加属性
 objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
 参数一：id object : 给哪个对象添加属性，这里要给自己添加属性，用self。
 参数二：void * == id key : 属性名，根据key获取关联对象的属性的值，在objc_getAssociatedObject中通过次key获得属性的值并返回。
 参数三：id value : 关联的值，也就是set方法传入的值给属性去保存。
 参数四：objc_AssociationPolicy policy : 策略，属性以什么形式保存。
 有以下几种
 
 typedef OBJC_ENUM(uintptr_t, objc_AssociationPolicy) {
 OBJC_ASSOCIATION_ASSIGN = 0,  // 指定一个弱引用相关联的对象
 OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, // 指定相关对象的强引用，非原子性
 OBJC_ASSOCIATION_COPY_NONATOMIC = 3,  // 指定相关的对象被复制，非原子性
 OBJC_ASSOCIATION_RETAIN = 01401,  // 指定相关对象的强引用，原子性
 OBJC_ASSOCIATION_COPY = 01403     // 指定相关的对象被复制，原子性
 };
 key值只要是一个指针即可，我们可以传入@selector(name)
 
 2.获得属性
 objc_getAssociatedObject(id object, const void *key);
 参数一：id object : 获取哪个对象里面的关联的属性。
 参数二：void * == id key : 什么属性，与objc_setAssociatedObject中的key相对应，即通过key值取出value。
 
 3.移除所有关联对象
 - (void)removeAssociatedObjects
 {
 // 移除所有关联对象
 objc_removeAssociatedObjects(self);
 }
 
 此时已经成功给NSObject添加name属性，并且NSObject对象可以通过点语法为属性赋值。
 */
    
  
//    4.使用 ：
    NSObject *objc = [[NSObject alloc]init];
    objc.name = @"xx_cc";
    NSLog(@"%@",objc.name);//xx_cc
    
    
    
}


@end
