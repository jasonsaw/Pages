//
//  PhotosViewView.h
//  Pages
//
//  Created by mysoft on 11/20/14.
//  Copyright (c) 2014 mysoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosViewView : UIView

@property (nonatomic,strong) NSString *photoURL;

- (void)loadImage;
@end
