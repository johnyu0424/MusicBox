//
//  DropboxViewController.m
//  FirstDropbox
//
//  Created by Peggy Chen on 2/26/13.
//  Copyright (c) 2013 tsungyen. All rights reserved.
//

#import "DropboxViewController.h"

@interface DropboxViewController ()

@end

@implementation DropboxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)didPressLink:(id)sender {
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(DBRestClient *)restClient
{
    if(!restClient)
    {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = (id)self;
    }
    
    return restClient;
}
@end
