//
//  DoowhatDataProvider.m
//  Doowhat
//
//  Created by Krzysztof Szczepaniak on 28/06/2013.
//  Copyright (c) 2013 Krzysztof Szczepaniak. All rights reserved.
//

#import "DoowhatDataModel.h"

@interface DoowhatDataModel ()

@property (nonatomic, strong) NSMutableArray *model;

@end

@implementation DoowhatDataModel

- (id)init {
    if (self = [super init]) {
        [self initModel];
    }
    return self;
}

- (void)initModel {
    self.model = [NSMutableArray arrayWithArray:@[
                     [ToDoItem toDoItemWithText:@"Feed the cat"],
                     [ToDoItem toDoItemWithText:@"Buy eggs"],
                     [ToDoItem toDoItemWithText:@"Pack bags for WWDC"],
                     [ToDoItem toDoItemWithText:@"Rule the web"],
                     [ToDoItem toDoItemWithText:@"Get an iPhone 5"],
                     [ToDoItem toDoItemWithText:@"Master Objective-C"],
                     [ToDoItem toDoItemWithText:@"Learn to draw"],
                     [ToDoItem toDoItemWithText:@"Write a presentation"],
                     [ToDoItem toDoItemWithText:@"Watch WWDC videos"],
                     [ToDoItem toDoItemWithText:@"Learn Ruby"],
                     [ToDoItem toDoItemWithText:@"Learn Ruby On Rails"],
                     [ToDoItem toDoItemWithText:@"Find missing socks"]
                 ]];
}

- (id)items {
    return self.model;
}

- (NSUInteger)count {
    return self.model.count;
}

- (NSUInteger)indexOfItem:(ToDoItem *)item {
    return [self.model indexOfObject:item];
}

- (ToDoItem *)itemAtIndex:(NSUInteger)index {
    return [self.model objectAtIndex:index];
}

- (void)removeItemAtIndex:(NSUInteger)index {
    [self.model removeObjectAtIndex:index];
}

- (void)removeItem:(ToDoItem *)item {
    [self.model removeObject:item];
}

@end
