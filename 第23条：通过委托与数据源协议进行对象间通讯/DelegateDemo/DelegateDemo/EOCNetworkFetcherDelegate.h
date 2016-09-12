//
//  LYProtocol.h
//  DelegateDemo
//
//  Created by chairman on 16/9/12.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EOCNetworkFetcher;

#warning 在@protocol里面，默认是@require，就是必须实现的协议，而@optional是可选实现的，如果不写@require和@optional，那就是@require
@protocol EOCNetworkFetcherDelegate <NSObject>

@required

@optional
- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didReceiveData:(NSData *)data;
- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didFailWithError:(NSError *)error;
- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didUpdateProgressTo:(float)progress;

@end
