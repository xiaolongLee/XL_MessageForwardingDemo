//
//  NSObject+AdapterViewController.m
//  XL_iOS_MessageForwardingDemo
//
//  Created by Mac-Qke on 2019/7/17.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "NSObject+AdapterViewController.h"

@implementation NSObject (AdapterViewController)
//方案2：消息转发
- (UIViewController *)xl_topmostViewController {
    UIViewController   *resultVC ;
    resultVC = [self xl_topmostViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC  = [self xl_topmostViewController:resultVC.presentedViewController];
    }
    return resultVC;
}


- (UIViewController *)xl_topmostViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self xl_topmostViewController:[(UINavigationController *)vc topViewController]];
    }else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self xl_topmostViewController:[(UITabBarController *)vc selectedViewController]];
    }else{
        return vc;
    }
}
@end
