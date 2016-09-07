//
//  EOCEmployee.h
//  ClassClusterDemo
//
//  Created by chairman on 16/9/7.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EOCEmployeeType) {
    EOCEmployeeTypeDeveloper,
    EOCEmployeeTypeDesigner,
    EOCEmployeeTypeFinance,
};

@interface EOCEmployee : NSObject

@property (copy) NSString *name;
@property NSUInteger salary;

+ (EOCEmployee *)employeeWithType:(EOCEmployeeType)type;

- (void)doADaysWork;


@end
