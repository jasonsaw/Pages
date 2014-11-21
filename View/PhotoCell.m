//
//  PhotoCell.m
//  Pages
//
//  Created by mysoft on 11/19/14.
//  Copyright (c) 2014 mysoft. All rights reserved.
//

#import "PhotoCell.h"
#import "CommomDefind.h"

@implementation PhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (!self.photoImage) {
            self.photoImage = [[UIImageView alloc] initWithFrame:self.bounds];
            [self.contentView addSubview:self.photoImage];
        }
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressEvent)];
        [self.contentView addGestureRecognizer:longPress];
    }
    return self;
}

- (void)longPressEvent
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(longPressEvent:)]) {
        [self.delegate longPressEvent:self];
    }
}

- (void)createView
{
    if (!self.photoImage) {
        self.photoImage = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.photoImage];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
