//
//  RequestViewController.m
//  Composer
//
//  Created by Prasad Pamidi on 3/12/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "RequestViewController.h"
#import "RequestLogFetcher.h"
#import "RequestLog.h"
#import "EntityManager.h"
#import "RequestDetailViewController.h"

@interface RequestViewController ()

@property (nonatomic, strong) NSArray *requestsArray;
@property (weak, nonatomic) IBOutlet UILabel *lbl_requestTime;
@property (weak, nonatomic) IBOutlet UILabel *lbl_requestType;

@end

@implementation RequestViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewWillAppear:(BOOL)animated{
    
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];

    _requestsArray = [[RequestLogFetcher fetcher] getAllRequests];
    
	[self.tableView reloadData];
    
}

-(void)refreshData
{
    _requestsArray = [[RequestLogFetcher fetcher] getAllRequests];
    
	[self.tableView reloadData];
    
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_requestsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RequestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    RequestLog *request = (RequestLog*)[_requestsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = request.requestURL;
    cell.detailTextLabel.text = request.requestDateTime;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RequestDetailViewController * requestDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([RequestDetailViewController class])];
    requestDetailVC.request = [_requestsArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:requestDetailVC animated: YES];
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
- (IBAction)clearRequests:(id)sender {
    NSArray *requestsArray = [[RequestLogFetcher fetcher] getAllRequests];
    [requestsArray enumerateObjectsUsingBlock:^(RequestLog* request, NSUInteger idx, BOOL *stop) {
        [[EntityManager entityManager] deleteEntity:request];
    }];
    
    _requestsArray = [[RequestLogFetcher fetcher] getAllRequests];
    
    [self.tableView reloadData];
}

@end
