//
//  BusPlanViewController.m
//  NewREDIApp
//
//  Created by Administrator on 4/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BusPlanViewController.h"


@implementation BusPlanViewController


@synthesize del;
@synthesize dc;
@synthesize infoCell;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
//self.partsOfPlan = [NSArray arrayWithObjects:@"Type of Business",@"Office Needed",@"Personnel Needed",@"Professional Services",@"Future Plans",@"Customers",@"Industry Trends",@"Competition",@"Advantages",@"Disadvantages",nil];
	NSMutableArray* array = [self.dc.db getInputFieldsForSection:0 BusinessID:self.dc.curBusID];
	self.dc.partsOfPlan = array;
	[array release];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
 //   return [self.partsOfPlan count];
	return [self.dc.partsOfPlan count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"InfoCell";
    InfoCell* cell = (InfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"InfoCell" owner:self options:nil];
		cell = infoCell;
		
    }
    
	
    // Configure the cell...
	NSString* s = [self.dc.partsOfPlan objectAtIndex:indexPath.row];
	NSString* info = [self.dc.db getDataForFieldName:s andBusID:self.dc.curBusID];
	cell.title.text =  s;
	cell.info.text = info;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InputViewController *detailViewController = [[InputViewController alloc] initWithNibName:@"InputViewController" bundle:nil];
    self.dc.fieldName = [self.dc.partsOfPlan objectAtIndex:indexPath.row];
	detailViewController.title = self.dc.fieldName;
	detailViewController.dc = self.dc;
	detailViewController.table = tableView;
	
	UINavigationController *tmpNavController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
	[detailViewController release];
	[self.del.navigationController presentModalViewController:tmpNavController animated:YES];
	[tmpNavController release];
    
	//[del presentModalViewController:detailViewController animated:YES];
   // [del.navigationController pushViewController:detailViewController animated:YES];
   
    
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
	NSLog(@"MemoryWarning");
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

