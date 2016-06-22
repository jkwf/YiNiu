//
//  DetailViewController.h
//  renYiXing
//
//  Created by JOYSW on 16/6/22.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

