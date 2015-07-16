//
//  MyPageViewController.m
//  HW3
//
//  Created by 鲁辰 on 7/4/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import "MyPageViewController.h"
#import "PageViewControllerData.h"


@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%ld", _startingIndex);
    ALAsset *alAsset = [[PageViewControllerData sharedInstance] assetAtIndex:_startingIndex];
    
    ALAssetRepresentation *representation = [alAsset defaultRepresentation];
    NSURL *url = [representation url];
    AVAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    // Do something interesting with the AV asset.
    
    AVPlayerItem *playerItem = [AVPlayerItem
                                playerItemWithAsset:avAsset];
    
    //Create AVPlayer with AVplayerItem
    AVPlayer *player = [AVPlayer
                        playerWithPlayerItem:playerItem];
    [player play];
    //Associate player with playerViewController
    // playerViewController.player = player;
}

@end
