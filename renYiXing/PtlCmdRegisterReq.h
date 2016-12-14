//
//  PtlCmdRegisterReq.h
//  SocketDemo
//
//  Created by JOYSW on 16/8/5.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "Ptl.h"
#import "IPtlCoder.h"

@interface PtlCmdRegisterReq : Ptl<IPtlCoder>

@property(copy,nonatomic)NSString* UserName;
@property(copy,nonatomic)NSString* Mobile;
@property(copy,nonatomic)NSString* Telephone;
@property(copy,nonatomic)NSString* Password;
//@property(copy,nonatomic)NSString* Domain;
//@property(copy,nonatomic)NSString *loginType;

@end
