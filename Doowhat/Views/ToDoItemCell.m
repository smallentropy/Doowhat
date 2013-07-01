//
//  ToDoItemCell.m
//  Doowhat
//
//  Created by Krzysztof Szczepaniak on 28/06/2013.
//  Copyright (c) 2013 Krzysztof Szczepaniak. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ToDoItemCell.h"
#import "StrikethroughLabel.h"

#define kLeftMargin     15.0f
#define kCueLabelSize   24.0f
#define kCueLabelMargin 10.0f
#define kCueLabelWidth  50.0f

@interface ToDoItemCell ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CALayer *itemCompletedLayer;
@property (nonatomic, assign) CGPoint originalCenter;
@property (nonatomic, strong) StrikethroughLabel *label;

@property (nonatomic, strong) UIGestureRecognizer *recognizer;
@property (nonatomic, assign) BOOL deleteOnDragRelease;
@property (nonatomic, assign) BOOL completeOnDragRelease;

@property (nonatomic, strong) UILabel *tickLabel;
@property (nonatomic, strong) UILabel *deleteLabel;

@end

@implementation ToDoItemCell

- (void)setupLayer {
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.bounds = self.bounds;
    self.gradientLayer.colors = @[
                              (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                              (id)[UIColor colorWithWhite:1.0f alpha:0.1f].CGColor,
                              (id)[UIColor clearColor].CGColor,
                              (id)[UIColor colorWithWhite:0.0f alpha:0.1f].CGColor
                              ];
    self.gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
    [self.layer addSublayer:self.gradientLayer];
}

- (void)setupLabel {
    self.label = [[StrikethroughLabel alloc] initWithFrame:self.textLabel.bounds];
    self.label.font = [UIFont systemFontOfSize:16.0f];
    self.label.textColor = [UIColor whiteColor];
    self.label.backgroundColor = [UIColor clearColor];
    [self addSubview:self.label];
}

- (void)setupCompletedLayer {
    self.itemCompletedLayer = [CALayer layer];
    self.itemCompletedLayer.backgroundColor = [UIColor colorWithRed:0.0f green:0.6f blue:0.0f alpha:1.0f].CGColor;
    self.itemCompletedLayer.hidden = YES;
    [self.layer insertSublayer:self.itemCompletedLayer atIndex:0];
}

- (UILabel *)createCueLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectNull];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:kCueLabelSize];
    return label;
}

- (void)setupCueLabels {
    self.tickLabel = [self createCueLabel];
    self.tickLabel.text = @"\u2713";
    self.tickLabel.textAlignment = NSTextAlignmentRight;
    
    self.deleteLabel = [self createCueLabel];
    self.deleteLabel.text = @"\u2717";
    self.deleteLabel.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:self.tickLabel];
    [self addSubview:self.deleteLabel];
}

- (void)setupRecognizer {
    self.recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.recognizer.delegate = self;
    [self addGestureRecognizer:_recognizer];
}

- (void)setupUI {
    [self setupLayer];
    [self setupLabel];
    [self setupCueLabels];
    [self setupCompletedLayer];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        [self setupRecognizer];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setItem:(ToDoItem *)item {
    _item = item;
    _label.text = item.text;
    _label.strikethrough = item.completed;
    _itemCompletedLayer.hidden = !item.completed;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    _gradientLayer.frame = bounds;
    _itemCompletedLayer.frame = bounds;
    _label.frame = CGRectMake(kLeftMargin, 0.0f, bounds.size.width - kLeftMargin, bounds.size.height);
    _tickLabel.frame = CGRectMake(-kCueLabelWidth - kCueLabelMargin, 0, kCueLabelWidth, bounds.size.height);
    _deleteLabel.frame = CGRectMake(bounds.size.width + kCueLabelMargin, 0, kCueLabelWidth, bounds.size.height);
}

#pragma mark - UIGestureRecognizer Delegate Methods
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {    
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return NO;
    }
    
    CGPoint translation = [gestureRecognizer translationInView:[self superview]];
    
    // Checking for horizontal gesture
    if (fabsf(translation.x) > fabsf(translation.y)) {
        return YES;
    }
    
    return NO;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.originalCenter = self.center;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self];
        self.center = CGPointMake(self.originalCenter.x + translation.x, self.originalCenter.y);
        
        // Checking if the cell is so far right it has to be deleted
        self.deleteOnDragRelease = self.frame.origin.x < -self.frame.size.width / 2.0f;
        
        // Checking if the cell is so far left it has to be completed
        self.completeOnDragRelease = self.frame.origin.x > self.frame.size.width / 2.0f;
        
        float cueLabelAlpha = fabsf((self.frame.origin.x) / (self.frame.size.width / 2.0f));
        self.tickLabel.alpha = cueLabelAlpha;
        self.deleteLabel.alpha = cueLabelAlpha;
        
        self.tickLabel.textColor = self.completeOnDragRelease ? [UIColor greenColor] : [UIColor whiteColor];
        self.deleteLabel.textColor = self.deleteOnDragRelease ? [UIColor redColor] : [UIColor whiteColor];
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (!self.deleteOnDragRelease) {
            [UIView animateWithDuration:0.2f animations:^{
                // Setting original frame of cell
                self.frame = CGRectMake(0, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
            }];
        } else {
            [UIView animateWithDuration:0.2f animations:^{
                self.center = CGPointMake(-self.originalCenter.x * 2, self.originalCenter.y);
            } completion:^(BOOL finished) {
                [self.delegate todoItemDeleted:self.item];
            }];
        }
        
        if (self.completeOnDragRelease) {
            self.item.completed = YES;
            self.label.strikethrough = YES;
            self.itemCompletedLayer.hidden = NO;
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

@end
