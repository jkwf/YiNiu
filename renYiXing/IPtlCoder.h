//
//  IPtlCoder.h
//  JoyIM
//
//  Created by Eben on 2/21/13.
//  Copyright (c) 2013 Eben. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ptl;

@protocol IPtlCoder <NSObject>

-(Ptl*)Decoder:(NSString*)sXml;

-(NSString*)Encoder:(Ptl*)ptl;

@end
