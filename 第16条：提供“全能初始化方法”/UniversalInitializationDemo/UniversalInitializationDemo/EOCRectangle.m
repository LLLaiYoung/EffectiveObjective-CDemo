//
//  EOCRectangle.m
//  UniversalInitializationDemo
//
//  Created by chairman on 16/9/8.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "EOCRectangle.h"

@implementation EOCRectangle

//* EOCRectangle类的全能初始化方法 */
- (id)initWithWidth:(float)width andHeight:(float)height {
    if (self = [super init]) {
        _width = width;
        _height = height;
    }
    return self;
}

//* 下面两种方法任选其一 */

/** 默认宽高为0.5 */
- (instancetype)init {
    return [self initWithWidth:0.5 andHeight:0.5];
}

///** 抛出异常 */
//- (instancetype)init {
//    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Must user initWitWidth:andHeight: instead." userInfo:nil];
//}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _width = [aDecoder decodeFloatForKey:@"width"];
        _height = [aDecoder decodeFloatForKey:@"height"];
    }
    return self;
}

#warning 请注意，NSCoding协议在初始化的方法没有调用本类的全能初始化方法，而是调用了超类的相关方法(init)。然而，若超类也实现了NSCoding，则需要改为调用超类的“initWithCoder:”初始化方法。

@end
