//
//  NSObject+CompleteFunction.h
//  JoyIM
//
//  Created by Longxun on 16/9/17.
//  Copyright © 2016年 Eben. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CompleteFunction)
- (void)completeFunction:(id)obj;
- (void)addNotificationFor:(id)target Name:(NSString *)name;
- (void)removeNotification:(id)target;
@end
