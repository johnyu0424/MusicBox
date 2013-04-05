//
//  MusicListViewController.h
//  FirstDropbox
//
//  Created by Peggy Chen on 2/27/13.
//  Copyright (c) 2013 tsungyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>
#import <AVFoundation/AVFoundation.h>

@class AVAudioPlayer;

@interface MusicListViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
{
    DBRestClient *restClient;
    //AVAudioPlayer *audioPlayer;
}

@property NSArray *fruits;
@property NSDictionary *alphabetizedFruits;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
- (IBAction)showSongs:(id)sender;
- (IBAction)deleteCache:(id)sender;


@end
