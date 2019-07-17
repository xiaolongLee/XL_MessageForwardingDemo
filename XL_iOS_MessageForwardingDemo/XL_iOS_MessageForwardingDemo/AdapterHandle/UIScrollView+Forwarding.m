//
//  UIScrollView+Forwarding.m
//  XL_iOS_MessageForwardingDemo
//
//  Created by Mac-Qke on 2019/7/17.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "UIScrollView+Forwarding.h"
#import "NSObject+AdapterViewController.h"

@implementation UIScrollView (Forwarding)
//// 为即将转发的消息返回一个对应的方法签名(该签名后面用于对转发消息对象(NSInvocation *)anInvocation进行编码用)
//开始消息转发((NSInvocation *)anInvocation封装了原有消息的调用，包括了方法名，方法参数等)
//由于转发调用的API与原始调用的API不同，这里我们新建一个用于消息调用的NSInvocation对象viewControllerInvocation并配置好对应的target与selector
//配置所需参数:由于每个方法实际是默认自带两个参数的:self和_cmd，所以我们要配置其他参数时是从第三个参数开始配置
//消息转发



- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = nil;
    if (aSelector == @selector(setContentInsetAdjustmentBehavior:)) {
        signature = [UIViewController instanceMethodSignatureForSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)];
    }else{
        signature = [super methodSignatureForSelector:aSelector];
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    BOOL automaticallyAdjustsScrollViewInsets  = NO;
    UIViewController *topmostViewController = [self xl_topmostViewController];
    NSInvocation *viewControllerInvocation = [NSInvocation invocationWithMethodSignature:anInvocation.methodSignature];
    [viewControllerInvocation setTarget: topmostViewController];
    [viewControllerInvocation setSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)];
    [viewControllerInvocation setArgument:&automaticallyAdjustsScrollViewInsets atIndex:2];
    [viewControllerInvocation invokeWithTarget:topmostViewController];
}
@end
