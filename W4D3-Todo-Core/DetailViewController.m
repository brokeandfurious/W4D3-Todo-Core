//
//  DetailViewController.m
//  W4D3-Todo-Core
//
//  Created by Murat Ekrem Kolcalar on 11/22/17.
//  Copyright © 2017 murtilicious. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleOnDVC;
@property (weak, nonatomic) IBOutlet UILabel *descriptionOnDVC;
@property (weak, nonatomic) IBOutlet UILabel *priorityOnDVC;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleOnDVC.text = self.task.taskTitle;
    self.descriptionOnDVC.text = self.task.taskDetails;
    
    if (self.task.taskPriority >=2) {
        self.priorityOnDVC.textColor = [UIColor redColor];
    } else {
        self.priorityOnDVC.textColor = [UIColor greenColor];
    }
}

- (IBAction)taskCompletion:(id)sender {
    if (!self.task.isCompleted) {
        self.task.isCompleted = YES;
    } else {
        self.task.isCompleted = NO;
    }
}
@end
