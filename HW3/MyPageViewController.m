//
//  MyPageViewController.m
//  HW3
//
//  Created by 鲁辰 on 7/5/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import "MyPageViewController.h"
#import "DetailViewController.h"
#import "PageViewControllerData.h"
#import "PhotoViewController.h"

@implementation MyPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ALAsset *asset = [[PageViewControllerData sharedInstance].assets  objectAtIndex:_startingIndex];
    
    if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
        // user tapped a video, show the video
        
        DetailViewController *startingPage = [DetailViewController detailViewControllerForPageIndex:self.startingIndex];
        
        if (startingPage != nil) {
            self.dataSource = self;
            
            [self setViewControllers:@[startingPage]
                           direction:UIPageViewControllerNavigationDirectionForward
                            animated:NO
                          completion:NULL];
        }
        NSLog(@"%d",_startingIndex);
        
        
    } else if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
        // user tapped a photo, show the photo
        
        PhotoViewController *startingPage = [PhotoViewController photoViewControllerForPageIndex:self.startingIndex];
        
        if (startingPage != nil) {
            self.dataSource = self;
            
            [self setViewControllers:@[startingPage]
                           direction:UIPageViewControllerNavigationDirectionForward
                            animated:NO
                          completion:NULL];
        }
        NSLog(@"%d",_startingIndex);
    }
}


#pragma mark - UIPageViewControllerDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(UIViewController *)vc
{
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(UIViewController *)vc
{
    return nil;
}

@end
