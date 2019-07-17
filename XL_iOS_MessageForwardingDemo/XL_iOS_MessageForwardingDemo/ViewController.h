//
//  ViewController.h
//  XL_iOS_MessageForwardingDemo
//
//  Created by Mac-Qke on 2019/7/16.
//  Copyright © 2019 Mac-Qke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

//1.OC的方法与消息
//方法：与一个类相关的一段实际代码，并给出一个特定的名字。例：- (int)meaning { return 42; }


//消息：发送给对象的名称和一组参数。示例：向0x12345678对象发送meaning并且没有参数。

//选择器：表示消息或方法名称的一种特殊方式，表示为类型SEL。选择器本质上就是不透明的字符串，它们被管理，因此可以使用简单的指针相等来比较它们，从而提高速度。（实现可能会有所不同，但这基本上是他们在外部看起来的样子。）例如：@selector(meaning)。

//消息发送：接收信息并查找和执行适当方法的过程。

//1.1 方法与消息发送
// 消息在OC中方法调用是一个消息发送的过程。OC方法最终被生成为C函数，并带有一些额外的参数。这个C函数objc_msgSend就负责消息发送。在runtime的objc/message.h中能找到它的API。

// objc_msgSend(id _Nullable self, SEL _Nonnull op, ...)`

// 1.2 消息发送的主要步骤
// 1.首先检查这个selector是不是要忽略。比如Mac OS X开发，有了垃圾回收就不会理会retain，release这些函数。
//2.检测这个selector的target是不是nil，OC允许我们对一个nil对象执行任何方法不会Crash，因为运行时会被忽略掉。
//3.如果上面两步都通过了，就开始查找这个类的实现IMP，先从cache里查找，如果找到了就运行对应的函数去执行相应的代码。
//4.如果cache中没有找到就找类的方法列表中是否有对应的方法。
//5.如果类的方法列表中找不到就到父类的方法列表中查找，一直找到NSObject类为止。
//6.如果还是没找到就要开始进入动态方法解析和消息转发，后面会说。

//为什么它被称为 “转发”？ 当某个对象没有任何响应某个 消息 的操作就 “转发” 该 消息。原因是这种技术主要是为了让对象让其他对象为他们处理 消息，从而 “转发”。

//消息转发是一种功能强大的技术，可以大大增加Objective-C的表现力。什么是消息转发？简而言之，它允许未知的消息被困住并作出反应。换句话说，无论何时发送未知消息，它​​都会以一个很好的包发送到您的代码中，此时您可以随心所欲地执行任何操作。


//1.3 OC的方法本质
// OC中的方法默认被隐藏了两个参数：self和_cmd。你可能知道self是作为一个隐式参数传递的，它最终成为一个明确的参数。鲜为人知的隐式参数_cmd（它保存了正在发送的消息的选择器）是第二个这样的隐式参数。总之，self指向对象本身，_cmd指向方法本身。举两个例子来说明：

//例1：- (NSString *)name
//这个方法实际上有两个参数：self和_cmd。
//
//例2：- (void)setValue:(int)val
//这个方法实际上有三个参数：self,_cmd 和 val。

// 在编译时你写的 OC 函数调用的语法都会被翻译成一个 C 的函数调用 objc_msgSend() 。
//下面两行代码就是等价的：
// [array insertObject:foo atIndex:5];
// objc_msgSend(array, @selector(insertObject:atIndex:), foo, 5);

// 2. 动态特性：方法解析和消息转发

//没有方法的实现，程序会在运行时挂掉并抛出 unrecognized selector sent to … 的异常。但在异常抛出前，Objective-C 的运行时会给你三次拯救程序的机会：

//Method resolution
//Fast forwarding
//Normal forwarding

//2.1 动态方法解析: Method Resolution

//void fooMethod(id obj, SEL _cmd){
//    NSLog(@"Doning foo");
//}
//
//
//+ (BOOL)resolveInstanceMethod:(SEL)aSel {
//    if (aSel == @selector(foo:)) {
//        // v代表函数返回类型void，第二个字符@代表self的类型id，第三个字符:代表_cmd的类型SEL。
//        class_addMethod([self class], aSel, (IMP)fooMethod, "v@:");
//        return YES;
//    }
//
//    return [super resolveInstanceMethod:aSel];
//}


//2.2 快速转发: Fast Rorwarding
// Fast Rorwarding这是一种快速消息转发：只需要在指定API方法里面返回一个新对象即可，当然其它的逻辑判断还是要的（比如该SEL是否某个指定SEL？）。

// 消息转发机制执行前，runtime系统允许我们替换消息的接收者为其他对象。通过- (id)forwardingTargetForSelector:(SEL)aSelector方法。如果此方法返回的是nil 或者self,则会进入消息转发机制（- (void)forwardInvocation:(NSInvocation *)invocation），否则将会向返回的对象重新发送消息。

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(foo:)) {
//        return [[BackupClass alloc] init];
//    }
//
//    return [super forwardingTargetForSelector:aSelector];
//}

// 2.3 完整消息转发: Normal Forwarding

// 与上面不同，可以理解成完整消息转发，是可以代替快速转发做更多的事。
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
////    SEL sel = anInvocation.selector;
////    if ([alternateObject respondsToSelector:sel]) {
////        [anInvocation invokeWithTarget:alternateObject];
////    }else{
////        [self doesNotRecognizeSelector:sel];
////    }
//}

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
//    if (!methodSignature) {
//        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
//    }
//
//    return methodSignature;
//}

// forwardInvocation: 方法就是一个不能识别消息的分发中心，将这些不能识别的消息转发给不同的消息对象，或者转发给同一个对象，再或者将消息翻译成另外的消息，亦或者简单的“吃掉”某些消息，因此没有响应也不会报错。例如：我们可以为了避免直接闪退，可以当消息没法处理时在这个方法中给用户一个提示，也不失为一种友好的用户体验。
//其中，参数invocation是从哪来的？在forwardInvocation:消息发送前，runtime系统会向对象发送methodSignatureForSelector:消息，并取到返回的方法签名用于生成NSInvocation对象。所以重写forwardInvocation:的同时也要重写methodSignatureForSelector:方法，否则会抛出异常。当一个对象由于没有相应的方法实现而无法响应某个消息时，运行时系统将通过forwardInvocation:消息通知该对象。每个对象都继承了forwardInvocation:方法，我们可以将消息转发给其它的对象。



//2.4 区别: Fast Rorwarding 对比 Normal Forwarding？
// 需要重载的API方法的用法不同

//前者只需要重载一个API即可，后者需要重载两个API。
//前者只需在API方法里面返回一个新对象即可，后者需要对被转发的消息进行重签并手动转发给新对象（利用 invokeWithTarget:）。


//转发给新对象的个数不同

//前者只能转发一个对象，后者可以连续转发给多个对象


// 完整转发：
//-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//{
//    if (aSelector==@selector(run)) {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }
//    return [super methodSignatureForSelector: aSelector];
//}

//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    SEL selector = [anInvocation selector];
//    
//    Person *p1 = [Person new];
//    Person *p2 = [Person new];
//    
//    if ([p1 respondsToSelector:selector]) {
//        [anInvocation invokeWithTarget:p1];
//    }
//    
//    if ([p2 respondsToSelector:selector]) {
//        [anInvocation invokeWithTarget:p2];
//    }
//    
//    
//}
