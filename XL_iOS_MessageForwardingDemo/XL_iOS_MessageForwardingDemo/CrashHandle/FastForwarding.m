//
//  FastForwarding.m
//  XL_iOS_MessageForwardingDemo
//
//  Created by Mac-Qke on 2019/7/17.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "FastForwarding.h"

@implementation FastForwarding
//不需要在.h中声明，运行时会动态查找类中是否实现该方法
- (void)doSomething{
    NSLog(@"FastForwarding的方法调用了,程序没有crash!!!");
}
@end
