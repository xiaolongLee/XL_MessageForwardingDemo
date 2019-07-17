//
//  NormalForwarding.m
//  XL_iOS_MessageForwardingDemo
//
//  Created by Mac-Qke on 2019/7/17.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "NormalForwarding.h"

@implementation NormalForwarding
- (void)methodCrashHanding:(NSInvocation *)invocation{
    NSLog(@"NormalForwarding---在类:%@中未实现该方法:%@",NSStringFromClass([invocation.target class]),NSStringFromSelector(invocation.selector));
}
@end
