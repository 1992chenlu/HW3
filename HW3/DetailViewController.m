//
//  DetailViewController.m
//  HW3
//
//  Created by 鲁辰 on 7/5/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import "DetailViewController.h"
#import "PageViewControllerData.h"

@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    ALAsset *alAsset = [[PageViewControllerData sharedInstance] assetAtIndex:_pageIndex];
    
    ALAssetRepresentation *representation = [alAsset defaultRepresentation];
    NSURL *url = [representation url];

    self.videoController = [[MPMoviePlayerController alloc] init];
    
    [self.videoController setContentURL:url];
    
    CGSize size = self.view.bounds.size;
    [self.videoController.view setFrame:CGRectMake (0, 0, size.width, size.height)];
    [self.view addSubview:self.videoController.view];
    self.videoController.controlStyle = MPMovieControlStyleFullscreen;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(videoPlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.videoController];
    
    [self.videoController play];
    
    //hide bars
    [self.tabBarController.tabBar setHidden:YES];
    [self hideBars];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.videoController pause];
}

+ (DetailViewController *)detailViewControllerForPageIndex:(NSUInteger)pageIndex
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

- (void)videoPlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self showBars];
}

- (void) showBars {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void) hideBars {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.videoController.playbackState == MPMoviePlaybackStatePlaying)
    {
        // is Playing
        [self hideBars];
    } else {
        [self showBars];
    }
}

@end
