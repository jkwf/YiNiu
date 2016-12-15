//
//  MyViewController.h
//  renYiXing
//
//  Created by JOYSW on 16/6/30.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController

@property(nonatomic , strong)NSString *userName;

@property(nonatomic,copy)void(^myBlock)(UIImage *headerImage);

@end
