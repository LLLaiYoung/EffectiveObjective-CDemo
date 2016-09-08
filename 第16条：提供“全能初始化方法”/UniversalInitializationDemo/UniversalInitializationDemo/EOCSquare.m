//
//  EOCSquare.m
//  UniversalInitializationDemo
//
//  Created by chairman on 16/9/8.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "EOCSquare.h"

@implementation EOCSquare

//* EOCSquare类的全能初始化方法 */
- (id)initWithDimension:(float)dimension {
    return [super initWithWidth:dimension andHeight:dimension];
}

//* 重写超类的全能初始化方法，取最大值作为边长 */
- (id)initWithWidth:(float)width andHeight:(float)height {
    float dimension = MAX(width, height);
    return [super initWithWidth:dimension andHeight:dimension];
}

////* 不允许此类调用父类的全能初始化方法 */
//- (id)initWithWidth:(float)width andHeight:(float)height {
//    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Must user initWithDimension: instead." userInfo:nil];
//}

#warning 即便使用init来初始化EOCSquare对象，也能照常工作。原因在于，EOCRectangle类覆写了init方法，并以默认值为参数，调用了该类(EOCRectangle)的全能初始化方法。在用init方法初始化EOCSquare对象时，也会这么调用，不过由于“initWithWidht:andHeight:”已经在子类中覆写了，所以实际上执行的是EOCSquare类的这一份代码，而此代码又会调用本类的全能初始化方法。因此一切正常，调用者不可能创建出边长不相等的EOCSquare对象。


#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //EOCSquare's specific initalizer
    }
    return self;
}
#warning 若超类也实现了NSCoding，则需要改为调用超类的“initWithCoder:”初始化方法。

#warning 每个子类的全能初始化方法都应该调用其超类的对应方法，并逐层向上，实现“initWithCoder:”时也要这样，应该先调用超类的相关方法，然后再执行与本类有关的任务。这样编写出来的EOCSquare类就能完全遵守NSCoding协议了。如果编写“initWithCoder:”方法时没有调用超类的同名方法，而是调用了自制的初始化方法，或是超类的其他初始化方法，那么EOCRectangle类的“initWithCoder:”方法就没机会执行，也就无法将_width及_height这两个实例变量解码。



@end
