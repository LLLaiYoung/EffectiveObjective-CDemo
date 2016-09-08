//
//  ViewController.m
//  DescriptionDemo
//
//  Created by chairman on 16/9/8.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "ViewController.h"
#import "EOCPerson.h"
#import "EOCLocation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EOCPerson *person = [[EOCPerson alloc] initWithFirstName:@"Bob" lastName:@"Smith"];
    NSLog(@"person = %@",person);//log  person = <EOCPerson: 0x7fcae8f5f6d0,"Bob Smith">
#warning Breakpoint here.  在调试器中使用命令：po person
//po person log:    debugDescription: <EOCPerson: 0x7faae151e520,"Bob Smith">
    
    EOCLocation *location = [[EOCLocation alloc] initWithTitle:@"中冶赛迪研发中心" latitude:100.23 longitude:89.44];
    NSLog(@"location = %@",location);
//    log:
//    location = <EOCLocation: 0x7f806b496180, {
//        latitued = "100.23";
//        longitued = "89.44";
//        title = "\U4e2d\U51b6\U8d5b\U8fea\U7814\U53d1\U4e2d\U5fc3";
//    }>

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
