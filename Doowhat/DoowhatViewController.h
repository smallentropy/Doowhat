//
//  DoowhatViewController.h
//  Doowhat
//
//  Created by Krzysztof Szczepaniak on 28/06/2013.
//  Copyright (c) 2013 Krzysztof Szczepaniak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoTableViewCellDelegate.h"

@interface DoowhatViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ToDoTableViewCellDelegate>

@end
