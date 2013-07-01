//
//  DoowhatTableViewCellDelegate.h
//  Doowhat
//
//  Created by Krzysztof Szczepaniak on 28/06/2013.
//  Copyright (c) 2013 Krzysztof Szczepaniak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoItem.h"

@protocol ToDoTableViewCellDelegate <NSObject>

- (void)todoItemDeleted:(ToDoItem *)item;

@end
