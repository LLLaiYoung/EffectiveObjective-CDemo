//
//  EOCDatabaseConnection.h
//  AnonymousObjectDemo
//
//  Created by chairman on 16/9/16.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EOCDatabaseConnection <NSObject>
- (void)connect;
- (void)disConnect;
- (BOOL)disConnected;
- (NSArray *)performQuery:(NSString *)query;

@end
