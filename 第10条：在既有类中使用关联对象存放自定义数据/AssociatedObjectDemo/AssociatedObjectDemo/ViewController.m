//
//  ViewController.m
//  AssociatedObjectDemo
//
//  Created by chairman on 16/9/7.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

static void *touchbeganAlertViewKey = @"touchbeganAlertViewKey";
static void *btnAlertViewKey = @"btnAlertViewKey";

@interface ViewController ()
<
UIAlertViewDelegate
>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"touchBegan" message:@"Message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"continue", nil];
    
    /** 处理Alert被点击之后的操作 */
    void (^touchBeganAlertViewBlock)(NSInteger) = ^(NSInteger buttonIndex) {
        if (buttonIndex==0) {
            NSLog(@"touchBeganAlertViewBlock Index ==0");
        } else {
            NSLog(@"touchBeganAlertViewBlock Index!=0");
        }
    };
    /** 关联对象 */
    objc_setAssociatedObject(alerView, touchbeganAlertViewKey, touchBeganAlertViewBlock, OBJC_ASSOCIATION_COPY);
    
    [alerView show];
}

- (IBAction)showAlertViewBtn:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"showInBtn" message:@"message" delegate:self cancelButtonTitle:@"cancelBtn" otherButtonTitles:@"OtherBtn", nil];
    /** 处理Alert被点击之后的操作 */
    void (^block)(NSInteger) = ^(NSInteger buttonIndex) {
        if (buttonIndex==0) {
            NSLog(@"btnIndex==0");
        } else {
            NSLog(@"btnIndex!=0");
        }
    };
    /** 关联对象 */
    objc_setAssociatedObject(alertView, btnAlertViewKey, block, OBJC_ASSOCIATION_COPY);
    [alertView show];
}

/** UIAlertView的代理函数 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    /** 获取关联对象值 */
    void (^touchBeganBlock)(NSUInteger buttonIndex) = objc_getAssociatedObject(alertView, touchbeganAlertViewKey);
    if (touchBeganBlock) {
        touchBeganBlock(buttonIndex);
        return;
    }
    
    /** 获取关联对象值 */
    void (^btnBlock)(NSUInteger buttonIndex) = objc_getAssociatedObject(alertView, btnAlertViewKey);
    if (btnBlock) {
        btnBlock(buttonIndex);
        return;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
