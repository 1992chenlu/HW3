//
//  MyRootViewController.m
//  HW3
//
//  Created by 鲁辰 on 7/4/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import "MyRootViewController.h"
#import "PageViewControllerData.h"
#import "MyPageViewController.h"

@implementation MyRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    
    ALAssetsLibrary *notificationSender = nil;
    
    if (self.assetsLibrary == nil) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    
    NSString *minimumSystemVersion = @"4.1";
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    if ([systemVersion compare:minimumSystemVersion options:NSNumericSearch] != NSOrderedAscending)
        notificationSender = _assetsLibrary;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(assetsLibraryDidChange:) name:ALAssetsLibraryChangedNotification object:notificationSender];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateAssetsLibrary];
}

#pragma mark - UITableViewDataSource

// determine the number of rows in the table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.assets.count;
}

// determine the appearance of table view cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // load the asset for this cell
    ALAsset *asset = self.assets[indexPath.row];
    CGImageRef thumbnailImageRef = [asset thumbnail];
    UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];
    
    cell.imageView.image = thumbnail;
    if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
        // asset is a video
        cell.textLabel.text = @"Video";
    } else {
        cell.textLabel.text = @"Photo";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *time = [dateFormatter stringFromDate: [asset valueForProperty:ALAssetPropertyDate]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", time];
    
    return cell;
}

- (void)assetsLibraryDidChange:(NSNotification*)changeNotification
{
    //[self updateAssetsLibrary];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        
        // hand off the assets of this album to our singleton data source
        [PageViewControllerData sharedInstance].assets = self.assets;
        
        // start viewing the image at the appropriate cell index
        NSIndexPath *selectedCellIndex = [self.tableView indexPathForSelectedRow];
        
        MyPageViewController *myPageViewController = [segue destinationViewController];
        myPageViewController.startingIndex = selectedCellIndex.row;
        

    }
}

- (void) updateAssetsLibrary {
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allAssets];
        [group setAssetsFilter:onlyPhotosFilter];
        if ([group numberOfAssets] > 0)
        {
            _assetsGroup = group;
            
            self.title = [group valueForProperty:ALAssetsGroupPropertyName];
            
            if (!self.assets) {
                _assets = [[NSMutableArray alloc] init];
            } else {
                [self.assets removeAllObjects];
            }
            
            ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
                
                if (result) {
                    [self.assets addObject:result];
                }
            };
            
            ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allAssets];
            [group setAssetsFilter:onlyPhotosFilter];
            [group enumerateAssetsUsingBlock:assetsEnumerationBlock];
        } else {
            //this line will load the content of the table when first time appear
            [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
    };
    
    NSUInteger groupTypes = ALAssetsGroupSavedPhotos;
    [self.assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:nil];
    
    [self.tableView reloadData];
}

@end
