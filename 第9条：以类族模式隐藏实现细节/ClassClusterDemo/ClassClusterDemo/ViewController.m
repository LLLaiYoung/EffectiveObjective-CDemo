//
//  ViewController.m
//  ClassClusterDemo
//
//  Created by chairman on 16/9/7.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "ViewController.h"
#import "EOCEmployee.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EOCEmployee *developer = [EOCEmployee employeeWithType:EOCEmployeeTypeDeveloper];
    [developer doADaysWork];//log Developer writeCode
    
    
    EOCEmployee *designer = [EOCEmployee employeeWithType:EOCEmployeeTypeDesigner];
    [designer doADaysWork];//log designer writeCode
    
    EOCEmployee *finance = [EOCEmployee employeeWithType:EOCEmployeeTypeFinance];
    [finance doADaysWork];//log finance writeCode
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
