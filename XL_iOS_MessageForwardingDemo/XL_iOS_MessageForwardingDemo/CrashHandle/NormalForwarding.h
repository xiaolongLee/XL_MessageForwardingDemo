//
//  NormalForwarding.h
//  XL_iOS_MessageForwardingDemo
//
//  Created by Mac-Qke on 2019/7/17.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NormalForwarding : NSObject
- (void)methodCrashHanding:(NSInvocation *)invocation;
@end

NS_ASSUME_NONNULL_END
