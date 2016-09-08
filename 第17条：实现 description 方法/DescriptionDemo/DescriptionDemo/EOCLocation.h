//
//  EOCLocation.h
//  DescriptionDemo
//
//  Created by chairman on 16/9/8.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCLocation : NSObject
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, assign, readonly) float latitude;
@property (nonatomic, assign, readonly) float longitude;

- (id)initWithTitle:(NSString *)title latitude:(float)latitude longitude:(float)longitude;

@end
