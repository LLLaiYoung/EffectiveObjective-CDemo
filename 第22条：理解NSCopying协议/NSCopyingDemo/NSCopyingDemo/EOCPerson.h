//
//  EOCPerson.h
//  UsingImmutableObjectsDemo
//
//  Created by chairman on 16/9/8.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCPerson : NSObject
<
NSCopying,
NSMutableCopying
>
@property (nonatomic, copy, readonly) NSString *firstName;
@property (nonatomic, copy, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSSet *friends;

- (id)initWithFirstName:(NSString *)firstName
            andLastName:(NSString *)lastName;
- (void)addFriend:(EOCPerson *)person;
- (void)removeFriend:(EOCPerson *)person;

- (id)deepCopy;

@end
