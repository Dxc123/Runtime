//
//  UILabel+Test.m
//  Runtime应用:方法替换
//
//  Created by Dxc_iOS on 2019/4/15.
//  Copyright © 2019 jiyunkeji. All rights reserved.
//

#import "UILabel+Test.h"
#import <objc/runtime.h>
//创建一个关联的key
static NSString *abcStr = @"abcStr";
@implementation UILabel (Test)
//添加对应的set方法

- (void)setAbc:(NSString *)abc {
    objc_setAssociatedObject(self, &abcStr, abc, OBJC_ASSOCIATION_COPY);
}



//添加get方法
- (NSString *)abc {
    return objc_getAssociatedObject(self, &abcStr);
}

#pragma mark -
//方法替换为

- (void)fu_setAbc:(NSString *)abc {
    NSLog(@"这里是替换setAbc后的方法");
}

+ (void)load {
    //方法替换 ： 将abc的set方法 替换成fu_setAbc
    SEL oldSel = @selector(setAbc:);
    SEL newSel = @selector(fu_setAbc:);
    
    Method oldMethod = class_getInstanceMethod(self, oldSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    
    //将newSel添加到当前类中，如果当前类有同名的实现，则返回NO
    BOOL boolean = class_addMethod(self, oldSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (boolean) {
        class_replaceMethod(self, newSel, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
    }else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

#pragma mark -

void test (id self, SEL _cmd, NSString *str) {
    NSLog(@"动态添加方法成功");
}

// 判断对象方法有没有实现
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == NSSelectorFromString(@"test:")) {
        //void用v来表示，id参数用@来表示，SEL用:来表示
        class_addMethod(self, sel, (IMP)test, "v@:@");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}
//// 判断类方法有没有实现
//+ (BOOL)resolveClassMethod:(SEL)sel

@end
