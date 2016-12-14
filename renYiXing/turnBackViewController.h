//
//  turnBackViewController.h
//  renYiXing
//
//  Created by JOYSW on 16/7/1.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import <UIKit/UIKit.h>

//给block起别名
typedef void(^changeTextBlock)(NSString *);

@interface turnBackViewController : UIViewController
//block 实际上存储到栈区或者全局区
//我们把block定义成属性的时候 需要使用copy来进行修饰  目的就是把block 拷贝到 堆区
@property (nonatomic ,copy)changeTextBlock block;

@property(nonatomic ,assign)NSString *titleStr;
@property(nonatomic ,assign)NSString *textFieldStr;
@property (nonatomic ,retain)UITextField *textBackField;

@end
