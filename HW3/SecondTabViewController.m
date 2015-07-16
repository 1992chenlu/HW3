//
//  SecondTabViewController.m
//  HW3
//
//  Created by 鲁辰 on 7/4/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import "SecondTabViewController.h"

@implementation SecondTabViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (_isNotFirstTimeLoad == NO) {
        _isPhoto = YES;
        _isNotFirstTimeLoad = YES;
    }
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    }
}

- (IBAction)takePhoto:(id)sender {
    _isPhoto = true;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)takeVideo:(id)sender {
    _isPhoto = false;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.allowsEditing = NO;
        
        NSArray *mediaTypes = [[NSArray alloc]initWithObjects:(NSString *)kUTTypeMovie, nil];
        
        picker.mediaTypes = mediaTypes;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"I'm afraid there's no camera on this device!" delegate:nil cancelButtonTitle:@"Dang!" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction)saveAction:(id)sender {
    if (_isPhoto) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
        [self myOutput];
    } else {
        // save it to the Camera Roll
        UISaveVideoAtPathToSavedPhotosAlbum([_chosenMovie path], nil, nil, nil);
    }
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (_isPhoto) {
        UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
        _image = chosenImage;
        
        
        self.imageView.image = chosenImage;
        [picker dismissViewControllerAnimated:YES completion:NULL];
    } else {
        // grab our movie URL
        _chosenMovie = [info objectForKey:UIImagePickerControllerMediaURL];
        
        AVURLAsset* asset = [AVURLAsset URLAssetWithURL:_chosenMovie options:nil];
        AVAssetImageGenerator* imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
        imageGenerator.appliesPreferredTrackTransform = YES;
        CGImageRef cgImage = [imageGenerator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:nil error:nil];
        self.imageView.image = [UIImage imageWithCGImage:cgImage];
        
        // and dismiss the picker
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (NSURL*)grabFileURL:(NSString *)fileName {
    
    // find Documents directory
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    // append a file name to it
    documentsURL = [documentsURL URLByAppendingPathComponent:fileName];
    
    return documentsURL;
}

- (void) myOutput {
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *time = [dateFormatter stringFromDate: currentTime];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSString *tzName = [timeZone abbreviation];
    
    NSLog(@"chenlu: %@ %d.%d.%d : %@ %@", [UIDevice currentDevice].model, [[NSProcessInfo processInfo] operatingSystemVersion].majorVersion, [[NSProcessInfo processInfo] operatingSystemVersion].minorVersion, [[NSProcessInfo processInfo] operatingSystemVersion].patchVersion, time, tzName);
}

@end
