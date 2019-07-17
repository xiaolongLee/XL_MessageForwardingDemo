//
//  Test2ViewController.m
//  XL_iOS_MessageForwardingDemo
//
//  Created by Mac-Qke on 2019/7/17.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "Test2ViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "FastForwarding.h"
#import "NormalForwarding.h"
@interface Test2ViewController ()

@end

@implementation Test2ViewController
// 3.1 特定奔溃预防处理
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Test2ViewController";
    
    //实例化一个button,未实现其方法
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 200, 100);
    [button setBackgroundColor: [UIColor blueColor]];
    [button setTitle:@"消息转发" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(doSomething) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark ---- 消息转发机制 第1阶段：动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if ([NSStringFromSelector(sel) isEqualToString:@"doSomething"]) {
        
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
    }
    return [super resolveInstanceMethod:sel];
}

void dynamicMethodIMP(id self, SEL _cmd) {
    
    NSLog(@"动态添加了方法\"%@\" ,防止程序crash", NSStringFromSelector(_cmd));
    
}


#pragma mark ---- 消息转发机制 第1阶段：动态方法解析
// + (BOOL)resolveInstanceMethod:(SEL)sel
// {
//    if ([NSStringFromSelector(sel) isEqualToString:@"doSomething"]) {
//
//        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
//    }
//    return [super resolveInstanceMethod:sel];
// }
//
// void dynamicMethodIMP(id self, SEL _cmd) {
//
//    NSLog(@"动态添加了方法\"%@\" ,防止程序crash", NSStringFromSelector(_cmd));
//
// }


#pragma mark ---- 消息转发机制 第2阶段：快速转发
// - (id)forwardingTargetForSelector:(SEL)aSelector
// {
//     //备援接收者 只需要在.m中实现doSomething就可以防止crash
//     if ([NSStringFromSelector(aSelector) isEqualToString:@"doSomething"]) {
//         return [FastForwarding new];
//     }
//     return [super forwardingTargetForSelector:aSelector];
// }


#pragma mark ---- 消息转发机制 第3阶段：正常转发
// - (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//     if ([NSStringFromSelector(aSelector) isEqualToString:@"doSomething"]) {
//         return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//     }
//     return nil;
// }
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation{
//    NormalForwarding *crashClass = [NormalForwarding new];
//    [crashClass methodCrashHanding:anInvocation];
// }


@end
