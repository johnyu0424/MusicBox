//
//  MusicListViewController.m
//  FirstDropbox
//
//  Created by Peggy Chen on 2/27/13.
//  Copyright (c) 2013 tsungyen. All rights reserved.
//

#import "MusicListViewController.h"

@interface MusicListViewController ()
@property NSArray *songN;
@property NSString *songURL;

@end



@implementation MusicListViewController
{
    NSMutableArray *songs;
}

@synthesize songURL = _songURL;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    NSArray* validExtensions = [NSArray arrayWithObjects:@"mp3", nil];
    for (DBMetadata* child in metadata.contents) {
        NSString* extension = [[child.path pathExtension] lowercaseString];
        if ([validExtensions indexOfObject:extension] != NSNotFound) {
            NSLog(@"\t%@", child.filename);
            //_songs  = [[NSMutableArray alloc] init];
            [songs addObject:child.filename];
            NSLog(@"\t%@", songs);
            NSLog(@"%lu", (unsigned long)[songs count]);
            
        }
    }
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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.songN = @[@"Song1",@"Song2",@"Song3",@"Song4"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    songs  = [[NSMutableArray alloc] initWithCapacity:20];
    [[self restClient] loadMetadata:@"/"];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *s = [self.songN objectAtIndex:[indexPath row]];
    [cell.textLabel setText:s];
    
//    UILabel *label1 = (UILabel *)[cell viewWithTag:1];
//    UILabel *label2 = (UILabel *)[cell viewWithTag:2];
//    UILabel *label3 = (UILabel *)[cell viewWithTag:3];
//    UILabel *label4 = (UILabel *)[cell viewWithTag:4];
//    label1.text = @"Song 1";
//    label2.text = @"Song 2";
//    label3.text = @"Song 3";
//    label4.text = @"Song 4";
    
    return cell;
    
    
    
    
//    static NSString *CellIdentifier = @"Cell Identifier";
//    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    // Fetch Fruit
//    //NSString *fruit = [songs objectAtIndex:[indexPath row]];
//    //[cell.textLabel setText:songs.accessibilityValue];
//    [cell.textLabel setText:@"Song1"];
//    
//    NSLog(@"\t%@", songs);
//    //NSLog(@"\t%@", [songs objectAtIndex:1]);
//    NSLog(@"*****%lu", (unsigned long)[songs count]);
//    
//    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *keys = [[self.alphabetizedFruits allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [keys objectAtIndex:section];
    return key;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *fruit = [self.songN objectAtIndex:[indexPath row]];
    NSLog(@"Fruit Selected > %@", fruit);
    NSString *songPath = [fruit stringByAppendingString:@".mp3"];
        NSLog(@"I am in here");
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:songPath];
        
        NSString *dbPath = [@"/" stringByAppendingString:songPath];
        [self.restClient loadFile:dbPath intoPath:filePath];
        NSLog(@"%@",filePath);
        
//        if (filePath) { // check if file exists - if so load it:
//            NSString *tempTextOut = [NSString stringWithContentsOfFile:filePath
//                                                              encoding:NSUTF8StringEncoding
//                                                                 error:&error];
//            NSLog(@"%@",tempTextOut);
//        }
    
        // Convert the file path to a URL.
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:filePath];
        NSLog(@"%@",fileURL);
        
        //Initialize the AVAudioPlayer.
        self.audioPlayer = [[AVAudioPlayer alloc]
                            initWithContentsOfURL:fileURL error:nil];
        
        // Preloads the buffer and prepares the audio for playing.
        [self.audioPlayer prepareToPlay];
        
        self.audioPlayer.currentTime = 0;
    [self.audioPlayer play];
    
    
}

- (IBAction)showSongs:(id)sender {
    NSLog(@"\t%@", songs);
    NSLog(@"\t%@", [songs objectAtIndex:1]);
    NSLog(@"---------%lu", (unsigned long)[songs count]);
}

-(NSString *)documentsDirectory
{
    return [@"~/Documents" stringByExpandingTildeInPath];
}

-(NSString *)dataFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Checklist.plist"];
}

- (IBAction)deleteCache:(id)sender {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList = [manager contentsOfDirectoryAtPath:[self documentsDirectory] error:nil];
    NSLog(@"Before Deletion");
    for (NSString *s in fileList){
        NSLog(@"\t%@", s);
    }
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:[[self documentsDirectory] stringByAppendingPathComponent:@"Song1.mp3"]];
    [manager removeItemAtURL:fileURL error:nil];
    
    fileURL = [[NSURL alloc] initFileURLWithPath:[[self documentsDirectory] stringByAppendingPathComponent:@"Song2.mp3"]];
    [manager removeItemAtURL:fileURL error:nil];
    
    fileURL = [[NSURL alloc] initFileURLWithPath:[[self documentsDirectory] stringByAppendingPathComponent:@"Song3.mp3"]];
    [manager removeItemAtURL:fileURL error:nil];
    
    fileURL = [[NSURL alloc] initFileURLWithPath:[[self documentsDirectory] stringByAppendingPathComponent:@"Song4.mp3"]];
    [manager removeItemAtURL:fileURL error:nil];
    
    fileList = [manager contentsOfDirectoryAtPath:[self documentsDirectory] error:nil];
    NSLog(@"After Deletion");
    for (NSString *s in fileList){
        NSLog(@"\t%@", s);
    }
    
}


@end
