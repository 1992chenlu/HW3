//
//  PageViewControllerData.h
//  HW3
//
//  Created by 鲁辰 on 7/4/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PageViewControllerData : NSObject

+ (PageViewControllerData *)sharedInstance;

@property (nonatomic, strong) NSArray *assets; //array of ALAsset object

- (NSUInteger)assetsCount;
- (ALAsset *)assetAtIndex:(NSUInteger)index;

@end
