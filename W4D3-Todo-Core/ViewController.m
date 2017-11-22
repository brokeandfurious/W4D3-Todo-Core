//
//  ViewController.m
//  W4D3-Todo-Core
//
//  Created by Murat Ekrem Kolcalar on 11/22/17.
//  Copyright © 2017 murtilicious. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "TodoCell.h"
#import "Task+CoreDataProperties.h"

@interface ViewController () <UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSFetchedResultsController *fetchController;
@property (nonatomic) BOOL darkThemeOn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    self.darkThemeOn = NO;
            
    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchReq = [Task fetchRequest];
    fetchReq.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"taskTitle" ascending:YES] ];
    
    self.fetchController = [[NSFetchedResultsController alloc]
                            initWithFetchRequest:fetchReq managedObjectContext:appDel.persistentContainer.viewContext
                            sectionNameKeyPath:@"taskTitle"
                            cacheName:nil];
    
    self.fetchController.delegate = self;
    NSError *err = nil;
    if (![self.fetchController performFetch:&err] || err != nil) {
        NSLog(@"Error fetching: %@", err.localizedDescription);
        abort();
    }

}

- (void)printSaved
{
    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSFetchRequest *fetchReq = [Task fetchRequest];
    fetchReq.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"taskTitle" ascending:YES] ];
    NSError *err = nil;
    NSArray<Task*>* todos = [appDel.persistentContainer.viewContext
                             executeFetchRequest:fetchReq
                             error:&err];
    if (err != nil) {
        NSLog(@"Couldn't search %@", err.localizedDescription);
        abort();
    }
    NSLog(@"results: %@", todos);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fetchController.sections[section].numberOfObjects;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell"];
    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    cell.task = [self.fetchController objectAtIndexPath:indexPath];
    
//    [self performSegueWithIdentifier:@"segueToDetail" sender:indexPath];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(TodoCell *)sender
{
    if ([segue.identifier isEqualToString:@"segueToDetail"])
    {
//        NSIndexPath *indexPath = (NSIndexPath *)sender;
        DetailViewController *destViewController = segue.destinationViewController;
//        destViewController.task = [[Task alloc]init];
        [destViewController setTask:sender.task];
//        destViewController.task = sender.task;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.fetchController.sections[section].name;
}

/*
 Assume self has a property 'tableView' -- as is the case for an instance of a UITableViewController
 subclass -- and a method configureCell:atIndexPath: which updates the contents of a given cell
 with information from a managed object at the given index path in the fetched results controller.
 */

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            //            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
            //                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (IBAction)changeTheme:(id)sender {
    [self darkTheme];
}

- (void) darkTheme { //TEST
    if (!self.darkThemeOn) {
        self.view.backgroundColor = [UIColor blackColor];
        self.view.tintColor = [UIColor redColor];
        self.tableView.backgroundColor = [UIColor blackColor];
        self.tableView.tintColor = [UIColor redColor];
        self.tableView.sectionIndexBackgroundColor = [UIColor blackColor];
        self.tableView.sectionIndexColor = [UIColor orangeColor];
        self.tableView.sectionIndexTrackingBackgroundColor = [UIColor orangeColor];
        self.tableView.separatorColor = [UIColor brownColor];
        self.darkThemeOn = YES;
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.tintColor = [UIColor blueColor];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.tintColor = [UIColor blueColor];
        self.darkThemeOn = NO;
    }
}

@end
