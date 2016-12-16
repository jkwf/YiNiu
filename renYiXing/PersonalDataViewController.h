//
//  PersonalDataViewController.h
//  easyTrader
//
//  Created by JOYSW on 16/7/7.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalDataViewController : UIViewController

@property(nonatomic , strong)UIImageView *topView;

@property(nonatomic , strong)UILabel *nameLabel;

@property(nonatomic , strong)NSString *UserName;

@property(nonatomic,copy)void(^personalDataBlock) (UIImage *headerImage);

@end
