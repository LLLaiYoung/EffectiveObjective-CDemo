//
//  ViewController.m
//  Methodswizzling
//
//  Created by chairman on 16/9/7.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Methodswizzling.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *string = @"LaiYoung";
//    NSLog(@"lowercaseString = %@",[string lowercaseString]);
//    //lowercaseString = LAIYOUNG
//    
//    NSLog(@"uppercaseString = %@",[string uppercaseString]);
    //uppercaseString = laiyoung
    
    
    NSLog(@"eoc_myLowercase = %@",[string lowercaseString]);
    //LaiYoung=> LAIYOUNG
    //eoc_myLowercase = LAIYOUNG
    //* 因为在之前lowercaseString和uppercaseString已经互换了，所以此时调用lowercaseString即调用uppercaseString */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
