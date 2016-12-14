//
//  Error.m
//  JoyIM
//
//  Created by Eben on 3/3/13.
//  Copyright (c) 2013 Eben. All rights reserved.
//

#import "Error.h"

@implementation Error

@synthesize Result;
@synthesize ErrCode;
@synthesize ErrDesc;

-(id)initWithResult:(BOOL)rslt ErrorCode:(NSString*)code ErrorDesc:(NSString*)desc
{
    self = [super init];
    
    self.Result = rslt;
    self.ErrCode = code;
    self.ErrDesc = desc;
    
    return self;
}

@end
