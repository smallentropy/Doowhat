//
//  DoowhatDataProvider.h
//  Doowhat
//
//  Created by Krzysztof Szczepaniak on 28/06/2013.
//  Copyright (c) 2013 Krzysztof Szczepaniak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoItem.h"

@interface DoowhatDataModel : NSObject

- (id)items;
- (NSUInteger)count;
- (NSUInteger)indexOfItem:(ToDoItem *)item;
- (ToDoItem *)itemAtIndex:(NSUInteger)index;

- (void)removeItemAtIndex:(NSUInteger)index;
- (void)removeItem:(ToDoItem *)item;

@end
