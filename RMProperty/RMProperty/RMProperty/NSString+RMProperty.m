//
//  NSString+RMProperty.m
//  Runtime
//
//  Created by rookieme on 2018/12/9.
//  Copyright © 2018 sepeak. All rights reserved.
//

#import "NSString+RMProperty.h"
#import "RMProperty.h"
#import <objc/runtime.h>
@implementation NSString (RMProperty)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [RMProperty addPropertyWithtarget:[self new] withPropertyName:@"test" withValue:[NSString new]];
        [RMProperty addPropertyWithtarget:[self new] withPropertyName:@"dict" withValue:[NSDictionary new]];
    });
}

@end
