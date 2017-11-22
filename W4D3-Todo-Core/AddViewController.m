//
//  AddViewController.m
//  W4D3-Todo-Core
//
//  Created by Murat Ekrem Kolcalar on 11/22/17.
//  Copyright © 2017 murtilicious. All rights reserved.
//

#import "AddViewController.h"
#import "AppDelegate.h"
#import "Task+CoreDataProperties.h"

@interface AddViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *detailsField;
@property (weak, nonatomic) IBOutlet UITextField *priorityField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;

@end

@implementation AddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textField.delegate = self;
    
}

- (IBAction)saveTask:(id)sender
{
    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    Task *newTask = [[Task alloc] initWithContext:appDel.persistentContainer.viewContext];
    newTask.isCompleted = NO;
    newTask.taskTitle = self.textField.text;
    newTask.taskDetails = self.detailsField.text;
    newTask.taskPriority = [self.priorityField.text intValue];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.hidden = NO;
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [self.dateField setInputView:datePicker];
    
    [appDel saveContext];
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Name: %@, Details: %@, Priority: %i", newTask.taskTitle, newTask.taskDetails, newTask.taskPriority);
    }];
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateField.inputView;
    self.dateField.text = [NSString stringWithFormat:@"%@",picker.date];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
