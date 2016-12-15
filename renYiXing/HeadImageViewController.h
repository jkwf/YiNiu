//
//  HeadImageViewController.h
//  easyTrader
//
//  Created by JOYSW on 16/7/8.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadImageViewController : UIViewController

@property(nonatomic , strong)UIImageView *headImageView;

@property(nonatomic,strong)NSString *imageURL;

@property(nonatomic,copy)void(^headerImageBlock)(UIImage *headerImage);

@end
