//
//  PtlCmdLogin.h
//  JoyIM
//
//  Created by Eben on 2/21/13.
//  Copyright (c) 2013 Eben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ptl.h"
#import "IPtlCoder.h"

@interface PtlCmdLoginReq : Ptl<IPtlCoder>


@property(copy,nonatomic)NSString* UserName;
@property(copy,nonatomic)NSString* Password;
@property(copy,nonatomic)NSString* Domain;
@property(copy,nonatomic)NSString *loginType;

@end
