//
//  RMProperty.h
//  Runtime
//
//  Created by rookieme on 2018/12/9.
//  Copyright © 2018 sepeak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RMProperty : NSObject
+ (void)addPropertyWithtarget:(id)target withPropertyName:(NSString *)propertyName withValue:(id)value;
@end

NS_ASSUME_NONNULL_END
