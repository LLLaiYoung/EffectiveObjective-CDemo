//
//  EOCPerson.m
//  DescriptionDemo
//
//  Created by chairman on 16/9/8.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "EOCPerson.h"

@implementation EOCPerson

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    if (self = [super init]) {
        _firstName = [firstName copy];
        _lastName = [lastName copy];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p,\"%@ %@\">",[self class],self,_firstName,_lastName];
}

/** 此方法是开发者在调试器（debugger）中以控制台命令打印对象时候才调用
 *  在ViewController的第22行打断点
 *  在控制台输入命令  格式：po +对象 例如 po person
 */
- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"debugDescription: <%@: %p,\"%@ %@\">",[self class],self,_firstName,_lastName];
}

@end
