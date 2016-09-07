//
//  NSString+Methodswizzling.m
//  Methodswizzling
//
//  Created by chairman on 16/9/7.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "NSString+Methodswizzling.h"
#import <objc/runtime.h>
@implementation NSString (Methodswizzling)
+(void)load {
    //* 交换lowercaseString／uppercaseString*/
    //* 使之调用uppercaseString会执行lowercaseString，调用lowercaseString会执行uppercaseString */
    Method originalMethod = class_getInstanceMethod(self, @selector(lowercaseString));
#warning 在测试lower和upper方法互换的时候请打开这两行代码,并注释eoc_myMethod、exchange方法和｀eoc_myLowercaseString｀方法
//    Method swappendMethod = class_getInstanceMethod(self, @selector(uppercaseString));
//    method_exchangeImplementations(originalMethod, swappendMethod);

#warning 在测试eoc_myLowercaseString方法的时候请注释上面两行代码，并打开｀eoc_myLowercaseString｀方法
    Method eoc_myMethod = class_getInstanceMethod(self, @selector(eoc_myLowercaseString));
    method_exchangeImplementations(originalMethod, eoc_myMethod);
}


/** 在实现lowercaseString的时候再执行自定义的方法 */
- (NSString *)eoc_myLowercaseString {
    //* 这样看起来会进入死循环，但是我们在load的时候就进行了方法的交换 */
    NSString *lowercase = [self eoc_myLowercaseString];
    NSLog(@"%@=> %@",self,lowercase);
    return lowercase;
}
@end
