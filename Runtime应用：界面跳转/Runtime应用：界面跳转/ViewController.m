//
//  ViewController.m
//  Runtime应用：界面跳转
//
//  Created by Dxc_iOS on 2019/4/15.
//  Copyright © 2019 jiyunkeji. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()
@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//  摘自  https://www.jianshu.com/p/89713ed70653
    //使用runtime实现万能跳转
    //1. 首先模拟简单的后台返回数据，下面的QinzVC为项目中不存在的控制器：
    self.dataArr = @[
                     @{@"class":@"SecondVC",//存在的控制器
                       @"data":@{@"name":@"小明"}
                       },
                     
                     @{@"class":@"QinzVC",//不存在的控制器
                       @"data":@{@"name":@"我是动态创建的控制器"}
                       },
                     ];
    
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(50, 100, 300, 40);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"跳转存在的控制器" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clicked1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(50, 250, 300, 40);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"跳转不存在的控制器" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(clicked2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
 
    
}
-(void)clicked1{
    [self pushToAnyVCWithData:self.dataArr[0]];
}
-(void)clicked2{
    [self pushToAnyVCWithData:self.dataArr[1]];
}

- (void)pushToAnyVCWithData:(NSDictionary *)dataDict{
    
    //1.获取类名
    const char *clsName = [dataDict[@"class"] UTF8String];
    //2.通过类型获取类
    Class cls = objc_getClass(clsName);
    //3. 如果不存在，使用runtime动态创建类
    if (!cls) {
        Class superClass = [UIViewController class];
        cls  = objc_allocateClassPair(superClass, clsName, 0);
        //添加属性
        class_addIvar(cls, "name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
        class_addIvar(cls, "showLB", sizeof(UILabel *), log2(sizeof(UILabel *)), @encode(UILabel *));
        //注册类
        objc_registerClassPair(cls);
        
        //添加方法
        Method method = class_getInstanceMethod([self class], @selector(myInstancemethod));
        IMP methodIMP = method_getImplementation(method);
        const char *types = method_getTypeEncoding(method);
        BOOL result = class_addMethod(cls, @selector(viewDidLoad), methodIMP, types);
        if (result) {
            NSLog(@"===  方法添加成功 =====");
        }
    }
    
    // 实例化对象
    id instance = nil;
    @try {
        //先尝试从SB中加载
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        instance = [sb instantiateViewControllerWithIdentifier:dataDict[@"class"]];
    } @catch (NSException *exception) {
        //SB中没有直接初始化
        instance = [[cls alloc] init];
        
    } @finally {
        NSLog(@"控制器实例化完成");
    }
    //获取后台返回的数据，给属性赋值
    NSDictionary *dict = dataDict[@"data"];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // 检测是否存在key的属性
        if (class_getProperty(cls, [key UTF8String])) {
            [instance setValue:obj forKey:key];
        }
        // 检测是否存在key的变量
        else if (class_getInstanceVariable(cls, [key UTF8String])){
            [instance setValue:obj forKey:key];
        }
    }];
    
    
    [self.navigationController pushViewController:instance animated:YES];
}


- (void)myInstancemethod {
    [super viewDidLoad];
    
    [self setValue:[UIColor orangeColor] forKeyPath:@"view.backgroundColor"];
    [self setValue:[[UILabel alloc] initWithFrame:CGRectMake(100, 300, 200, 44)] forKey:@"showLB"];
    UILabel *showTextLB = [self valueForKey:@"showLB"];
    [[self valueForKey:@"view"] addSubview:showTextLB];
    
    //设置属性
    showTextLB.text = [self valueForKey:@"name"];
    showTextLB.font = [UIFont systemFontOfSize:14];
    showTextLB.textColor = [UIColor blackColor];
    showTextLB.textAlignment = NSTextAlignmentCenter;
    showTextLB.backgroundColor = [UIColor whiteColor];
}
@end
