//
//  Error.h
//  JoyIM
//
//  Created by Eben on 3/3/13.
//  Copyright (c) 2013 Eben. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Error : NSObject

@property(assign,nonatomic)BOOL Result;
@property(copy,nonatomic)NSString* ErrCode;
@property(copy,nonatomic)NSString* ErrDesc;


-(id)initWithResult:(BOOL)rslt ErrorCode:(NSString*)code ErrorDesc:(NSString*)desc;

@end
