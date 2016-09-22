//
//  main.m
//  ZombieObject
//
//  Created by chairman on 16/9/21.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/runtime.h>
#import "EOCClass.h"
void PrintClassInfo (id obj) {
    Class cls = object_getClass(obj);
    Class superClass = class_getSuperclass(cls);
    
    NSLog(@"=== %s : %s ===",class_getName(cls),class_getName(superClass));
}

#warning 为MRC环境

int main(int argc, char * argv[]) {
    @autoreleasepool {
        EOCClass *obj = [[EOCClass alloc] init];
        NSLog(@"Before release");
        PrintClassInfo(obj);
        
        [obj release];
        
        NSLog(@"After release");
        PrintClassInfo(obj);
        
        NSString *description = [obj description];
        
//        log
        
//        Before release
//        === EOCClass : NSObject ===
//        After release
//        === _NSZombie_EOCClass : nil ===

        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
