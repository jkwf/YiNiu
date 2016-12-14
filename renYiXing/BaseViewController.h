//
//  BaseViewController.h
//  LiveProject
//
//  Created by Longxun on 16/9/1.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIViewController (LeftBackButton)
-(void)initPopButton;
-(void)initPresentButton;
- (void)dismissAction;
-(void)backAction;
@end
@interface BaseViewController : UIViewController

@end

@interface BaseTableViewController : UITableViewController

@end