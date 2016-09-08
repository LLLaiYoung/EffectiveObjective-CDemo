//
//  EOCRectangle.h
//  UniversalInitializationDemo
//
//  Created by chairman on 16/9/8.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCRectangle : NSObject
<
NSCoding
>
@property (nonatomic, assign, readonly) float width;
@property (nonatomic, assign, readonly) float height;

- (id)initWithWidth:(float)width andHeight:(float)height;

@end
