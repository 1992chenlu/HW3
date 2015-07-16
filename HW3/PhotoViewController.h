//
//  PhotoViewController.h
//  HW3
//
//  Created by 鲁辰 on 7/5/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property NSUInteger pageIndex;

+ (PhotoViewController *)photoViewControllerForPageIndex:(NSUInteger)pageIndex;

@end
