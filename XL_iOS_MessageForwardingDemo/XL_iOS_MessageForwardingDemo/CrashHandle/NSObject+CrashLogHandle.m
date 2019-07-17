//
//  NSObject+CrashLogHandle.m
//  XL_iOS_MessageForwardingDemo
//
//  Created by Mac-Qke on 2019/7/17.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "NSObject+CrashLogHandle.h"

@implementation NSObject (CrashLogHandle)
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    //方法签名
    return [NSMethodSignature methodSignatureForSelector:"v@:@"];
    
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"NSObject+CrashLogHandle--在类:%@中 未实现该方法:%@",NSStringFromClass([anInvocation.target class]),NSStringFromSelector(anInvocation.selector));
}



@end
