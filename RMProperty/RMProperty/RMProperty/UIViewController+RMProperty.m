//
//  UIViewController+RMProperty.m
//  Runtime
//
//  Created by rookieme on 2018/12/9.
//  Copyright © 2018 sepeak. All rights reserved.
//

#import "UIViewController+RMProperty.h"
#import <objc/runtime.h>
#import "RMProperty.h"

@implementation UIViewController (RMProperty)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [RMProperty addPropertyWithtarget:[self new] withPropertyName:@"vctitle" withValue:[NSString new]];
        [RMProperty addPropertyWithtarget:[self new] withPropertyName:@"array" withValue:[NSArray new]];
    });
}

@end
