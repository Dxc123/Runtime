//
//  ViewController.m
//  Runtime应用:方法替换
//
//  Created by Dxc_iOS on 2019/4/15.
//  Copyright © 2019 jiyunkeji. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+Test.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, 200, 40)];
    label.abc = @"添加属性";
    label.text = @"动态添加方法";
    label.backgroundColor = [UIColor redColor];
    //动态添加方法
//    performSelector，它是在iOS中的一种方法调用方式。他可以向一个对象传递任何消息，而不需要在编译的时候声明这些方法
    [label performSelector:@selector(test:) withObject:@"test"];
    [self.view addSubview:label];
}


@end
