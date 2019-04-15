//
//  NSObject+Category.m
//  Runtime应用：关联对象
//
//  Created by Dxc_iOS on 2019/3/12.
//  Copyright © 2019 CJKT. All rights reserved.
//

#import "NSObject+Category.h"
//创建一个关联的key
static NSString *nameStr = @"nameStr";
@implementation NSObject (Category)

//添加对应的set和get方法
-(void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, &nameStr,nameStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSString *)name
{
    return objc_getAssociatedObject(self, &nameStr);
}



- (void)removeAssociatedObjects
{
    // 移除所有关联对象
    objc_removeAssociatedObjects(self);
}
@end
