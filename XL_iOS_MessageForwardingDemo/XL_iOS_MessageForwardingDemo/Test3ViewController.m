//
//  Test3ViewController.m
//  XL_iOS_MessageForwardingDemo
//
//  Created by Mac-Qke on 2019/7/17.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import "Test3ViewController.h"

@interface Test3ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation Test3ViewController
//3.2.2 兼容系统API迭代的新方案
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Test3ViewController";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 375, 600) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor orangeColor];
    
     // Will Crash with iOS 10
    tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    // 方案1：手动加入版本判断逻辑
    
//    if (isOperatingSystemAtLeastVersion(11, 0, 0)) {
//        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        viewController.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:tableView];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


// 4.1 模拟多继承

// 面试挖坑：OC是否支持多继承？好，你说不支持多继承，那你有没有模拟多继承特性的办法？

//转发和继承相似，可用于为OC编程添加一些多继承的效果，一个对象把消息转发出去，就好像他把另一个对象中放法接过来或者“继承”一样。消息转发弥补了objc不支持多继承的性质，也避免了因为多继承导致单个类变得臃肿复杂。
//虽然转发可以实现继承功能，但是NSObject还是必须表面上很严谨，像respondsToSelector:和isKindOfClass:这类方法只会考虑继承体系，不会考虑转发链。

// 4.2 消息机制总结

//Objective-C 中给一个对象发送消息会经过以下几个步骤：
//
//在对象类的 dispatch table 中尝试找到该消息。如果找到了，跳到相应的函数IMP去执行实现代码；
//如果没有找到，Runtime 会发送 +resolveInstanceMethod: 或者 +resolveClassMethod: 尝试去 resolve 这个消息；
//如果 resolve 方法返回 NO，Runtime 就发送 -forwardingTargetForSelector: 允许你把这个消息转发给另一个对象；
//如果没有新的目标对象返回， Runtime 就会发送-methodSignatureForSelector: 和 -forwardInvocation: 消息。你可以发送 -invokeWithTarget: 消息来手动转发消息或者发送 -doesNotRecognizeSelector: 抛出异常。


@end
