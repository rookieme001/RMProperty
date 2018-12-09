//
//  RMProperty.m
//  Runtime
//
//  Created by rookieme on 2018/12/9.
//  Copyright © 2018 sepeak. All rights reserved.
//

#import "RMProperty.h"
#import "NSString+RMProperty.h"
#import <objc/runtime.h>
@implementation RMProperty
static NSMutableDictionary *dictCustomerProperty;

//在目标target上添加属性，属性名propertyname，值value
+ (void)addPropertyWithtarget:(id)target withPropertyName:(NSString *)propertyName withValue:(id)value {
    //先判断有没有这个属性，没有就添加，有就返回
    Ivar ivar = class_getInstanceVariable([target class], [[NSString stringWithFormat:@"_%@", propertyName] UTF8String]);
    if (ivar) {
        return;
    }
    
    objc_property_attribute_t type = { "T", [[NSString stringWithFormat:@"@\"%@\"",NSStringFromClass([value class])] UTF8String] };
    objc_property_attribute_t ownership = { "&", "N" };
    objc_property_attribute_t backingivar  = { "V", [[NSString stringWithFormat:@"_%@", propertyName] UTF8String] };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };
    if (class_addProperty([target class], [propertyName UTF8String], attrs, 3)) {
        
        //添加get和set方法
        class_addMethod([target class], NSSelectorFromString(propertyName), (IMP)customGetter, "@@:");
        class_addMethod([target class], NSSelectorFromString([NSString stringWithFormat:@"set%@:",[propertyName capitalizedString]]), (IMP)customSetter, "v@:@");
        
        //赋值
        [target setValue:value forKey:propertyName];
        NSLog(@"%@", [target valueForKey:propertyName]);
        
        NSLog(@"创建属性Property成功");
    } else {
        class_replaceProperty([target class], [propertyName UTF8String], attrs, 3);
        //添加get和set方法
        class_addMethod([target class], NSSelectorFromString(propertyName), (IMP)customGetter, "@@:");
        class_addMethod([target class], NSSelectorFromString([NSString stringWithFormat:@"set%@:",[propertyName capitalizedString]]), (IMP)customSetter, "v@:@");
        
        //赋值
        [target setValue:value forKey:propertyName];
    }
}

id customGetter(id self1, SEL _cmd1) {
    if (dictCustomerProperty == nil) {
        dictCustomerProperty = [NSMutableDictionary new];
    }
    NSString *key = NSStringFromSelector(_cmd1);
    return [dictCustomerProperty objectForKey:key];
}

void customSetter(id self1, SEL _cmd1, id newValue) {
    //移除set
    NSString *key = [NSStringFromSelector(_cmd1) stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@""];
    //首字母小写
    NSString *head = [key substringWithRange:NSMakeRange(0, 1)];
    head = [head lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:head];
    //移除后缀 ":"
    key = [key stringByReplacingCharactersInRange:NSMakeRange(key.length - 1, 1) withString:@""];
    
    if (dictCustomerProperty == nil) {
        dictCustomerProperty = [NSMutableDictionary new];
    }
    
    [dictCustomerProperty setObject:newValue forKey:key];
}

@end
