//
//  NSObject+Category.h
//  Runtime应用：关联对象
//
//  Created by Dxc_iOS on 2019/3/12.
//  Copyright © 2019 CJKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Category)
@property(nonatomic,copy)NSString *name;

@end

NS_ASSUME_NONNULL_END
