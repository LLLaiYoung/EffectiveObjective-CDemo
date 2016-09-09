//
//  EOCPerson.m
//  UsingImmutableObjectsDemo
//
//  Created by chairman on 16/9/8.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "EOCPerson.h"


@implementation EOCPerson {
    NSMutableSet *_friends;
}

- (NSSet *)friends {
    return [_friends copy];
}

- (void)addFriend:(EOCPerson *)person {
    [_friends addObject:person];
}

- (void)removeFriend:(EOCPerson *)person {
    [_friends removeObject:person];
}
- (id)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName {
    if (self = [super init]) {
        _firstName = firstName;
        _lastName = lastName;
        _friends = [NSMutableSet new];
    }
    return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    EOCPerson *copy = [[[self class] allocWithZone:zone] initWithFirstName:_firstName andLastName:_lastName];
    copy->_friends = [_friends copy];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    EOCPerson *mutableCopy = [[[self class] allocWithZone:zone] initWithFirstName:_firstName andLastName:_lastName];
    mutableCopy->_friends = [_friends mutableCopy];
    return mutableCopy;
}

#warning _friends 如果是不可变的，则无须复制，因为其中的内容毕竟不会改变，如果复制了，那么内存中将会有两个一摸一样的set，反而造成浪费

#warning 如果你的类分为可变与不可变版本，那么就还应该实现NSMutableCopying。若采用此模式，则在可变类中覆写“copyWithZone:”方法时，不要返回可变的拷贝，而应返回一份不可变的版本，无论当前实例是否可变，若需获取其可变版本的拷贝，均应调用mutableCopy方法。同理，若需要不可变的拷贝，则总应通过copy方法来获取。对于不可变的NSArray与可变的NSMutableArray来说，下列关系总是成立的：
//    -[NSMutableArray copy] => NSArray
//    -[NSArray mutableCopy] => NSMutableArray

- (id)deepCopy {
    EOCPerson *copy = [[[self class] alloc] initWithFirstName:_firstName andLastName:_lastName];
    //* 若copyItem的参数为yes，则该方法会向数组中的每个元素发送copy信息，用拷贝好的元素创建新的set，并将其返回给调用者 */
    copy->_friends = [[NSMutableSet alloc] initWithSet:_friends copyItems:YES];
    return copy;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p,\"%@ %@\">",[self class],self,_firstName,_lastName];
}

@end
