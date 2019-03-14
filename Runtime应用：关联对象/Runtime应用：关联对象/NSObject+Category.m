//
//  NSObject+Category.m
//  Runtime应用：关联对象
//
//  Created by Dxc_iOS on 2019/3/12.
//  Copyright © 2019 CJKT. All rights reserved.
//

#import "NSObject+Category.h"

@implementation NSObject (Category)

-(void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, @"name",name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSString *)name
{
    return objc_getAssociatedObject(self, @"name");
}





- (void)removeAssociatedObjects
{
    // 移除所有关联对象
    objc_removeAssociatedObjects(self);
}
@end
