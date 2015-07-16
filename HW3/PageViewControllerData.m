//
//  PageViewControllerData.m
//  HW3
//
//  Created by 鲁辰 on 7/4/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import "PageViewControllerData.h"


@implementation PageViewControllerData

+ (PageViewControllerData *)sharedInstance {
    
    static dispatch_once_t onceToken;
    static PageViewControllerData *sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[PageViewControllerData alloc] init];
    });
    
    return sSharedInstance;
}

- (NSUInteger)assetsCount {
    return self.assets.count;
}

- (ALAsset *)assetAtIndex:(NSUInteger)index {
    return self.assets[index];
}

@end
