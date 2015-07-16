//
//  PhotoViewController.m
//  HW3
//
//  Created by 鲁辰 on 7/5/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import "PhotoViewController.h"
#import "PageViewControllerData.h"

@implementation PhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ALAsset *asset =[[PageViewControllerData sharedInstance].assets objectAtIndex:_pageIndex];
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    CGImageRef iref = [rep fullResolutionImage];
    if (iref) {
        CGSize size = self.view.bounds.size;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        [imgView setImage:[UIImage imageWithCGImage:iref]];
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        [self.view addSubview:imgView];
        
        [self.tabBarController.tabBar setHidden:YES];
        [self toggle];
    }
    
    //one tap toogle tabbar and navigation bar
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleNavBar:)];
    [self.view addGestureRecognizer:gesture];
}

+ (PhotoViewController *)photoViewControllerForPageIndex:(NSUInteger)pageIndex
{
    if (pageIndex < [[PageViewControllerData sharedInstance] assetsCount])
    {
        return [[self alloc] initWithPageIndex:pageIndex];
    }
    return nil;
}

- (id)initWithPageIndex:(NSInteger)pageIndex
{
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil)
    {
        _pageIndex = pageIndex;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // set the navigation bar's title to indicate which photo index we are viewing,
    // note that our parent is MyPageViewController
    self.parentViewController.navigationItem.title =
    [NSString stringWithFormat:@"%@ of %@", [@(self.pageIndex+1) stringValue], [@([[PageViewControllerData sharedInstance] assetsCount]) stringValue]];
}

- (void)toggleNavBar:(UITapGestureRecognizer *)gesture {
    [self toggle];
}

- (void) toggle {
    BOOL barsHidden = self.navigationController.navigationBar.hidden;
    [self.navigationController setNavigationBarHidden:!barsHidden animated:YES];
}

@end
