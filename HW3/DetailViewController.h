//
//  DetailViewController.h
//  HW3
//
//  Created by 鲁辰 on 7/5/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface DetailViewController : UIViewController

@property NSInteger pageIndex;
@property (nonatomic, strong) AVPlayer *player;
@property (strong, nonatomic) MPMoviePlayerController *videoController;

+ (DetailViewController *)detailViewControllerForPageIndex:(NSUInteger)pageIndex;

@end
