//
//  StrikethroughLabel.m
//  Doowhat
//
//  Created by Krzysztof Szczepaniak on 29/06/2013.
//  Copyright (c) 2013 Krzysztof Szczepaniak. All rights reserved.
//

#import "StrikethroughLabel.h"
#import <QuartzCore/QuartzCore.h>

#define kLineThickness 2.0f

@interface StrikethroughLabel ()

@property (nonatomic, strong) CALayer *strikethroughLayer;

@end

@implementation StrikethroughLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _strikethroughLayer = [CALayer layer];
        _strikethroughLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _strikethroughLayer.hidden = YES;
        [self.layer addSublayer:_strikethroughLayer];
    }
    return self;
}

- (void)resizeStrikethrough {
    CGSize textSize = [self.text sizeWithFont:self.font];
    self.strikethroughLayer.frame = CGRectMake(0, self.bounds.size.height / 2.0f, textSize.width, kLineThickness);
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self resizeStrikethrough];
}

- (void)setStrikethrough:(BOOL)strikethrough {
    _strikethrough = strikethrough;
    _strikethroughLayer.hidden = !strikethrough;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self resizeStrikethrough];
}

@end
