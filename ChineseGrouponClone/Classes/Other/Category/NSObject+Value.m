//
//  GPMainViewController.m
//  ChineseGrouponClone
//
//  Created by wilson on 12/4/14.
//  Copyright (c) 2014 robin.sun. All rights reserved.
//

#import "NSObject+Value.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation NSObject (Value)
- (void)setValues:(NSDictionary *)values
{
    Class c = [self class];
    
    while (c) {
        // 1. get all instance variables
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        
        for (int i = 0; i<outCount; i++) {
            Ivar ivar = ivars[i];
            
            // 2.property name
            NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
            
            // remove the foremost "_"
            [name replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
            
            // 3. get property value
            NSString *key = name;
            if ([key isEqualToString:@"desc"]) {
                key = @"description";
            }
            if ([key isEqualToString:@"ID"]) {
                key = @"id";
            }
            id value = values[key];
            if (!value) continue;
            
            // 4.SEL
            // capital
            NSString *cap = [name substringToIndex:1];
            // to upper case string
            cap = cap.uppercaseString;
            // replace the initial letter with the upper case one
            [name replaceCharactersInRange:NSMakeRange(0, 1) withString:cap];
            // concatnate set
            [name insertString:@"set" atIndex:0];
            // concatnate colon
            [name appendString:@":"];
            SEL selector = NSSelectorFromString(name);
            
            // 5. property type
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            
            if ([type hasPrefix:@"@"]) { // object type
                objc_msgSend(self, selector, value);
            } else  { // non-object type
                if ([type isEqualToString:@"d"]) {
                    objc_msgSend(self, selector, [value doubleValue]);
                } else if ([type isEqualToString:@"f"]) {
                    objc_msgSend(self, selector, [value floatValue]);
                } else if ([type isEqualToString:@"i"]) { 
                    objc_msgSend(self, selector, [value intValue]);
                }  else { 
                    objc_msgSend(self, selector, [value longLongValue]);
                }
            }
        }
        
        c = class_getSuperclass(c);
    }
}
@end
