//
//  ToDoItem.h
//  Doowhat
//
//  Created by Krzysztof Szczepaniak on 28/06/2013.
//  Copyright (c) 2013 Krzysztof Szczepaniak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic) BOOL completed;

- (id)initWithText:(NSString *)text;
+ (id)toDoItemWithText:(NSString *)text;

@end
