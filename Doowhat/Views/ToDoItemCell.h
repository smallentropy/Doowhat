//
//  ToDoItemCell.h
//  Doowhat
//
//  Created by Krzysztof Szczepaniak on 28/06/2013.
//  Copyright (c) 2013 Krzysztof Szczepaniak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoTableViewCellDelegate.h"

@interface ToDoItemCell : UITableViewCell <UIGestureRecognizerDelegate>

@property (nonatomic, weak) ToDoItem *item;
@property (nonatomic, weak) id<ToDoTableViewCellDelegate> delegate;

@end
