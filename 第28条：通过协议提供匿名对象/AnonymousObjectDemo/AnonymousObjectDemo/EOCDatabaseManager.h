//
//  EOCDatabaseManager.h
//  AnonymousObjectDemo
//
//  Created by chairman on 16/9/16.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EOCDatabaseConnection;

@interface EOCDatabaseManager : NSObject
+ (id)sharedInstance;
- (id<EOCDatabaseConnection>)connectionWithIdentifier:(NSString *)identifier;
@end
