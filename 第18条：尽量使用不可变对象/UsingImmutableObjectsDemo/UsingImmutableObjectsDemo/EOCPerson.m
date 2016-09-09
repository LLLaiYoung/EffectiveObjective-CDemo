//
//  EOCPerson.m
//  UsingImmutableObjectsDemo
//
//  Created by chairman on 16/9/8.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "EOCPerson.h"

@interface EOCPerson()
#warning 这是"class-continuation分类"
@property (nonatomic, copy, readwrite) NSString *firstName;
@property (nonatomic, copy, readwrite) NSString *lastName;
@end


#warning 实例变量定义在实现快里，从语法上说，这与直接添加到“class-continuation分类”等效。

@implementation EOCPerson {
    NSMutableSet *_internalFriends;
}

- (NSSet *)friends {
    return [_internalFriends copy];
}

- (void)addFriend:(EOCPerson *)person {
    [_internalFriends addObject:person];
}

- (void)removeFriend:(EOCPerson *)person {
    [_internalFriends removeObject:person];
}
- (id)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName {
    if (self = [super init]) {
        _firstName = firstName;
        _lastName = lastName;
        _internalFriends = [NSMutableSet new];
    }
    return self;
}


@end
