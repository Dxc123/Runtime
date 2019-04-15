//
//  UILabel+Test.h
//  Runtime应用:方法替换
//
//  Created by Dxc_iOS on 2019/4/15.
//  Copyright © 2019 jiyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Test)
//添加一个abc属性
@property (nonatomic, strong) NSString *abc;
@end

NS_ASSUME_NONNULL_END
