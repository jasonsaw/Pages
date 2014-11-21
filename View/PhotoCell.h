//
//  PhotoCell.h
//  Pages
//
//  Created by mysoft on 11/19/14.
//  Copyright (c) 2014 mysoft. All rights reserved.
//

#import <UIKit/UIKit.h> 

@protocol PhototCellDelegate;
@interface PhotoCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *photoImage;
@property (nonatomic,assign) id<PhototCellDelegate> delegate;
- (void)createView;
@end

@protocol PhototCellDelegate <NSObject>

@optional
- (void)longPressEvent:(UICollectionViewCell*)cell;

@end