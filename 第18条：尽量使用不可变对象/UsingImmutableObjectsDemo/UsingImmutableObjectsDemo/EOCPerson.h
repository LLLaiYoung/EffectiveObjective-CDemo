//
//  EOCPerson.h
//  UsingImmutableObjectsDemo
//
//  Created by chairman on 16/9/8.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCPerson : NSObject
@property (nonatomic, copy, readonly) NSString *firstName;
@property (nonatomic, copy, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSSet *friends;

- (id)initWithFirstName:(NSString *)firstName
            andLastName:(NSString *)lastName;
- (void)addFriend:(EOCPerson *)person;
- (void)removeFriend:(EOCPerson *)person;


#warning 也可以用NSMutableSet来实现friends属性，令该类的用户不借助“addFriend:”与“removeFriend:”方法而直接操作此属性。


@end
