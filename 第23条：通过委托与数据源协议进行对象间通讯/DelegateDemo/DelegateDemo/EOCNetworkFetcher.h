//
//  EOCNetworkFetcher.h
//  DelegateDemo
//
//  Created by chairman on 16/9/12.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EOCNetworkFetcherDelegate.h"
@interface EOCNetworkFetcher : NSObject
#warning 声明为 `weak`，因为这两个之间的关系是`非拥有关系`，如果定义成 `strong` 则表示本对象和委托对象为`拥有关系`，就会导致“保留环”（retain cycle）
@property (nonatomic, weak) id<EOCNetworkFetcherDelegate> delegate;
- (void)sendSuccess;
- (void)sendFail;
- (void)sendProgress;
@end
