//
//  Test3ViewController.h
//  XL_iOS_MessageForwardingDemo
//
//  Created by Mac-Qke on 2019/7/17.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Test3ViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

// 3.2 苹果系统API迭代造成API不兼容的奔溃处理
// 3.2.1 兼容系统API迭代的传统方案

// 根据能否响应方法进行判断

//if ([object respondsToSelector: @selector(selectorName)]) {
//    //using new API
//} else {
//    //using deprecated API
//}


// 根据当前版本SDK是否存在所需类进行判断
//if (NSClassFromString(@"ClassName")) {
//    //using new API
//}else {
//    //using deprecated API
//}


//根据操作系统版本进行判断

//#define isOperatingSystemAtLeastVersion(majorVersion, minorVersion, patchVersion)[[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion: (NSOperatingSystemVersion) {
//majorVersion,
//minorVersion,
//patchVersion
//}]
//
//if (isOperatingSystemAtLeastVersion(11, 0, 0)) {
//    //using new API
//} else {
//    //using deprecated API
//}
