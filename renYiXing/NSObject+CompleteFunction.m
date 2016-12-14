//
//  NSObject+CompleteFunction.m
//  JoyIM
//
//  Created by Longxun on 16/9/17.
//  Copyright © 2016年 Eben. All rights reserved.
//

#import "NSObject+CompleteFunction.h"

@implementation NSObject (CompleteFunction)
- (void)completeFunction:(id)obj{
    
}
- (void)addNotificationFor:(id)target Name:(NSString *)name{
    [[NSNotificationCenter defaultCenter] addObserver:target selector:@selector(completeFunction:) name:name object:nil];
}
- (void)removeNotification:(id)target{
    [[NSNotificationCenter defaultCenter] removeObserver:target];
}
@end
