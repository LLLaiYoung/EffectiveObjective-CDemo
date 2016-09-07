//
//  EOCEmployee.m
//  ClassClusterDemo
//
//  Created by chairman on 16/9/7.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "EOCEmployee.h"
#import "EOCEmployeeDeveloper.h"
#import "EOCEmployeeDesigner.h"
#import "EOCEmployeeFinance.h"


@implementation EOCEmployee

+ (EOCEmployee *)employeeWithType:(EOCEmployeeType)type {
    switch (type) {
        case EOCEmployeeTypeDeveloper:
            return [EOCEmployeeDeveloper new];
            break;
            
        case EOCEmployeeTypeDesigner:
            return [EOCEmployeeDesigner new];
            break;
        case EOCEmployeeTypeFinance:
            return [EOCEmployeeFinance new];
            break;
    }
}

- (void)doADaysWork {
    NSLog(@"do a days work");
}

@end
