//
//  DetailViewController.h
//  W4D3-Todo-Core
//
//  Created by Murat Ekrem Kolcalar on 11/22/17.
//  Copyright © 2017 murtilicious. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task+CoreDataProperties.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Task *task;

// declare a Task here and set it from prepareForSegue

@end
