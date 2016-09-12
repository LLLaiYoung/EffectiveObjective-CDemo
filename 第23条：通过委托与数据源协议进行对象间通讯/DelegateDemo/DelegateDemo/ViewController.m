//
//  ViewController.m
//  DelegateDemo
//
//  Created by chairman on 16/9/12.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "ViewController.h"
#import "EOCNetworkFetcher.h"
@interface ViewController ()
<
EOCNetworkFetcherDelegate
>
@property (nonatomic, strong) EOCNetworkFetcher *networkFetcher;
@property (nonatomic, strong) EOCNetworkFetcher *newsNetworkFetcher;

@end

@implementation ViewController

+ (void)load {
    NSLog(@"1");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    EOCNetworkFetcher *networkFetcher = [[EOCNetworkFetcher alloc] init];
    _networkFetcher = networkFetcher;
    _networkFetcher.delegate = self;
    EOCNetworkFetcher *newNetworkFetcher = [[EOCNetworkFetcher alloc] init];
    _newsNetworkFetcher = newNetworkFetcher;
    newNetworkFetcher.delegate = self;
   
}
#pragma mark - EOCNetworkFetcherDelegate

- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didReceiveData:(NSData *)data {
    if ([fetcher isEqual: _newsNetworkFetcher]) {
        NSLog(@"newNetworkFetcher");
    } else if ([fetcher isEqual: _networkFetcher]) {
        NSLog(@"networkFetcher");
    }
   NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"fetch = %@, data = %@",fetcher,str);
}

- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didFailWithError:(NSError *)error {
    NSLog(@"fetcher = %@, error.code = %lu",fetcher,error.code);
}

- (void)networkFetcher:(EOCNetworkFetcher *)fetcher didUpdateProgressTo:(float)progress {
    NSLog(@"fetcher = %@, progress = %f",fetcher,progress);
}
#pragma mark - UIButton Events

- (IBAction)clickNetworkFetcher:(UIButton *)sender {
    [_networkFetcher sendSuccess];
    [_networkFetcher sendProgress];
}

- (IBAction)clickNewNetworkFetcher:(UIButton *)sender {
    [_newsNetworkFetcher sendSuccess];
    [_newsNetworkFetcher sendFail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
