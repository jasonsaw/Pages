//
//  PagesDetailViewController.m
//  Pages
//
//  Created by mysoft on 11/19/14.
//  Copyright (c) 2014 mysoft. All rights reserved.
//

#import "PhotosViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoCell.h"
#import "CommomDefind.h"
#import "PhotosViewViewController.h"

#define kPhotoCellWidth kScreenWidth/4-9

@interface PhotosViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,PhototCellDelegate>
{
    NSMutableArray *_photosThumbNailArray;
    NSMutableArray *_photosURLArray;
}

@property (nonatomic,strong) UICollectionView *collocetionView;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片列表";
    _photosThumbNailArray = [[NSMutableArray alloc] init];
    _photosURLArray = [[NSMutableArray alloc] init];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collocetionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collocetionView.delegate = self;
    self.collocetionView.dataSource = self;
    self.collocetionView.backgroundColor = [UIColor whiteColor];
    [self.collocetionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"photoCell"];
    
    [self.view addSubview:self.collocetionView];

    [self getImageFromAublm];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getImageFromAublm
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror){
            NSLog(@"相册访问失败 =%@", [myerror localizedDescription]);
            if ([myerror.localizedDescription rangeOfString:@"Global denied access"].location!=NSNotFound) {
                NSLog(@"无法访问相册.请在'设置->定位服务'设置为打开状态.");
            }else{
                NSLog(@"相册访问失败.");
            }
        };
        
        ALAssetsGroupEnumerationResultsBlock groupEnumerAtion = ^(ALAsset *result, NSUInteger index, BOOL *stop){
            if (result!=NULL) {
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    NSString *urlstr=[NSString stringWithFormat:@"%@",result.defaultRepresentation.url];//图片的url
                    UIImage *photoThumNail = [UIImage imageWithCGImage:result.thumbnail];
                    [_photosThumbNailArray addObject:photoThumNail];
                    [_photosURLArray addObject:urlstr];
                }
            }
            
        };
        
        ALAssetsLibraryGroupsEnumerationResultsBlock
        libraryGroupsEnumeration = ^(ALAssetsGroup* group,BOOL* stop){
            
            if (group == nil)
            {
                [self.collocetionView reloadData];
            }
            
            if (group!=nil) {
                NSString *g=[NSString stringWithFormat:@"%@",group];//获取相簿的组
                NSLog(@"gg:%@",g);//gg:ALAssetsGroup - Name:Camera Roll, Type:Saved Photos, Assets count:71
                
                NSString *g1=[g substringFromIndex:16 ] ;
                NSArray *arr=[NSArray arrayWithArray:[g1 componentsSeparatedByString:@","]];
                NSString *g2=[[arr objectAtIndex:0]substringFromIndex:5];
                if ([g2 isEqualToString:@"Camera Roll"]) {
                    g2=@"相机胶卷";
                }
//                NSString *groupName=g2;//组的name
                
                [group enumerateAssetsUsingBlock:groupEnumerAtion];
            }
        };
        
        ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
        [library enumerateGroupsWithTypes:ALAssetsGroupAll
                              usingBlock:libraryGroupsEnumeration
                            failureBlock:failureblock];
    });
}

#pragma mark UIColloectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"count = [%ld]",_photosThumbNailArray.count);
    return _photosThumbNailArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *photoCell = (PhotoCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    photoCell.delegate = self;
//    [photoCell sizeToFit];
    UIImageView *imagev = [[UIImageView alloc] initWithImage:[_photosThumbNailArray objectAtIndex:indexPath.row]];
    imagev.frame = photoCell.bounds;
    [photoCell.contentView addSubview:imagev];
    photoCell.layer.borderWidth = 0.5f;
    photoCell.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
    photoCell.layer.shadowColor = [UIColor colorWithWhite:0.3 alpha:0.8].CGColor;
    photoCell.layer.shadowRadius = 2;
    return photoCell;
}

//设置元素的的大小框

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section

{
    
    UIEdgeInsets top = {5,2,5,0};
    
    return top;
    
}
//
//
////设置顶部的大小
//
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section

{
    
    CGSize size={50,10};
    
    return size;
    
}

//设置元素大小

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    return CGSizeMake(kPhotoCellWidth,kPhotoCellWidth);
    
}


//点击元素触发事件

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"section = %ld,row = %ld",indexPath.section,indexPath.row);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PhotosViewViewController *photosViewCtr = [storyboard instantiateViewControllerWithIdentifier:@"photosViewViewController"];
    photosViewCtr.modalPresentationStyle = UIModalPresentationFullScreen;
    photosViewCtr.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    photosViewCtr.photoURLArray = _photosURLArray;
    photosViewCtr.tapPhotoIndex = indexPath.row;
    [self presentViewController:photosViewCtr animated:YES completion:nil];
}

- (void)longPressEvent:(UICollectionViewCell*)cell
{
    NSIndexPath *indexPath = [self.collocetionView indexPathForCell:cell];
    NSLog(@"longPressEvent: section = %ld,row = %ld",indexPath.section,indexPath.row);
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
