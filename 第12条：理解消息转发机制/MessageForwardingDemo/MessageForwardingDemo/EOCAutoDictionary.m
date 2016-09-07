//
//  EOCAutoDictionary.m
//  MessageForwardingDemo
//
//  Created by chairman on 16/9/7.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import "EOCAutoDictionary.h"
#import <objc/runtime.h>

@interface EOCAutoDictionary()
@property (nonatomic, strong) NSMutableDictionary *backingStore;
@end

@implementation EOCAutoDictionary

@dynamic string,number,date,opaqueObject;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}


//* 本例的关键在于resolveInstanceMethod: 方法的实现代码 */

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    //* 将选择子化为字符串 */
    NSString *selectorString = NSStringFromSelector(sel);
    //* 检测其是否表示设置方法，若前缀未set，则表示设置方法，否则就是获取方法  */
    if ([selectorString hasPrefix:@"set"]) {
        //* https://developer.apple.com/reference/objectivec/1418901-class_addmethod?language=objc */
        //* https://developer.apple.com/library/prerelease/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html */
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "V@:@");
    } else {
        class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
    }
    return YES;
}

/** Getter ,_cmd在Objective-C的方法中表示当前方法的selector */
id autoDictionaryGetter(id self, SEL _cmd) {
    EOCAutoDictionary *typeSelf = self;
    NSMutableDictionary *backingStore = typeSelf.backingStore;
    NSString *key = NSStringFromSelector(_cmd);
    return [backingStore objectForKey:key];
}

/** Setter */
void autoDictionarySetter(id self, SEL _cmd, id value) {
    EOCAutoDictionary *typeSelf = self;
    NSMutableDictionary *backingStore = typeSelf.backingStore;
    
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectorString mutableCopy];
    
    //* 删除`:` */
    [key deleteCharactersInRange:NSMakeRange(key.length-1, 1)];
    //* 删除`set`*/
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    //* 获取第一个字符转并换成小写 */
    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
    //* 将第一个字符替换成小写 */
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    if (value) {
        [backingStore setObject:value forKey:key];
    } else {
        [backingStore removeObjectForKey:key];
    }
}

@end
