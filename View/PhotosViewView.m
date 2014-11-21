//
//  PhotosViewView.m
//  Pages
//
//  Created by mysoft on 11/20/14.
//  Copyright (c) 2014 mysoft. All rights reserved.
//

#import "PhotosViewView.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotosViewView()

@property (nonatomic,strong) UIImageView *photoImageV;
@end

@implementation PhotosViewView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadImage
{
    if (!self.photoImageV) {
        self.photoImageV = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.photoImageV];
    }
    [self getFullScreenPhotoImage];
}


- (void)getFullScreenPhotoImage
{
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    NSURL *url=[NSURL URLWithString:self.photoURL];
    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
        self.photoImageV.image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        
    }failureBlock:^(NSError *error) {
        NSLog(@"error=%@",error);
    }];
}


@end
