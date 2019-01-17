//
//  UIViewController+Swizzled.m
//  AppCodeAnalysis
//
//  Created by ldh on 2019/1/17.
//  Copyright © 2019年 ldh. All rights reserved.
//

#import "UIViewController+Swizzled.h"
#import <objc/runtime.h>

@implementation UIViewController (Swizzled)

static BOOL isSwizzed;

static NSString *logTag = @"";

+(void)load
{
    isSwizzed = NO;
}

static void swizzInstance(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
- (void)logWithLevel:(NSUInteger)level
{
    NSString *paddingItems = @"";
    for (NSUInteger i = 0; i<=level; i++)
    {
        paddingItems = [paddingItems stringByAppendingFormat:@"=="];
    }
    if (logTag.length > 0) {
        NSLog(@"%@:%@>> %@", logTag, paddingItems, [self.class description]);
    }else{
        NSLog(@"CurrenView：%@>> %@", paddingItems, [self.class description]);
    }
}
- (void)logWithNavigationController:(UINavigationController *)navi{
    if (!navi) {
        return;
    }
    NSMutableString * logStr = [NSMutableString stringWithString:@""];
    [logStr appendString:[navi.class description]];
    [[navi viewControllers] enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [logStr appendString:@"==>>  "];
        [logStr appendString:[obj.class description]];
    }];
    NSLog(@"\n\nCurrenView：%@\n",logStr);
}

- (void)logWithTabbarController:(UITabBarController *)tabbar{
    if (!tabbar) {
        return;
    }
    NSMutableString * logStr = [NSMutableString stringWithString:@""];
    [logStr appendString:[tabbar.class description]];
    [[tabbar viewControllers] enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [logStr appendString:@"     \n==>>  "];
        [logStr appendString:[obj.class description]];
    }];
    NSLog(@"\n\nCurrenView：%@\n",logStr);
}
#pragma mark - SwizzMethods

- (void)printPath
{
    if ([self parentViewController] == nil){
        [self logWithLevel:0];
    }else if([[self parentViewController] isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = (UINavigationController *)[self parentViewController];
//        NSInteger integer = [[nav viewControllers] indexOfObject:self];
//        [self logWithLevel:integer];
        [self logWithNavigationController:nav];
    }else if ([[self parentViewController] isKindOfClass:[UITabBarController class]]){
        [self logWithLevel:1];
//        UITabBarController * tabbarController =(UITabBarController *)[self parentViewController];
//        [self  logWithTabbarController:tabbarController];
    }else{
        [self logWithLevel:0];
    }
}

-(void)swizzviewDidAppear:(BOOL)animated
{
    [self printPath];
    
    // Call the original method (viewWillAppear)
    [self swizzviewDidAppear:animated];
}

#pragma mark - Public methods

+ (void)swizzIt
{
    if (isSwizzed)
    {
        return;
    }
    
    swizzInstance([self class],@selector(viewDidAppear:),@selector(swizzviewDidAppear:));
    
    isSwizzed = YES;
}

+ (void)swizzItWithTag:(NSString *)tag
{
    logTag = tag;
    [self swizzIt];
}

+ (void)undoSwizz
{
    if (!isSwizzed)
    {
        return;
    }
    
    isSwizzed = NO;
    swizzInstance([self class],@selector(swizzviewDidAppear:),@selector(viewDidAppear:));
}

@end
