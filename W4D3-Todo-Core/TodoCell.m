//
//  TodoCell.m
//  W4D3-Todo-Core
//
//  Created by Murat Ekrem Kolcalar on 11/22/17.
//  Copyright © 2017 murtilicious. All rights reserved.
//

#import "TodoCell.h"

@interface TodoCell()
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@end

@implementation TodoCell


- (void)setTask:(Task *)task {
    self.cellLabel.text = task.taskTitle;
    _task = task;
}

@end
