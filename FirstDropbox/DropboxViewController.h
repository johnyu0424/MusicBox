//
//  DropboxViewController.h
//  FirstDropbox
//
//  Created by Peggy Chen on 2/26/13.
//  Copyright (c) 2013 tsungyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface DropboxViewController : UIViewController
{
    DBRestClient *restClient;
}
- (IBAction)didPressLink:(id)sender;

@end
