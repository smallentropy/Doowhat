//
//  ToDoItem.m
//  Doowhat
//
//  Created by Krzysztof Szczepaniak on 28/06/2013.
//  Copyright (c) 2013 Krzysztof Szczepaniak. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

- (id)initWithText:(NSString *)text {
    if (self = [super init]) {
        self.text = text;
    }
    return self;
}

+ (id)toDoItemWithText:(NSString *)text {
    return [[ToDoItem alloc] initWithText:text];
}

@end
