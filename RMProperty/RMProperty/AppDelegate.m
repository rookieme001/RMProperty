//
//  AppDelegate.m
//  RMProperty
//
//  Created by rookieme on 2018/12/9.
//  Copyright © 2018 rookieme. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/runtime.h>

#import "RMProperty/UIViewController+RMProperty.h"
#import "RMProperty/NSString+RMProperty.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *string = [NSString new];
    string.test = @"123";
    string.dict = @{@"key":@"123"};
    NSLog(@"string：%@--%@",string.dict,string.test);
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.vctitle = @"vc-test";
    vc.array   = @[@"1",@"2",@"3"];
    NSLog(@"vc:%@--%@--%@",vc.vctitle,vc.array,vc.array[0]);
    NSLog(@"======================================================================================");
    
    @autoreleasepool {
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList([NSString class], &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            fprintf(stdout, "Attributes %s %s\n", property_getName(property), property_getAttributes(property));
        }
        free(properties);
    }
    
    @autoreleasepool {
        unsigned int count;
        objc_property_t *properties=class_copyPropertyList([NSString class], &count);
        for(int i =0; i < count; i++) {
            
            objc_property_t property = properties[i];
            //获取属性的名称C语言字符串
            const char *cName =property_getName(property);
            //转换为Objective C字符串
            NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
            NSLog(@"property:%@",name);
        }
        free(properties);
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
