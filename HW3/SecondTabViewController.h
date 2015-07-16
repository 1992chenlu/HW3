//
//  SecondTabViewController.h
//  HW3
//
//  Created by 鲁辰 on 7/4/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

@interface SecondTabViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSURL *chosenMovie;
@property (strong, nonatomic) UIImage *image;

@property (nonatomic) Boolean isPhoto;
@property (nonatomic) Boolean isNotFirstTimeLoad;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:(id)sender;
- (IBAction)takeVideo:(id)sender;
- (IBAction)saveAction:(id)sender;

//- (IBAction)takePhoto:  (UIButton *)sender;

@end
