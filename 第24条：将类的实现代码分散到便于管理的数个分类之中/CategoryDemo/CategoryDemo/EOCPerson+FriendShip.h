//
//  EOCPerson+FriendShip.h
//  CategoryDemo
//
//  Created by chairman on 16/9/12.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "EOCPerson.h"

@interface EOCPerson (FriendShip)

- (void)addFriend:(EOCPerson *)person;
- (void)removeFriend:(EOCPerson *)person;
- (BOOL)isFriendsWith:(EOCPerson *)person;

@end
