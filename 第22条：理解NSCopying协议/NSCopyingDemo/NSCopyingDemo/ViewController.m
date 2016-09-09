//
//  ViewController.m
//  NSCopyingDemo
//
//  Created by chairman on 16/9/9.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "ViewController.h"
#import "EOCPerson.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *array = [@[@0].mutableCopy copy];
//    BOOL resultKind = [array isKindOfClass:[NSArray class]];
//    NSLog(@"isKindOfNSArray = %@",resultKind?@"YES":@"NO");
//    BOOL resultMember = [array isMemberOfClass:[NSArray class]];
//    NSLog(@"isMemberOfNSArray = %@",resultMember?@"YES":@"NO");

    EOCPerson *person = [[EOCPerson alloc] initWithFirstName:@"Lai" andLastName:@"Young_"];
    NSLog(@"person = %@",person);
    
//    EOCPerson *copyPerson = [person copy];
//    NSLog(@"copyPerson = %@",copyPerson);
//    
//    EOCPerson *mutablePerson = [person mutableCopy];
//    NSLog(@"mutablePerson = %@",mutablePerson);
    
    EOCPerson *deepCopyPerson = [person deepCopy];
    NSLog(@"deepCopyPerson = %@",deepCopyPerson);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
