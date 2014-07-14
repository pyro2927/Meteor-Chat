//
//  ChatListingTableViewController.m
//  MeteorChat
//
//  Created by Joseph Pintozzi on 7/14/14.
//  Copyright (c) 2014 pyro2927. All rights reserved.
//

#import "ChatListingTableViewController.h"
#import "CometChatSessionManager.h"
#import "CometChatViewController.h"

@interface ChatListingTableViewController () {
    NSMutableArray *users;
    NSMutableArray *rooms;
}

@end

@implementation ChatListingTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authenticationComplete) name:@"authenticated" object:nil];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    see if we're missing our base token
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"base_token"] || [[NSUserDefaults standardUserDefaults] objectForKey:@"base_token"] == [NSNull null]) {
        UIViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController presentViewController:loginViewController animated:YES completion:^{
            
        }];
    }
}

- (void)authenticationComplete{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [[CometChatSessionManager sharedClient] receiveWithTimestamp:nil completion:^(id object, NSError *error) {
            if (!error) {
                NSLog(@"%@", object);
                users = object[@"buddylist"];
                [self.tableView reloadData];
            }
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return (section == 0 ? [users count] : [rooms count]);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *user = users[indexPath.row];
    cell.textLabel.text = user[@"n"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[[CometChatViewController alloc] init] animated:YES];
}

@end
