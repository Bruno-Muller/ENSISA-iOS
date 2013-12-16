//
//  RadiosViewController.m
//  Projet Muller (Monôme)
//
//  Created by Bruno Muller on 16/12/2013.
//  Copyright (c) 2013 Muller Bruno. All rights reserved.
//

#import "RadiosViewController.h"
#import "AppDelegate.h"
#import "RadioViewController.h"

@interface RadiosViewController ()

@end

@implementation RadiosViewController

- (NSArray *)allRadios
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Radio" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        NSLog(@"There was an error!");
    }
    
    return objects;
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self allRadios] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    NSManagedObject *radio = [[self allRadios] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [radio valueForKey:@"name"];
    cell.detailTextLabel.text = [radio valueForKey:@"category"];
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

-(IBAction)createRadio:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *radio = [NSEntityDescription insertNewObjectForEntityForName:@"Radio" inManagedObjectContext:context];
    
    [radio setValue:@"unamed" forKeyPath:@"name"];
    [radio setValue:@"uncategorized" forKeyPath:@"category"];
    [radio setValue:@"http://" forKeyPath:@"url"];
    
    [appDelegate saveContext];
    
    [self.tableView reloadData];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RadioViewController *controller = segue.destinationViewController;
    controller.radio = [[self allRadios] objectAtIndex:[self.tableView indexPathForCell:sender].row];
}

@end
