//
//  EOCLocation.m
//  DescriptionDemo
//
//  Created by chairman on 16/9/8.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "EOCLocation.h"

@implementation EOCLocation

- (id)initWithTitle:(NSString *)title latitude:(float)latitude longitude:(float)longitude {
    if (self = [super init]) {
        _title = [title copy];
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>",[self class],self,@{@"title":_title,
                                                                          @"latitued":@(_latitude),
                                                                          @"longitued":@(_longitude)
                                                                          }];
}

@end
